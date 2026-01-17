DROP TABLE IF EXISTS stg.vehicle_data;
CREATE TABLE IF NOT EXISTS stg.vehicle_data (
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


INSERT INTO stg.vehicle_data (state,
                              electric_ev,
                              plug_in_hybrid_electric_phev,
                              hybrid_electric_hev,
                              biodiesel,
                              ethanol_flex_e85,
                              compressed_natural_gas_cng,
                              propane,
                              hydrogen,
                              methanol,
                              gasoline,
                              diesel,
                              unknown_fuel)
SELECT TRIM(state) AS state,
       CAST(REPLACE(electric_ev, ',', '') AS INTEGER) AS electric_ev,
       CAST(REPLACE(plug_in_hybrid_electric_phev, ',', '') AS INTEGER) AS plug_in_hybrid_electric_phev,
       CAST(REPLACE(hybrid_electric_hev, ',', '') AS INTEGER) AS hybrid_electric_hev,
       CAST(REPLACE(biodiesel, ',', '') AS INTEGER) AS biodiesel,
       CAST(REPLACE(ethanol_flex_e85, ',', '') AS INTEGER) AS ethanol_flex_e85,
       CAST(REPLACE(compressed_natural_gas_cng, ',', '') AS INTEGER) AS compressed_natural_gas_cng,
       CAST(REPLACE(propane, ',', '') AS INTEGER) AS propane,
       CAST(REPLACE(hydrogen, ',', '') AS INTEGER) AS hydrogen,
       CAST(REPLACE(methanol, ',', '') AS INTEGER) AS methanol,
       CAST(REPLACE(gasoline, ',', '') AS INTEGER) AS gasoline,
       CAST(REPLACE(diesel, ',', '') AS INTEGER) AS diesel,
       CAST(REPLACE(unknown_fuel, ',', '') AS INTEGER) AS unknown_fuel
FROM raw.vehicle_data;