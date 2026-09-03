-- Benchmark each Ontario hospital corporation against the median performance
-- of its hospital peer group in the same fiscal year.
-- Calculates performance gaps for both Physician Initial Assessment
-- and admitted patient ED stay.


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
  time_frame,
  hospital_peer_group,

  initial_p90_hours,
  ROUND(peer_median_initial_p90, 2) AS peer_median_initial_p90,
  ROUND(
    initial_p90_hours - peer_median_initial_p90,
    2
  ) AS initial_gap_hours,

  admitted_p90_hours,
  ROUND(peer_median_admitted_p90, 2) AS peer_median_admitted_p90,
  ROUND(
    admitted_p90_hours - peer_median_admitted_p90,
    2
  ) AS admitted_gap_hours

FROM peer_benchmarks

ORDER BY
  corporation,
  time_frame;
