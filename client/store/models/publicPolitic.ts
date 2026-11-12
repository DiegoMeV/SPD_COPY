import { Action, action } from "easy-peasy";
import { SearchPublicPoliticsQuery } from "../../../graphql/gen/ops";

export type PublicPoliticRecord = NonNullable<SearchPublicPoliticsQuery["searchPublicPolitics"]>["items"][number];

export type PublicPoliticModel = {
    selectedPublicPolitic: PublicPoliticRecord | undefined;
    setSelectedPublicPolitic: Action<PublicPoliticModel, PublicPoliticRecord | undefined>;
};

export const publicPoliticModel: PublicPoliticModel = {
    selectedPublicPolitic: undefined,
    setSelectedPublicPolitic: action((state, publicPolitic) => {
        state.selectedPublicPolitic = publicPolitic;
    }),
};
