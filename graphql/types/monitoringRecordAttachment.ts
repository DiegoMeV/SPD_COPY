import { Field, ObjectType, InputType, Int } from "type-graphql";
import { DbModel } from "./common";
import { MonitoringRecordAttachment as DbMonitoringRecordAttachment } from "@prisma/client";

@ObjectType()
export class MonitoringRecordAttachment
  extends DbModel
  implements Partial<DbMonitoringRecordAttachment>
{
  @Field(() => Int)
  monitoringRecordId!: number;

  @Field(() => String)
  s3Path!: string;

  @Field(() => String)
  name!: string;

  @Field(() => String, { nullable: true })
  description?: string | null;

  @Field(() => Int, { nullable: true })
  createdBy?: number | null | undefined;

  @Field(() => Int, { nullable: true })
  updatedBy?: number | null | undefined;
}

@InputType()
export class CreateMonitoringRecordAttachmentLink
  extends DbModel
  implements Partial<DbMonitoringRecordAttachment>
{
  @Field(() => Int)
  monitoringRecordId!: number;

  @Field(() => String)
  name!: string;

  @Field(() => String, { nullable: true })
  description?: string | null;
}

@ObjectType()
export class CreateMonitoringRecordAttachmentLinkResponse extends MonitoringRecordAttachment {
  @Field(() => String)
  uploadURL!: string;
}
