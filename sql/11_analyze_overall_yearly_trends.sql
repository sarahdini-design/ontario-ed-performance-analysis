-- Summarize annual ED performance across Ontario hospital corporations.
-- Calculates the number of available records, mean P90, and median P90
-- for both Physician Initial Assessment and total ED stay for admitted patients.

WITH yearly_metrics AS (

  SELECT
    time_frame,
    initial_p90_hours,
    admitted_p90_hours,

    PERCENTILE_CONT(initial_p90_hours, 0.5)
      OVER (PARTITION BY time_frame) AS median_initial_p90_hours,

    PERCENTILE_CONT(admitted_p90_hours, 0.5)
      OVER (PARTITION BY time_frame) AS median_admitted_p90_hours

  FROM `ontario-ed-performance-2026.ontario_ed.ed_performance_integrated`
)

SELECT
  time_frame,

  COUNT(initial_p90_hours) AS initial_available_records,
  ROUND(AVG(initial_p90_hours), 2) AS avg_initial_p90_hours,
  ROUND(MAX(median_initial_p90_hours), 2) AS median_initial_p90_hours,

  COUNT(admitted_p90_hours) AS admitted_available_records,
  ROUND(AVG(admitted_p90_hours), 2) AS avg_admitted_p90_hours,
  ROUND(MAX(median_admitted_p90_hours), 2) AS median_admitted_p90_hours

FROM yearly_metrics

GROUP BY time_frame

ORDER BY time_frame;
