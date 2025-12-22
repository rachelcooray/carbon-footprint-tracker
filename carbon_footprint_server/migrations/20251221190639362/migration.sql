BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "badge" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "name" text NOT NULL,
    "description" text NOT NULL,
    "earnedDate" timestamp without time zone NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "social_post" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "userName" text,
    "content" text NOT NULL,
    "timestamp" timestamp without time zone NOT NULL,
    "type" text NOT NULL
);

--
-- ACTION ALTER TABLE
--
ALTER TABLE "user_profile" ADD COLUMN "level" bigint NOT NULL DEFAULT 1;
ALTER TABLE "user_profile" ADD COLUMN "streakDays" bigint NOT NULL DEFAULT 0;
ALTER TABLE "user_profile" ADD COLUMN "lastActionDate" timestamp without time zone;

--
-- MIGRATION VERSION FOR carbon_footprint
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('carbon_footprint', '20251221190639362', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20251221190639362', "timestamp" = now();

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
