import { Field, ObjectType, InputType, Int, registerEnumType } from "type-graphql";
import { DbModel, SearchInput, SearchResponse } from "./common";
import { PublicPolitic as DbPublicPolitic, PublicPoliticCategory } from "@prisma/client";

registerEnumType(PublicPoliticCategory, {
    name: "PublicPoliticCategory",
    description: "Category for public politics",
});

@ObjectType()
export class PublicPolitic extends DbModel implements Partial<DbPublicPolitic> {
    @Field(() => PublicPoliticCategory)
    category!: PublicPoliticCategory;

    @Field(() => String, { nullable: true })
    code?: string | undefined | null;

    @Field()
    name!: string;

    @Field(() => String, { nullable: true })
    description?: string | undefined | null;

    @Field()
    isActive!: boolean;

    @Field(() => Int, { nullable: true })
    fromYear?: number | null;

    @Field(() => Int, { nullable: true })
    toYear?: number | null;
}

@InputType()
export class CreatePublicPolitic implements Partial<DbPublicPolitic> {
    @Field(() => PublicPoliticCategory, { nullable: true })
    category?: PublicPoliticCategory;

    @Field(() => String, { nullable: true })
    code?: string | undefined;

    @Field()
    name!: string;

    @Field(() => String, { nullable: true })
    description?: string | undefined;

    @Field({ defaultValue: true })
    isActive!: boolean;

    @Field(() => Int, { nullable: true })
    fromYear?: number;

    @Field(() => Int, { nullable: true })
    toYear?: number;

    @Field(() => [Int], { nullable: true })
    componentIds?: number[];
}

@InputType()
export class UpdatePublicPolitic implements Partial<DbPublicPolitic> {
    @Field(() => Int)
    id!: number;

    @Field(() => PublicPoliticCategory, { nullable: true })
    category?: PublicPoliticCategory | undefined;

    @Field(() => String, { nullable: true })
    code?: string | undefined;

    @Field(() => String, { nullable: true })
    name?: string | undefined;

    @Field(() => String, { nullable: true })
    description?: string | undefined;

    @Field(() => Boolean, { nullable: true })
    isActive?: boolean | undefined;

    @Field(() => Int, { nullable: true })
    fromYear?: number;

    @Field(() => Int, { nullable: true })
    toYear?: number;

    @Field(() => [Int], { nullable: true })
    componentIds?: number[];
}

@InputType()
export class SearchPublicPolitic extends SearchInput implements Partial<DbPublicPolitic> {
    @Field(() => Int, { nullable: true })
    id?: number | undefined;

    @Field(() => Boolean, { nullable: true })
    isActive?: boolean;

    @Field(() => String, { nullable: true })
    text?: string | undefined | null;

    @Field(() => [PublicPoliticCategory], { nullable: true })
    categories?: PublicPoliticCategory[];
}

@ObjectType()
export class SearchPublicPoliticResponse extends SearchResponse {
    @Field(() => [PublicPolitic])
    items!: PublicPolitic[];
}
