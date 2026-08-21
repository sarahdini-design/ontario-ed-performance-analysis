-- Purpose:
-- Identify Ontario hospital corporations with persistent performance gaps
-- relative to the median of their hospital peer group.
-- A persistent gap is defined as performance above the peer median
-- in at least 4 fiscal years, with at least 4 usable years required
-- for the Initial Assessment indicator.


WITH peer_benchmarks AS (

  SELECT
    corporation,
    time_frame,
    hospital_peer_group,
    initial_p90_hours,
    admitted_p90_hours,

    PERCENTILE_CONT(initial_p90_hours, 0.5)
      OVER (
        PARTITION BY time_frame, hospital_peer_group
      ) AS peer_median_initial_p90,

    PERCENTILE_CONT(admitted_p90_hours, 0.5)
      OVER (
        PARTITION BY time_frame, hospital_peer_group
      ) AS peer_median_admitted_p90

  FROM `ontario-ed-performance-2026.ontario_ed.ed_performance_integrated`
)

SELECT
  corporation,
  hospital_peer_group,

  COUNT(initial_p90_hours) AS initial_available_years,

  COUNTIF(
    initial_p90_hours > peer_median_initial_p90
  ) AS initial_years_above_peer_median,

  CASE
    WHEN COUNT(initial_p90_hours) >= 4
      AND COUNTIF(
        initial_p90_hours > peer_median_initial_p90
      ) >= 4
    THEN TRUE
    ELSE FALSE
  END AS persistent_initial_gap,

  COUNT(admitted_p90_hours) AS admitted_available_years,

  COUNTIF(
    admitted_p90_hours > peer_median_admitted_p90
  ) AS admitted_years_above_peer_median,

  CASE
    WHEN COUNTIF(
      admitted_p90_hours > peer_median_admitted_p90
    ) >= 4
    THEN TRUE
    ELSE FALSE
  END AS persistent_admitted_gap

FROM peer_benchmarks

GROUP BY
  corporation,
  hospital_peer_group

ORDER BY
  persistent_initial_gap DESC,
  persistent_admitted_gap DESC,
  corporation;
