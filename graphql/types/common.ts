import { GraphQLJSON } from "graphql-scalars";
import { Field, ObjectType, Int, InputType, registerEnumType } from "type-graphql";
import { UserLoggedInFragment } from "../gen/ops";

export enum ExportFormat {
  NONE,
  EXCEL,
}

registerEnumType(ExportFormat, {
  name: "ExportFormat",
  description: "Format used for exporting GraphQL response data",
});

@ObjectType()
export abstract class DbModel {
  @Field(() => Int)
  id!: number;

  @Field()
  createdAt!: Date;

  @Field(() => Date, { nullable: true })
  updatedAt?: Date | null;
}

@InputType()
export class SortInput {
  @Field({ nullable: true })
  field?: string;

  @Field({ nullable: true })
  order?: "asc" | "desc";
}

@InputType()
export class SearchInput {
  @Field(() => Int, { nullable: true })
  limit?: number;

  @Field(() => Int, { nullable: true })
  offset?: number;

  @Field(() => SortInput, { nullable: true })
  sort?: SortInput;
}

@ObjectType()
export class FilterResponse {
  @Field(() => String)
  value!: string;

  @Field(() => Int)
  count!: number;
}

@ObjectType()
export class SearchResponse {
  @Field(() => Int, { defaultValue: 0 })
  count!: number;

  @Field(() => GraphQLJSON, { nullable: true })
  filters?: Record<string, FilterResponse[]>;
}

/**
 * Utility Types
 */

/**
 * Matches any valid value that can be used as an input for operations like
 * create and update as the value of a JSON field. Unlike `JsonValue`, this
 * type allows read-only arrays and read-only object properties and disallows
 * `null` at the top level.
 *
 * `null` cannot be used as the value of a JSON field because its meaning
 * would be ambiguous. Use `Prisma.JsonNull` to store the JSON null value or
 * `Prisma.DbNull` to clear the JSON value and set the field to the database
 * NULL value instead.
 *
 * @see https://www.prisma.io/docs/concepts/components/prisma-client/working-with-fields/working-with-json-fields#filtering-by-null-values
 */
export type InputJsonValue = string | number | boolean | InputJsonObject | InputJsonArray;

/**
 * From https://github.com/sindresorhus/type-fest/
 * Matches a JSON object.
 * This type can be useful to enforce some input to be JSON-compatible or as a super-type to be extended from.
 */
export type JsonObject = { [Key in string]?: JsonValue };

/**
 * From https://github.com/sindresorhus/type-fest/
 * Matches a JSON array.
 */
export type JsonArray = Array<JsonValue>;

/**
 * From https://github.com/sindresorhus/type-fest/
 * Matches any valid JSON value.
 */
export type JsonValue = string | number | boolean | JsonObject | JsonArray | null;

/**
 * Matches a JSON object.
 * Unlike `JsonObject`, this type allows undefined and read-only properties.
 */
export type InputJsonObject = { readonly [Key in string]?: InputJsonValue | null };

/**
 * Matches a JSON array.
 * Unlike `JsonArray`, readonly arrays are assignable to this type.
 */
export type InputJsonArray = ReadonlyArray<InputJsonValue | null>;

export interface Context {
  user: UserLoggedInFragment;
  // s3: AWS.S3,
  tokenExpiredData?: UserLoggedInFragment;
}
