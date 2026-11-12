-- CreateEnum
CREATE TYPE "SPDRole" AS ENUM ('OPERATOR', 'VALIDATOR', 'AUDITOR', 'ADMIN');

-- AlterTable
ALTER TABLE "user_account" ADD COLUMN     "entity_id" INTEGER,
ADD COLUMN     "role" "SPDRole";

-- AddForeignKey
ALTER TABLE "user_account" ADD CONSTRAINT "user_account_entity" FOREIGN KEY ("entity_id") REFERENCES "entity"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;
