-- AlterTable
ALTER TABLE "public_politic" ADD COLUMN     "component_id" INTEGER,
ADD COLUMN     "from_year" INTEGER,
ADD COLUMN     "to_year" INTEGER;

-- CreateTable
CREATE TABLE "public_politic_component" (
    "id" SERIAL NOT NULL,
    "code" TEXT,
    "name" TEXT NOT NULL,
    "description" TEXT,

    CONSTRAINT "public_politic_component_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "public_politic" ADD CONSTRAINT "public_politic_component" FOREIGN KEY ("component_id") REFERENCES "public_politic_component"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;
