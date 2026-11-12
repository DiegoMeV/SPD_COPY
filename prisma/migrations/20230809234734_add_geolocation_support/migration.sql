-- CreateEnum
CREATE TYPE "LocationType" AS ENUM ('DEPARTMENT', 'MUNICIPALITY', 'TOWNSHIP', 'RURAL_SETTLEMENT', 'DISTRICT', 'NEIGHBORHOOD', 'OTHER');

-- CreateTable
CREATE TABLE "geo_location" (
    "id" SERIAL NOT NULL,
    "tenant_id" INTEGER NOT NULL,
    "code" TEXT,
    "name" TEXT NOT NULL,
    "location_type" "LocationType" NOT NULL,
    "parent_location_id" INTEGER,
    "created_at" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMPTZ(6) DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "geo_location_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "geo_location" ADD CONSTRAINT "location_tenant" FOREIGN KEY ("tenant_id") REFERENCES "tenant"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "geo_location" ADD CONSTRAINT "location_itself" FOREIGN KEY ("parent_location_id") REFERENCES "geo_location"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;
