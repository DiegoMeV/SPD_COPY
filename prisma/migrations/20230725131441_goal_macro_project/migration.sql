-- AlterTable
ALTER TABLE "goal" ADD COLUMN     "formula" TEXT,
ADD COLUMN     "macro_project_id" INTEGER;

-- CreateTable
CREATE TABLE "macro_project" (
    "id" SERIAL NOT NULL,
    "tenant_id" INTEGER NOT NULL,
    "code" TEXT,
    "name" TEXT NOT NULL,
    "description" TEXT,
    "is_active" BOOLEAN NOT NULL DEFAULT true,
    "created_at" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "created_by" INTEGER,
    "updated_at" TIMESTAMPTZ(6) DEFAULT CURRENT_TIMESTAMP,
    "updated_by" INTEGER,

    CONSTRAINT "macro_project_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "macro_project" ADD CONSTRAINT "macro_project_tenant" FOREIGN KEY ("tenant_id") REFERENCES "tenant"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "goal" ADD CONSTRAINT "goal_macro_project" FOREIGN KEY ("macro_project_id") REFERENCES "macro_project"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;
