BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "badge" ADD COLUMN "iconType" text;
--
-- ACTION CREATE TABLE
--
CREATE TABLE "community_group" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "description" text NOT NULL,
    "totalImpact" double precision NOT NULL DEFAULT 0.0,
    "memberCount" bigint NOT NULL DEFAULT 0
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "group_member" (
    "id" bigserial PRIMARY KEY,
    "groupId" bigint NOT NULL,
    "userId" bigint NOT NULL,
    "joinedAt" timestamp without time zone NOT NULL
);

--
-- ACTION ALTER TABLE
--
ALTER TABLE "user_profile" ADD COLUMN "monthlyBudget" double precision NOT NULL DEFAULT 200.0;
--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "group_member"
    ADD CONSTRAINT "group_member_fk_0"
    FOREIGN KEY("groupId")
    REFERENCES "community_group"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR carbon_footprint
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('carbon_footprint', '20251222091954306', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20251222091954306', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20240516151843329', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240516151843329', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth', '20240520102713718', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240520102713718', "timestamp" = now();


COMMIT;
