BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "company" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "description" text,
    "timezone" text NOT NULL,
    "reportFrequency" text NOT NULL,
    "customFrequencyDays" bigint,
    "aiEnabled" boolean NOT NULL,
    "toneSetting" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "company_name_idx" ON "company" USING btree ("name");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "delivery_channel" (
    "id" bigserial PRIMARY KEY,
    "companyId" bigint NOT NULL,
    "channelType" text NOT NULL,
    "name" text NOT NULL,
    "configJson" text NOT NULL,
    "isActive" boolean NOT NULL,
    "isDefault" boolean NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "delivery_channel_company_idx" ON "delivery_channel" USING btree ("companyId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "report" (
    "id" bigserial PRIMARY KEY,
    "companyId" bigint NOT NULL,
    "startDate" timestamp without time zone NOT NULL,
    "endDate" timestamp without time zone NOT NULL,
    "content" text NOT NULL,
    "rawCommitsJson" text,
    "aiSummary" text,
    "notes" text,
    "status" text NOT NULL,
    "sentAt" timestamp without time zone,
    "deliveryChannel" text,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "report_company_idx" ON "report" USING btree ("companyId");
CREATE INDEX "report_status_idx" ON "report" USING btree ("status");
CREATE INDEX "report_date_range_idx" ON "report" USING btree ("companyId", "startDate", "endDate");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "report_template" (
    "id" bigserial PRIMARY KEY,
    "companyId" bigint NOT NULL,
    "name" text NOT NULL,
    "content" text NOT NULL,
    "isDefault" boolean NOT NULL,
    "version" bigint NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "template_company_idx" ON "report_template" USING btree ("companyId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "repository" (
    "id" bigserial PRIMARY KEY,
    "companyId" bigint NOT NULL,
    "provider" text NOT NULL,
    "repoName" text NOT NULL,
    "branch" text NOT NULL,
    "prefixRules" text,
    "excludePatterns" text,
    "isActive" boolean NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "repository_company_idx" ON "repository" USING btree ("companyId");
CREATE UNIQUE INDEX "repository_unique_idx" ON "repository" USING btree ("companyId", "repoName");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "schedule_config" (
    "id" bigserial PRIMARY KEY,
    "companyId" bigint NOT NULL,
    "frequency" text NOT NULL,
    "customDays" bigint,
    "dayOfWeek" bigint,
    "dayOfMonth" bigint,
    "hourOfDay" bigint NOT NULL,
    "minuteOfHour" bigint NOT NULL,
    "isEnabled" boolean NOT NULL,
    "lastRunAt" timestamp without time zone,
    "nextRunAt" timestamp without time zone,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "schedule_company_idx" ON "schedule_config" USING btree ("companyId");
CREATE INDEX "schedule_next_run_idx" ON "schedule_config" USING btree ("nextRunAt", "isEnabled");


--
-- MIGRATION VERSION FOR reportly
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('reportly', '20260114142847100', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260114142847100', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20251208110333922-v3-0-0', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20251208110333922-v3-0-0', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_idp
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_idp', '20260109031533194', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260109031533194', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_core
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_core', '20251208110412389-v3-0-0', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20251208110412389-v3-0-0', "timestamp" = now();


COMMIT;
