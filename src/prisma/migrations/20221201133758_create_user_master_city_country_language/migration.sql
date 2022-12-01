/*
  Warnings:

  - You are about to drop the `Board` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropTable
DROP TABLE "Board";

-- CreateTable
CREATE TABLE "users" (
    "id" SERIAL NOT NULL,
    "email" VARCHAR(40) NOT NULL,
    "password" VARCHAR(200) NOT NULL,
    "country_code" VARCHAR(2),
    "phone" VARCHAR(25) NOT NULL,
    "version" INTEGER DEFAULT 0,
    "role" VARCHAR(20),
    "bio" VARCHAR(400),
    "sms_code" INTEGER,
    "sms_code_valid" BOOLEAN DEFAULT false,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "masters" (
    "id" SERIAL NOT NULL,
    "first_name" VARCHAR(40),
    "last_name" VARCHAR(40),
    "avatar" VARCHAR(200),
    "language_id" INTEGER,
    "user_id" INTEGER NOT NULL,
    "city_id" INTEGER,
    "work_at_master" BOOLEAN,
    "work_at_customer" BOOLEAN,
    "work_with_women" BOOLEAN DEFAULT false,
    "work_with_men" BOOLEAN DEFAULT false,
    "profile_url" VARCHAR(200),
    "created_at" TIMESTAMP(3) DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3),

    PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "languages" (
    "id" SERIAL NOT NULL,
    "key" VARCHAR(5),
    "name" VARCHAR(100) NOT NULL,
    "name_ua" VARCHAR(100),
    "name_ru" VARCHAR(100),
    "name_pl" VARCHAR(100),
    "flag_url" VARCHAR(200),
    "created_at" TIMESTAMP(3) DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3),

    PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "countries" (
    "id" SERIAL NOT NULL,
    "name" VARCHAR(100),
    "name_ua" VARCHAR(100),
    "name_ru" VARCHAR(100),
    "name_pl" VARCHAR(100),
    "created_at" TIMESTAMP(3) DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3),

    PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "cities" (
    "id" SERIAL NOT NULL,
    "country_id" INTEGER NOT NULL,
    "name" VARCHAR(100),
    "name_ua" VARCHAR(100),
    "name_ru" VARCHAR(100),
    "name_pl" VARCHAR(100),
    "coord" DOUBLE PRECISION,
    "createdAt" TIMESTAMP(3) DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3),

    PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "users.email_unique" ON "users"("email");

-- CreateIndex
CREATE UNIQUE INDEX "users.phone_unique" ON "users"("phone");

-- CreateIndex
CREATE UNIQUE INDEX "masters.user_id_unique" ON "masters"("user_id");

-- CreateIndex
CREATE UNIQUE INDEX "masters.profile_url_unique" ON "masters"("profile_url");

-- AddForeignKey
ALTER TABLE "masters" ADD FOREIGN KEY ("language_id") REFERENCES "languages"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "masters" ADD FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "masters" ADD FOREIGN KEY ("city_id") REFERENCES "cities"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "cities" ADD FOREIGN KEY ("country_id") REFERENCES "countries"("id") ON DELETE CASCADE ON UPDATE CASCADE;
