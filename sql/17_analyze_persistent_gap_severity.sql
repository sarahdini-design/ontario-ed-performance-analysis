-- Purpose:
-- Examine the severity of persistent performance gaps among Ontario
-- hospital corporations with persistent gaps in both ED indicators.
-- Calculates the average difference from the annual peer-group median
-- for Physician Initial Assessment and admitted patient ED stay.


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

corporation_summary AS (

  SELECT
    corporation,
    hospital_peer_group,

    COUNT(initial_p90_hours) AS initial_available_years,

    COUNTIF(
      initial_p90_hours > peer_median_initial_p90
    ) AS initial_years_above_peer_median,

    COUNTIF(
      admitted_p90_hours > peer_median_admitted_p90
    ) AS admitted_years_above_peer_median,

    ROUND(
      AVG(initial_p90_hours - peer_median_initial_p90),
      2
    ) AS avg_initial_gap_hours,

    ROUND(
      AVG(admitted_p90_hours - peer_median_admitted_p90),
      2
    ) AS avg_admitted_gap_hours

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
  admitted_years_above_peer_median,
  avg_initial_gap_hours,
  avg_admitted_gap_hours

FROM corporation_summary

WHERE initial_available_years >= 4
  AND initial_years_above_peer_median >= 4
  AND admitted_years_above_peer_median >= 4

ORDER BY
  avg_admitted_gap_hours DESC;
