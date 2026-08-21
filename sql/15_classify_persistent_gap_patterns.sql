-- Purpose:
-- Classify each Ontario hospital corporation based on the pattern of
-- persistent performance gaps across two ED indicators:
-- Physician Initial Assessment and admitted patient ED stay.
--
-- The query identifies whether a corporation has a persistent gap in:
-- both indicators, Initial Assessment only, admitted ED stay only,
-- neither indicator, or whether Initial Assessment data are insufficient.



WITH peer_benchmarks AS (

  SELECT
    corporation,
    hospital_peer_group,
    time_frame,
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
),

corporation_status AS (

  SELECT
    corporation,
    hospital_peer_group,

    COUNT(initial_p90_hours) AS initial_available_years,

    COUNTIF(
      initial_p90_hours > peer_median_initial_p90
    ) AS initial_years_above_peer_median,

    CASE
      WHEN COUNT(initial_p90_hours) < 4
        THEN 'Insufficient data'

      WHEN COUNTIF(
        initial_p90_hours > peer_median_initial_p90
      ) >= 4
        THEN 'Persistent gap'

      ELSE 'No persistent gap'
    END AS initial_gap_status,

    COUNTIF(
      admitted_p90_hours > peer_median_admitted_p90
    ) AS admitted_years_above_peer_median,

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
)

SELECT
  corporation,
  hospital_peer_group,
  initial_available_years,
  initial_years_above_peer_median,
  initial_gap_status,
  admitted_years_above_peer_median,
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

ORDER BY
  performance_gap_pattern,
  corporation;
