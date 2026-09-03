-- Create the integrated ED performance table by combining both cleaned indicators.
-- Joins corporation-year records on corporation + time_frame and keeps measures from both stages of the ED journey.

CREATE OR REPLACE TABLE
  `ontario-ed-performance-2026.ontario_ed.ed_performance_integrated` AS

SELECT
  admitted.corporation,
  admitted.time_frame,
  admitted.hospital_peer_group,
  admitted.region,
  admitted.urban_or_rural_remote,

  initial.p90_hours AS initial_p90_hours,
  initial.p90_is_suppressed AS initial_p90_is_suppressed,
  initial.p90_performance_comparison AS initial_performance_comparison,
  initial.p90_performance_trend AS initial_performance_trend,
  initial.trend_note AS initial_trend_note,

  admitted.p90_hours AS admitted_p90_hours,
  admitted.p90_performance_comparison AS admitted_performance_comparison,
  admitted.p90_performance_trend AS admitted_performance_trend,
  admitted.trend_note AS admitted_trend_note

FROM `ontario-ed-performance-2026.ontario_ed.clean_ed_admitted` AS admitted

INNER JOIN `ontario-ed-performance-2026.ontario_ed.clean_ed_initial` AS initial
  ON admitted.corporation = initial.corporation
  AND admitted.time_frame = initial.time_frame;
