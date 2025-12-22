BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "action_log" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "date" timestamp without time zone NOT NULL,
    "actionId" bigint NOT NULL,
    "quantity" double precision NOT NULL,
    "co2Saved" double precision NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "challenge" (
    "id" bigserial PRIMARY KEY,
    "title" text NOT NULL,
    "description" text NOT NULL,
    "targetAmount" double precision NOT NULL,
    "unit" text NOT NULL,
    "points" bigint NOT NULL,
    "durationDays" bigint NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "eco_action" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "co2Factor" double precision NOT NULL,
    "unit" text NOT NULL,
    "category" text NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "user_profile" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "ecoScore" bigint NOT NULL,
    "joinedDate" timestamp without time zone NOT NULL
);

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "action_log"
    ADD CONSTRAINT "action_log_fk_0"
    FOREIGN KEY("actionId")
    REFERENCES "eco_action"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR carbon_footprint
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('carbon_footprint', '20251221174135096', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20251221174135096', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20240516151843329', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240516151843329', "timestamp" = now();


COMMIT;
