import { Field, ObjectType, InputType, Int } from "type-graphql";
import { DbModel, SearchInput, SearchResponse } from "./common";
import { ProductCatalog as DbProductCatalog } from "@prisma/client";

@ObjectType()
export class ProductCatalog extends DbModel implements Partial<DbProductCatalog> {
  @Field(() => Boolean)
  isActive!: boolean;

  @Field(() => String)
  code!: string;

  @Field(() => String)
  name!: string;

  @Field(() => String, { nullable: true })
  description?: string | null | undefined;

  @Field(() => String, { nullable: true })
  unitsName?: string | null | undefined;

  @Field(() => Int, { nullable: true })
  parentId?: number | null | undefined;

  @Field(() => Boolean, { nullable: true, defaultValue: false })
  isPrincipal?: boolean | undefined | null;

  @Field(() => Boolean, { nullable: true, defaultValue: false })
  isNational?: boolean | undefined | null;

  @Field(() => Boolean, { nullable: true, defaultValue: false })
  isTerritorial?: boolean | undefined | null;

  @Field(() => Boolean, { nullable: true, defaultValue: false })
  isLeaf?: boolean | undefined | null;
}

@InputType()
export class SearchProductCatalog extends SearchInput implements Partial<DbProductCatalog> {
  @Field(() => Int, { nullable: true })
  id?: number | undefined;

  @Field(() => Boolean, { nullable: true })
  isActive?: boolean;

  @Field(() => String, { nullable: true })
  code?: string;

  @Field(() => String, { nullable: true })
  name?: string;

  @Field(() => String, { nullable: true })
  description?: string | null | undefined;

  @Field(() => String, { nullable: true })
  text?: string | null | undefined;

  @Field(() => String, { nullable: true })
  unitsName?: string | null | undefined;

  @Field(() => Int, { nullable: true })
  parentId?: number | null | undefined;

  @Field(() => Boolean, { nullable: true })
  isPrincipal?: boolean;

  @Field(() => Boolean, { nullable: true })
  isNational?: boolean;

  @Field(() => Boolean, { nullable: true })
  isTerritorial?: boolean;

  @Field(() => Boolean, { nullable: true })
  isLeaf?: boolean;
}

@ObjectType()
export class ProductCatalogResponse extends SearchResponse {
  @Field(() => [ProductCatalog])
  items!: ProductCatalog[];
}
