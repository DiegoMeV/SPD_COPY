-- AlterTable
ALTER TABLE "product_catalog" ADD COLUMN     "is_national" BOOLEAN,
ADD COLUMN     "is_principal" BOOLEAN,
ADD COLUMN     "is_territorial" BOOLEAN,
ADD COLUMN     "units_name" TEXT;
