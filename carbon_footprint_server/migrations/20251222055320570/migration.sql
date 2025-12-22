BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "butler_event" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "type" text NOT NULL,
    "message" text NOT NULL,
    "timestamp" timestamp without time zone NOT NULL,
    "isResolved" boolean NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "butler_message" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "text" text NOT NULL,
    "isFromButler" boolean NOT NULL,
    "timestamp" timestamp without time zone NOT NULL
);


--
-- MIGRATION VERSION FOR carbon_footprint
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('carbon_footprint', '20251222055320570', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20251222055320570', "timestamp" = now();

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
