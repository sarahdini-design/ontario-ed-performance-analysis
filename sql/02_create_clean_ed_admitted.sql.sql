CREATE TABLE `ontario-ed-performance-2026.ontario_ed.clean_ed_admitted` AS

SELECT
  indicator,
  reporting_level,
  place_or_organization,
  hospital_peer_group,
  corporation,
  region,
  province_territory,
  urban_or_rural_remote,
  trend_note,
  time_scale,
  time_frame,
  SAFE_CAST(p90_hours_raw AS FLOAT64) AS p90_hours,
  p90_data_coverage,
  p90_performance_comparison,
  p90_performance_trend

FROM `ontario-ed-performance-2026.ontario_ed.raw_ed_admitted`

WHERE province_territory = 'Ontario'
  AND reporting_level = 'Corporation';
