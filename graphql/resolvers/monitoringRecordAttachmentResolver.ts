import { Resolver, Arg, Ctx, Mutation, Query, Int, FieldResolver, Root } from "type-graphql";
import { SPDResolver } from "./spdResolver";
import {
  MonitoringRecordAttachment,
  CreateMonitoringRecordAttachmentLink,
  CreateMonitoringRecordAttachmentLinkResponse,
} from "../types";
import type { Context } from "../types/common";
import _ from "lodash";
import prisma from "../../lib/prisma";
import s3 from "../../lib/s3";
import mime from "mime";
import { v4 as uuidv4 } from "uuid";

@Resolver(() => MonitoringRecordAttachment)
export class MonitoringRecordAttachmentResolver extends SPDResolver {
  @FieldResolver(() => String)
  downloadLink(@Root() monitoringRecordAttachment: MonitoringRecordAttachment): string {
    return `https://${process.env.S3_BUCKET}.s3.${process.env.S3_REGION}.amazonaws.com/${monitoringRecordAttachment.s3Path}`;
  }

  @Mutation(() => CreateMonitoringRecordAttachmentLinkResponse)
  async createMonitoringRecordAttachmentLink(
    @Arg("data") data: CreateMonitoringRecordAttachmentLink,
    @Ctx() ctx: Context,
  ): Promise<CreateMonitoringRecordAttachmentLinkResponse> {
    const { monitoringRecordId, name } = data;
    if (!process.env.S3_BUCKET)
      throw new Error(`No se ha definido un bucket para cargue de archivos`);

    const monitoringRecord = await prisma.monitoringRecord.findUnique({
      where: {
        id: monitoringRecordId,
      },
    });
    if (!monitoringRecord)
      throw new Error(`No existe el registro de seguimiento con id ${monitoringRecordId}`);

    const bucketName = process.env.S3_BUCKET;
    const s3Path = `monitoring_records/${monitoringRecordId}/${uuidv4()}-${name}`; // The name of the file you'll be uploading
    const expiration = 60 * 5; // URL expiration time in seconds (5 minutes)

    const params = {
      Bucket: bucketName,
      Key: s3Path,
      Expires: expiration,
      // ACL: "public-read",
      ContentType: mime.getType(name), // Set the appropriate content type
    };

    const signedUrl = s3.getSignedUrl("putObject", params);

    const attachment = await prisma.monitoringRecordAttachment.create({
      data: {
        ...data,
        s3Path,
      },
    });

    return {
      ...attachment,
      uploadURL: signedUrl,
    };
  }

  @Query(() => MonitoringRecordAttachment, { nullable: true })
  async getMonitoringRecordAttachment(
    @Arg("id", () => Int) id: number,
  ): Promise<MonitoringRecordAttachment | null> {
    return await prisma.monitoringRecordAttachment.findUnique({ where: { id } });
  }

  @Query(() => [MonitoringRecordAttachment], { nullable: true })
  async getMonitoringRecordAttachments(
    @Arg("monitoringRecordId", () => Int) monitoringRecordId: number,
  ): Promise<MonitoringRecordAttachment[] | null> {
    return await prisma.monitoringRecordAttachment.findMany({
      where: {
        monitoringRecordId,
      },
    });
  }

  @Mutation(() => MonitoringRecordAttachment)
  async deleteMonitoringRecordAttachment(
    @Arg("id", () => Int) id: number,
  ): Promise<MonitoringRecordAttachment | null> {
    return await prisma.monitoringRecordAttachment.delete({
      where: { id },
    });
  }
}
