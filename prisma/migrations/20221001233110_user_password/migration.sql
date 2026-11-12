/*
  Warnings:

  - Added the required column `password` to the `user_account` table without a default value. This is not possible if the table is not empty.
  - Made the column `doc_number` on table `user_account` required. This step will fail if there are existing NULL values in that column.

*/
-- AlterTable
ALTER TABLE "user_account" ADD COLUMN     "password" TEXT NOT NULL,
ALTER COLUMN "doc_number" SET NOT NULL,
ALTER COLUMN "updated_at" DROP NOT NULL;
