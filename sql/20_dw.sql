DROP TABLE IF EXISTS dw.vehicle_data;
CREATE TABLE IF NOT EXISTS dw.vehicle_data (
    State TEXT,
    Electric_EV INTEGER,
    Plug_In_Hybrid_Electric_PHEV INTEGER,
    Hybrid_Electric_HEV INTEGER,
    Biodiesel INTEGER,
    Ethanol_Flex_E85 INTEGER,
    Compressed_Natural_Gas_CNG INTEGER,
    Propane INTEGER,
    Hydrogen INTEGER,
    Methanol INTEGER,
    Gasoline INTEGER,
    Diesel INTEGER,
    Unknown_Fuel INTEGER
);


INSERT INTO dw.vehicle_data (state,
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
       REPLACE(electric_ev, ',', '')::INTEGER AS electric_ev,
       REPLACE(plug_in_hybrid_electric_phev, ',', '')::INTEGER AS plug_in_hybrid_electric_phev,
       REPLACE(hybrid_electric_hev, ',', '')::INTEGER AS hybrid_electric_hev,
       REPLACE(biodiesel, ',', '')::INTEGER AS biodiesel,
       REPLACE(ethanol_flex_e85, ',', '')::INTEGER AS ethanol_flex_e85,
       REPLACE(compressed_natural_gas_cng, ',', '')::INTEGER AS compressed_natural_gas_cng,
       REPLACE(propane, ',', '')::INTEGER AS propane,
       REPLACE(hydrogen, ',', '')::INTEGER AS hydrogen,
       REPLACE(methanol, ',', '')::INTEGER AS methanol,
       REPLACE(gasoline, ',', '')::INTEGER AS gasoline,
       REPLACE(diesel, ',', '')::INTEGER AS diesel,
       REPLACE(unknown_fuel, ',', '')::INTEGER AS unknown_fuel
FROM stg.vehicle_data;