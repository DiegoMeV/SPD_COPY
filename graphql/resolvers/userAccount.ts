import { Resolver, Query, Mutation, Arg, Int, FieldResolver, Root, Ctx } from "type-graphql";
import { SPDResolver } from "./spdResolver";
import {
  UserAccount,
  CreateUserAccount,
  UpdateUserAccount,
  LoginUserAccount,
  ChangeUserAccountPassword,
  Entity,
  UserLoggedIn,
  Tenant,
} from "../types";
import prisma from "../../lib/prisma";
import { Prisma } from "@prisma/client";
import sha256 from "crypto-js/sha256";
import {
  AdminChangeUserAccountPassword,
  SearchUserAccount,
  SearchUserAccountResponse,
} from "../types/userAccount";
import { createJWT } from "../../util";
import type { Context } from "../types/common";

@Resolver(() => UserAccount)
export class UserAccountResolver extends SPDResolver {
  @FieldResolver(() => Entity, { nullable: true })
  async entity(@Root() userAccount: UserAccount): Promise<Entity | null> {
    if (userAccount.entityId)
      return prisma.userAccount
        .findUnique({
          where: {
            id: userAccount.id,
          },
        })
        .entity();
    return null;
  }

  @FieldResolver(() => Tenant)
  async tenant(@Root() userAccount: UserAccount): Promise<Tenant | null> {
    return prisma.userAccount
      .findUnique({
        where: {
          id: userAccount.id,
        },
      })
      .tenant();
  }

  @Query(() => [UserAccount])
  async getUserAccounts(@Ctx() ctx: Context): Promise<UserAccount[]> {
    const result = await prisma.userAccount.findMany({
      where: {
        tenantId: this.getContextTenantId(ctx),
      },
    });
    return result;
  }

  @Query(() => UserAccount, { nullable: true })
  async getUserAccount(@Arg("id", () => Int) id: number): Promise<UserAccount | null> {
    return await prisma.userAccount.findUnique({ where: { id } });
  }

  @Query(() => UserLoggedIn, { nullable: true })
  async userLogin(@Arg("data") data: LoginUserAccount): Promise<UserLoggedIn | null> {
    const user = await prisma.userAccount.findUnique({
      include: {
        tenant: {
          select: { key: true, name: true },
        },
        entity: {
          select: { hasManualBudget: true, name: true },
        },
      },
      where: {
        uqUserTenantEmail: {
          tenantId: data.tenantId,
          email: data.email,
        },
      },
    });

    if (!user) {
      const error = "Cuenta de usuario no existe";
      console.error(`[Query:userLogin] ${error}`);
      throw new Error(error);
    }
    const { password, ...userData } = user;
    if (!userData.isActive) {
      const error = "Usuario inactivo";
      console.error(`[Query:userLogin] ${error}`);
      throw new Error(error);
    }
    if (password !== sha256(data.password).toString()) {
      const error = "Usuario o clave no coinciden";
      console.error(`[Query:userLogin] ${error}`);
      throw new Error(error);
    }

    // augment the response object with a JWT generated for the LoggedIn User
    return { ...userData, token: createJWT(userData) };
  }

  @Query(() => UserLoggedIn, { nullable: true })
  async refreshToken(@Ctx() ctx: Context): Promise<UserLoggedIn | null> {
    const authUser = ctx.tokenExpiredData ?? ctx.user;
    if (!authUser?.id) {
      const error = "Se requiere un token para realizar la operacion";
      console.error(`[Query:refreshToken] ${error}`);
      throw new Error(error);
    }

    // look for the User's info
    const user = await prisma.userAccount.findUnique({
      include: {
        tenant: {
          select: { key: true, name: true },
        },
      },
      where: { id: authUser.id },
    });
    if (!user) {
      const error = "Cuenta de usuario no existe";
      console.error(`[Query:refreshToken] ${error}`);
      throw new Error(error);
    }
    if (!user.isActive) {
      const error = "Usuario inactivo";
      console.error(`[Query:refreshToken] ${error}`);
      throw new Error(error);
    }

    const { password: _pass, ...userData } = user;
    // augment the response object with a JWT generated for the LoggedIn User
    return { ...userData, token: createJWT(userData) };
  }

  @Mutation(() => UserAccount)
  async createUserAccount(
    @Arg("data") data: CreateUserAccount,
    @Ctx() ctx: Context,
  ): Promise<UserAccount> {
    const tenantId = this.getContextTenantId(ctx);

    // Validate user not exists
    const user = await prisma.userAccount.findUnique({
      where: {
        uqUserTenantEmail: {
          tenantId,
          email: data.email,
        },
      },
    });
    if (user) throw new Error(`Ya existe un usuario con el correo electrónico ${data.email}`);

    const password = sha256(data.password).toString();
    return await prisma.userAccount.create({
      data: {
        ...data,
        password,
        tenantId,
      },
    });
  }

  @Mutation(() => UserAccount)
  async updateUserAccount(@Arg("data") data: UpdateUserAccount): Promise<UserAccount> {
    const { id, ...updateData } = data;

    // Existing user data
    const user = await prisma.userAccount.findUnique({
      where: {
        id,
      },
    });
    if (!user) throw new Error(`No existe un usuario con el id ${id}`);

    // Validate user email
    if (data.email && data.email !== user.email) {
      const userWithSameEmail = await prisma.userAccount.findUnique({
        where: {
          uqUserTenantEmail: {
            tenantId: user.tenantId,
            email: data.email,
          },
        },
      });
      if (userWithSameEmail && userWithSameEmail.id !== id)
        throw new Error(`Ya existe un usuario con el correo electrónico ${data.email}`);
    }

    return await prisma.userAccount.update({
      where: { id },
      data: {
        ...updateData,
      },
    });
  }

  @Mutation(() => Int)
  async deleteUserAccount(@Arg("id", () => Int) id: number): Promise<number | null> {
    const result = await prisma.userAccount.delete({
      where: { id },
    });
    return result.id;
  }

  @Mutation(() => UserAccount)
  async changeUserAccountPassword(
    @Arg("data") data: ChangeUserAccountPassword,
  ): Promise<UserAccount> {
    const { id, ...updateData } = data;
    // Validate login data
    let user = await prisma.userAccount.findUnique({ where: { id } });
    if (!user) {
      throw new Error("Cuenta de usuario no existe");
    }
    if (!user.isActive) {
      throw new Error("Usuario inactivo");
    }
    if (sha256(updateData.currentPassword).toString() !== user.password) {
      throw new Error("Clave actual inválida");
    }
    // Update password
    user = await prisma.userAccount.update({
      where: { id },
      data: {
        password: sha256(updateData.newPassword).toString(),
      },
    });

    return user;
  }

  @Mutation(() => UserAccount)
  async adminChangeUserAccountPassword(
    @Arg("data") data: AdminChangeUserAccountPassword,
  ): Promise<UserAccount> {
    const { id, ...updateData } = data;
    // Validate login data
    let user = await prisma.userAccount.findUnique({ where: { id } });
    if (!user) {
      throw new Error("Cuenta de usuario no existe");
    }
    if (!user.isActive) {
      throw new Error("Usuario inactivo");
    }
    // Update password
    user = await prisma.userAccount.update({
      where: { id },
      data: {
        password: sha256(updateData.newPassword).toString(),
      },
    });

    return user;
  }

  @Query(() => SearchUserAccountResponse, { nullable: true })
  async searchUserAccounts(
    @Arg("data") data: SearchUserAccount,
    @Ctx() ctx: Context,
  ): Promise<SearchUserAccountResponse> {
    const {
      limit,
      offset = 0,
      sort,
      docNumber,
      email,
      firstName,
      lastName,
      entityName,
      text,
      roles,
      active,
      entityIds,
      ...searchData
    } = data || {};

    const where: Prisma.UserAccountWhereInput = {
      ...searchData,
      tenantId: this.getContextTenantId(ctx),
      ...(docNumber ? { docNumber: { contains: docNumber } } : {}),
      ...(email ? { email: { contains: email, mode: "insensitive" } } : {}),
      ...(firstName ? { firstName: { contains: firstName, mode: "insensitive" } } : {}),
      ...(lastName ? { lastName: { contains: lastName, mode: "insensitive" } } : {}),
      ...(entityName ? { entity: { name: { contains: entityName, mode: "insensitive" } } } : {}),
      ...(roles
        ? {
            role: {
              in: roles,
            },
          }
        : {}),
      ...(active
        ? {
            OR: [{ isActive: active?.[0] }, { isActive: active?.[1] }],
          }
        : {}),
      ...(entityIds
        ? {
            entityId: {
              in: entityIds,
            },
          }
        : {}),
      ...(text
        ? {
            OR: [
              { docNumber: { contains: text } },
              { email: { contains: text, mode: "insensitive" } },
              { firstName: { contains: text, mode: "insensitive" } },
              { lastName: { contains: text, mode: "insensitive" } },
              { entity: { name: { contains: text, mode: "insensitive" } } },
            ],
          }
        : {}),
    };

    let orderBy: Prisma.UserAccountOrderByWithRelationInput | undefined = undefined;
    if (sort?.field && sort?.order) {
      if (sort.field === "entity") {
        orderBy = { entity: { ["code" as Prisma.SortOrder]: sort.order } };
      } else {
        orderBy = { [sort.field]: sort.order };
      }
    }

    const result = await prisma.userAccount.findMany({
      where,
      ...(limit ? { take: limit } : {}),
      skip: offset,
      orderBy: orderBy ?? [{ lastName: "asc" }],
    });

    // Total records
    const countItems = await prisma.userAccount.count({
      where,
    });

    return { items: result, count: countItems };
  }
}
