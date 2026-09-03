-- Create the cleaned physician initial-assessment ED table for Ontario hospital corporations.
-- Standardizes placeholder values, converts P90 wait time to numeric, and flags suppressed records.

CREATE TABLE `ontario-ed-performance-2026.ontario_ed.clean_ed_initial` AS

SELECT
  indicator,
  reporting_level,
  place_or_organization,
  hospital_peer_group,
  corporation,
  region,
  province_territory,
  urban_or_rural_remote,

  NULLIF(TRIM(trend_note), '–') AS trend_note,

  time_scale,
  time_frame,

  SAFE_CAST(p90_hours_raw AS FLOAT64) AS p90_hours,

  p90_hours_raw = 'Suppressed' AS p90_is_suppressed,

  NULLIF(TRIM(p90_data_coverage), '–')
    AS p90_data_coverage,

  NULLIF(TRIM(p90_performance_comparison), '–')
    AS p90_performance_comparison,

  NULLIF(TRIM(p90_performance_trend), '–')
    AS p90_performance_trend

FROM `ontario-ed-performance-2026.ontario_ed.raw_ed_initial`

WHERE province_territory = 'Ontario'
  AND reporting_level = 'Corporation';
