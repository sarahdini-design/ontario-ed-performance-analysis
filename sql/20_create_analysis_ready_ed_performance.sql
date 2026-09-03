-- Create the analysis-ready ED performance table used for the final analysis.
-- Adds annual peer-group benchmarks, gap measures, and five-year persistent-gap classifications for both ED indicators.
-- Keeps one row per hospital corporation per fiscal year.

CREATE OR REPLACE TABLE
  `ontario-ed-performance-2026.ontario_ed.ed_performance_analysis_ready` AS

WITH peer_benchmarks AS (

  SELECT
    corporation,
    time_frame,
    hospital_peer_group,
    region,
    urban_or_rural_remote,

    initial_p90_hours,
    initial_p90_is_suppressed,
    initial_performance_comparison,
    initial_performance_trend,

    admitted_p90_hours,
    admitted_performance_comparison,
    admitted_performance_trend,

    PERCENTILE_CONT(initial_p90_hours, 0.5)
      OVER (
        PARTITION BY time_frame, hospital_peer_group
      ) AS peer_median_initial_p90,

    PERCENTILE_CONT(admitted_p90_hours, 0.5)
      OVER (
        PARTITION BY time_frame, hospital_peer_group
      ) AS peer_median_admitted_p90

  FROM `ontario-ed-performance-2026.ontario_ed.ed_performance_integrated`
),

corporation_status AS (

  SELECT
    corporation,
    hospital_peer_group,

    CASE
      WHEN COUNT(initial_p90_hours) < 4
        THEN 'Insufficient data'

      WHEN COUNTIF(
        initial_p90_hours > peer_median_initial_p90
      ) >= 4
        THEN 'Persistent gap'

      ELSE 'No persistent gap'
    END AS initial_gap_status,

    CASE
      WHEN COUNTIF(
        admitted_p90_hours > peer_median_admitted_p90
      ) >= 4
        THEN 'Persistent gap'

      ELSE 'No persistent gap'
    END AS admitted_gap_status

  FROM peer_benchmarks

  GROUP BY
    corporation,
    hospital_peer_group
),

corporation_patterns AS (

  SELECT
    corporation,
    hospital_peer_group,
    initial_gap_status,
    admitted_gap_status,

    CASE
      WHEN initial_gap_status = 'Persistent gap'
        AND admitted_gap_status = 'Persistent gap'
        THEN 'Persistent gap in both indicators'

      WHEN initial_gap_status = 'Persistent gap'
        AND admitted_gap_status = 'No persistent gap'
        THEN 'Initial Assessment only'

      WHEN initial_gap_status = 'No persistent gap'
        AND admitted_gap_status = 'Persistent gap'
        THEN 'Admitted ED stay only'

      WHEN initial_gap_status = 'No persistent gap'
        AND admitted_gap_status = 'No persistent gap'
        THEN 'No persistent gap in either indicator'

      WHEN initial_gap_status = 'Insufficient data'
        AND admitted_gap_status = 'Persistent gap'
        THEN 'Admitted gap; Initial data insufficient'

      ELSE 'Initial data insufficient; no admitted gap'
    END AS performance_gap_pattern

  FROM corporation_status
)

SELECT
  p.corporation,
  p.time_frame,
  p.hospital_peer_group,
  p.region,
  p.urban_or_rural_remote,

  p.initial_p90_hours,
  p.initial_p90_is_suppressed,

  ROUND(
    p.peer_median_initial_p90,
    2
  ) AS peer_median_initial_p90,

  ROUND(
    p.initial_p90_hours - p.peer_median_initial_p90,
    2
  ) AS initial_gap_hours,

  ROUND(
    SAFE_DIVIDE(
      p.initial_p90_hours - p.peer_median_initial_p90,
      p.peer_median_initial_p90
    ) * 100,
    1
  ) AS initial_gap_pct,

  p.initial_performance_comparison,
  p.initial_performance_trend,

  p.admitted_p90_hours,

  ROUND(
    p.peer_median_admitted_p90,
    2
  ) AS peer_median_admitted_p90,

  ROUND(
    p.admitted_p90_hours - p.peer_median_admitted_p90,
    2
  ) AS admitted_gap_hours,

  ROUND(
    SAFE_DIVIDE(
      p.admitted_p90_hours - p.peer_median_admitted_p90,
      p.peer_median_admitted_p90
    ) * 100,
    1
  ) AS admitted_gap_pct,

  p.admitted_performance_comparison,
  p.admitted_performance_trend,

  s.initial_gap_status,
  s.admitted_gap_status,
  s.performance_gap_pattern

FROM peer_benchmarks AS p

INNER JOIN corporation_patterns AS s
  ON p.corporation = s.corporation
  AND p.hospital_peer_group = s.hospital_peer_group;
