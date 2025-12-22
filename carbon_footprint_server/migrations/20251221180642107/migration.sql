BEGIN;

--
-- ACTION DROP TABLE
--
DROP TABLE "challenge" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "challenge" (
    "id" bigserial PRIMARY KEY,
    "title" text NOT NULL,
    "description" text NOT NULL,
    "targetActionId" bigint NOT NULL,
    "targetAmount" double precision NOT NULL,
    "unit" text NOT NULL,
    "points" bigint NOT NULL,
    "durationDays" bigint NOT NULL
);

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "challenge"
    ADD CONSTRAINT "challenge_fk_0"
    FOREIGN KEY("targetActionId")
    REFERENCES "eco_action"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR carbon_footprint
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('carbon_footprint', '20251221180642107', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20251221180642107', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20240516151843329', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240516151843329', "timestamp" = now();


COMMIT;
