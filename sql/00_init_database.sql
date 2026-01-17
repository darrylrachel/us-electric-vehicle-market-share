-- =============================================================
-- Procedure: load schema
-- Purpose:   Create schemas + tables (if needed),
--            truncate, and load CSVs from /datasets.
-- =============================================================

-- Terminate existing connections to target DB
SELECT pg_terminate_backend(pid)
FROM pg_stat_activity
WHERE datname = 'us_ev_market_share'
  AND pid <> pg_backend_pid();

-- Drop & recreate database
DROP DATABASE IF EXISTS us_ev_market_share;
CREATE DATABASE us_ev_market_share;