/*
  Warnings:

  - Added the required column `category` to the `public_politic` table without a default value. This is not possible if the table is not empty.

*/
-- CreateEnum
CREATE TYPE "PublicPoliticCategory" AS ENUM ('TERRITORY', 'PEACE', 'VICTIMS');

-- AlterTable
ALTER TABLE "public_politic" ADD COLUMN     "category" "PublicPoliticCategory" NOT NULL;
