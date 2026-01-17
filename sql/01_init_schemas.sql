-- --------------------
-- Schemas
-- --------------------
CREATE SCHEMA IF NOT EXISTS raw;
CREATE SCHEMA IF NOT EXISTS stg;
CREATE SCHEMA IF NOT EXISTS dw;

-- --------------------
-- Tables (raw)
-- --------------------
DROP TABLE IF EXISTS raw.vehicle_data;
CREATE TABLE IF NOT EXISTS raw.vehicle_data (
    State TEXT,
    Electric_EV TEXT,
    Plug_In_Hybrid_Electric_PHEV TEXT,
    Hybrid_Electric_HEV TEXT,
    Biodiesel TEXT,
    Ethanol_Flex_E85 TEXT,
    Compressed_Natural_Gas_CNG TEXT,
    Propane TEXT,
    Hydrogen TEXT,
    Methanol TEXT,
    Gasoline TEXT,
    Diesel TEXT,
    Unknown_Fuel TEXT
);



-- --------------------
-- Truncate for reload
-- --------------------
TRUNCATE TABLE raw.vehicle_data;

-- --------------------
-- Load: File
-- --------------------
COPY raw.vehicle_data
    FROM '/datasets/Vehicle_Data.csv'
    WITH (FORMAT csv, HEADER true, DELIMITER ',', NULL '', ENCODING 'UTF8');