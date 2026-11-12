import { Resolver, Query, Arg, FieldResolver, Root } from "type-graphql";
import { SPDResolver } from './spdResolver';
import { ProductCatalog, SearchProductCatalog } from "../types"
import prisma from "../../lib/prisma";
import { ProductCatalogResponse } from '../types/productCatalog';
import { Prisma } from "@prisma/client";

@Resolver(() => ProductCatalog)
export class ProductCatalogResolver extends SPDResolver {

    @FieldResolver(() => ProductCatalog)
    async product(
        @Root() productCatalog: ProductCatalog,
    ): Promise<ProductCatalog | null> {
        if (productCatalog.parentId)
            return prisma.productCatalog.findUnique({ where: { id: productCatalog.parentId } });
        return null;
    }

    @FieldResolver(() => ProductCatalog)
    async program(
        @Root() productCatalog: ProductCatalog,
    ): Promise<ProductCatalog | null> {
        if (productCatalog.parentId)
            return prisma.productCatalog.findFirst({ where: { id: productCatalog.parentId } });
        return null;
    }

    @FieldResolver(() => ProductCatalog)
    async sector(
        @Root() productCatalog: ProductCatalog,
    ): Promise<ProductCatalog | null> {
        if (productCatalog.parentId)
            return prisma.productCatalog.findFirst({ where: { id: productCatalog.parentId } });
        return null;
    }

    @Query(() => ProductCatalogResponse, { nullable: true })
    async getProductIndicators(): Promise<ProductCatalogResponse | null> {
        const result = await prisma.productCatalog.findMany({
            where: {
                isLeaf: true,
                isTerritorial: true,
            },
            orderBy: {
                code: "asc"
            }
        });
        return { count: result?.length ?? 0, items: result ?? [] };
    }

    @Query(() => ProductCatalogResponse, { nullable: true })
    async getProductSectors(): Promise<ProductCatalogResponse | null> {
        const result = await prisma.productCatalog.findMany({
            where: {
                parentId: null,
                isLeaf: false,
            },
            orderBy: {
                code: "asc"
            }
        });
        return { count: result?.length ?? 0, items: result ?? [] };
    }

    @Query(() => ProductCatalogResponse, { nullable: true })
    async searchProductIndicators(@Arg("data") data: SearchProductCatalog): Promise<ProductCatalogResponse> {
        const {
            limit,
            offset = 0,
            sort,
            code,
            name,
            description,
            unitsName,
            text,
            ...searchData
        } = data || {};

        const where: Prisma.ProductCatalogWhereInput = {
            // const where = {
            ...searchData,
            isLeaf: true,
            isTerritorial: true,
            ...(code ? { code: { contains: code } } : {}),
            ...(name ? { name: { contains: name, mode: 'insensitive' } } : {}),
            ...(description ? { description: { contains: description, mode: 'insensitive' } } : {}),
            ...(unitsName ? { unitsName: { contains: unitsName } } : {}),
            ...(text ? {
                OR: [
                    { code: { contains: text } },
                    { description: { contains: text, mode: 'insensitive' } },
                    { name: { contains: text, mode: 'insensitive' } },
                    { parentProductCatalog: { name: { contains: text, mode: 'insensitive' } } },
                    { parentProductCatalog: { parentProductCatalog: { name: { contains: text, mode: 'insensitive' } } } },
                    { parentProductCatalog: { parentProductCatalog: { parentProductCatalog: { name: { contains: text, mode: 'insensitive' } } } } }
                ]
            } : {}),
        };

        let orderBy = undefined;
        if (sort?.field && sort?.order) {
            orderBy = { [sort.field]: sort.order };
        }

        const result = await prisma.productCatalog.findMany({
            where,
            ...(limit ? { take: limit } : {}),
            skip: offset,
            orderBy: orderBy ?? [{ code: "asc" }],
        });

        // Total records
        const countItems = await prisma.productCatalog.count({
            where,
        });

        return { items: result, count: countItems };
    }
}
