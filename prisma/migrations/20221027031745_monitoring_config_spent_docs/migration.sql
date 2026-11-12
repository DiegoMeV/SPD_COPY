/*
  Warnings:

  - You are about to drop the column `colorsConfig` on the `monitoring_config` table. All the data in the column will be lost.
  - You are about to drop the column `datesConfig` on the `monitoring_config` table. All the data in the column will be lost.
  - You are about to drop the column `spentDoc` on the `monitoring_config` table. All the data in the column will be lost.
  - You are about to drop the column `weightingType` on the `monitoring_config` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "monitoring_config" DROP COLUMN "colorsConfig",
DROP COLUMN "datesConfig",
DROP COLUMN "spentDoc",
DROP COLUMN "weightingType",
ADD COLUMN     "colors_config" JSONB,
ADD COLUMN     "dates_config" JSONB,
ADD COLUMN     "spent_docs" "SpentDoc"[],
ADD COLUMN     "weighting_type" "WeightingType" NOT NULL DEFAULT 'FINANCIAL';
