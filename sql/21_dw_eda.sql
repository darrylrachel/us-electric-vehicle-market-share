-- What percentage of vehicles in each state are EVs, PHEVs, HEVs, and gasoline?
WITH totals AS (
  SELECT
    state,
    electric_ev,
    plug_in_hybrid_electric_phev,
    hybrid_electric_hev,
    gasoline,
    diesel,
    (electric_ev + plug_in_hybrid_electric_phev + hybrid_electric_hev + gasoline + diesel) AS total_vehicles
  FROM dw.vehicle_data
)
SELECT state,
       ROUND(electric_ev * 100.0 / total_vehicles, 2) AS ev_pct,
       ROUND(plug_in_hybrid_electric_phev * 100.0 / total_vehicles, 2) AS phev_pct,
       ROUND(hybrid_electric_hev * 100.0 / total_vehicles, 2) AS hev_pct,
       ROUND(gasoline * 100.0 / total_vehicles, 2) AS gasoline_pct
FROM totals;


-- Which states have the highest EV adoption rates and which lag behind?
WITH ev_share AS (
    SELECT state,
       electric_ev,
       plug_in_hybrid_electric_phev,
       (electric_ev + plug_in_hybrid_electric_phev + hybrid_electric_hev + gasoline + diesel) AS total_vehicles,
       electric_ev * 100.0 /
            NULLif((electric_ev + plug_in_hybrid_electric_phev + hybrid_electric_hev + gasoline + diesel), 0)
                AS ev_adoption_pct
    FROM dw.vehicle_data
)
SELECT
  state,
  ROUND(ev_adoption_pct, 2) AS ev_adoption_pct
FROM ev_share
ORDER BY ev_adoption_pct DESC
LIMIT 5;


-- Which alternative fuels are significant versus niche?
WITH alternative_feul_totals AS (
    SELECT
        SUM(electric_ev)                     AS ev,
        SUM(plug_in_hybrid_electric_phev)    AS phev,
        SUM(hybrid_electric_hev)             AS hev,
        SUM(biodiesel)                       AS biodiesel,
        SUM(ethanol_flex_e85)                AS ethanol,
        SUM(hydrogen)                        AS hydrogen,
        SUM(gasoline + diesel)               AS traditional
    FROM dw.vehicle_data
)
SELECT
  ROUND(ev * 100.0 / (ev + phev + hev + biodiesel + ethanol + hydrogen + traditional), 2)        AS ev_pct,
  ROUND(phev * 100.0 / (ev + phev + hev + biodiesel + ethanol + hydrogen + traditional), 2)      AS phev_pct,
  ROUND(hev * 100.0 / (ev + phev + hev + biodiesel + ethanol + hydrogen + traditional), 2)       AS hev_pct,
  ROUND(biodiesel * 100.0 / (ev + phev + hev + biodiesel + ethanol + hydrogen + traditional), 2) AS biodiesel_pct,
  ROUND(ethanol * 100.0 / (ev + phev + hev + biodiesel + ethanol + hydrogen + traditional), 2)   AS ethanol_pct,
  ROUND(hydrogen * 100.0 / (ev + phev + hev + biodiesel + ethanol + hydrogen + traditional), 2)  AS hydrogen_pct
FROM alternative_feul_totals;


SELECT
  'biodiesel' AS fuel,
  COUNT(*) AS states_with_presence
FROM dw.vehicle_data
WHERE biodiesel > 0

UNION ALL

SELECT
  'ethanol',
  COUNT(*)
FROM dw.vehicle_data
WHERE ethanol > 0

UNION ALL

SELECT
  'hydrogen',
  COUNT(*)
FROM dw.vehicle_data
WHERE hydrogen > 0;



-- SELECT PG_TYPEOF(electric_ev)
-- FROM dw.vehicle_data;