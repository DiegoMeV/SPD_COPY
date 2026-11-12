import { Ctx, Query, Resolver } from "type-graphql";
import type { Context } from "../types/common";
import _ from "lodash";
import ExcelJS from "exceljs";
import s3 from "../../lib/s3";
import { GraphQLError } from "graphql";

@Resolver()
export class SPDResolver {
  validateToken(ctx: Context) {
    if (_.isEmpty(ctx.user) && ctx.tokenExpiredData)
      throw new GraphQLError("Token Expired", {
        extensions: {
          code: "UNAUTHENTICATED",
        },
      });
  }

  getContextTenantId(ctx: Context) {
    this.validateToken(ctx);
    return ctx.user?.tenantId;
  }

  getContextTenantKey(ctx: Context) {
    this.validateToken(ctx);
    return ctx.user?.tenant?.key;
  }

  getContextUserId(ctx: Context) {
    this.validateToken(ctx);
    return ctx.user?.id;
  }

  async generateExcelFile(): Promise<ExcelJS.Buffer> {
    const workbook = new ExcelJS.Workbook();
    const worksheet = workbook.addWorksheet("My Sheet");

    worksheet.columns = [
      { header: "Name", key: "name", width: 20 },
      { header: "Age", key: "age", width: 10 },
      { header: "Email", key: "email", width: 30 },
    ];

    worksheet.addRow({ name: "John Doe", age: 30, email: "john@example.com" });
    worksheet.addRow({ name: "Jane Doe", age: 25, email: "jane@example.com" });

    return workbook.xlsx.writeBuffer();
  }

  async uploadExcelFile(
    buffer: ExcelJS.Buffer,
    s3: AWS.S3,
  ): Promise<AWS.S3.ManagedUpload.SendData> {
    const result = await s3
      .upload({
        Bucket: "siifweb-spd-dev",
        Key: "reports/test/my-file.xlsx",
        Body: buffer,
        ContentType: "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
        // ACL: 'public-read',
      })
      .promise();

    return result;
  }

  @Query(() => String, { nullable: true })
  async s3UploadTest(@Ctx() ctx: Context): Promise<string | null> {
    const buffer = await this.generateExcelFile();
    const result = await this.uploadExcelFile(buffer, s3);
    const url = await s3.getSignedUrlPromise("getObject", {
      Bucket: result.Bucket,
      Key: result.Key,
      Expires: 3600, // URL expires in 1 hour
    });

    // construct the URL of the uploaded file
    // const url = `https://${result.Bucket}.s3.amazonaws.com/${result.Key}`;

    // return the URL in the GraphQL response
    return url;
  }
}
