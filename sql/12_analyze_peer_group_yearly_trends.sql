-- Purpose:
-- Compare annual ED performance across Ontario hospital peer groups.
-- Calculates available record counts, mean P90, and median P90
-- for both Physician Initial Assessment and admitted patient ED stay.


WITH peer_year_metrics AS (

  SELECT
    time_frame,
    hospital_peer_group,
    initial_p90_hours,
    admitted_p90_hours,

    PERCENTILE_CONT(initial_p90_hours, 0.5)
      OVER (
        PARTITION BY time_frame, hospital_peer_group
      ) AS median_initial_p90_hours,

    PERCENTILE_CONT(admitted_p90_hours, 0.5)
      OVER (
        PARTITION BY time_frame, hospital_peer_group
      ) AS median_admitted_p90_hours

  FROM `ontario-ed-performance-2026.ontario_ed.ed_performance_integrated`
)

SELECT
  time_frame,
  hospital_peer_group,

  COUNT(initial_p90_hours) AS initial_available_records,
  ROUND(AVG(initial_p90_hours), 2) AS avg_initial_p90_hours,
  ROUND(MAX(median_initial_p90_hours), 2) AS median_initial_p90_hours,

  COUNT(admitted_p90_hours) AS admitted_available_records,
  ROUND(AVG(admitted_p90_hours), 2) AS avg_admitted_p90_hours,
  ROUND(MAX(median_admitted_p90_hours), 2) AS median_admitted_p90_hours

FROM peer_year_metrics

GROUP BY
  time_frame,
  hospital_peer_group

ORDER BY
  time_frame,
  hospital_peer_group;
