-- Purpose:
-- Compare the relative severity of persistent performance gaps across
-- the two ED indicators by expressing each gap as a percentage of the
-- annual hospital peer-group median.


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
      AVG(
        SAFE_DIVIDE(
          initial_p90_hours - peer_median_initial_p90,
          peer_median_initial_p90
        ) * 100
      ),
      1
    ) AS avg_initial_gap_pct,

    ROUND(
      AVG(
        SAFE_DIVIDE(
          admitted_p90_hours - peer_median_admitted_p90,
          peer_median_admitted_p90
        ) * 100
      ),
      1
    ) AS avg_admitted_gap_pct

  FROM peer_benchmarks

  GROUP BY
    corporation,
    hospital_peer_group
)

SELECT
  corporation,
  hospital_peer_group,
  avg_initial_gap_pct,
  avg_admitted_gap_pct

FROM corporation_summary

WHERE initial_available_years >= 4
  AND initial_years_above_peer_median >= 4
  AND admitted_years_above_peer_median >= 4

ORDER BY
  avg_initial_gap_pct + avg_admitted_gap_pct DESC;
