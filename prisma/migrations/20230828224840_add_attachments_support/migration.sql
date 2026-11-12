-- CreateTable
CREATE TABLE "monitoring_record_attachment" (
    "id" SERIAL NOT NULL,
    "monitoring_record_id" INTEGER NOT NULL,
    "s3_path" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT,
    "created_at" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "created_by" INTEGER,
    "updated_at" TIMESTAMPTZ(6) DEFAULT CURRENT_TIMESTAMP,
    "updated_by" INTEGER,

    CONSTRAINT "monitoring_record_attachment_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "monitoring_record_attachment" ADD CONSTRAINT "monitoring_record_resource" FOREIGN KEY ("monitoring_record_id") REFERENCES "monitoring_record"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;
