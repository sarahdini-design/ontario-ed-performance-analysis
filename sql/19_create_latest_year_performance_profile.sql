-- Create a 2024–2025 performance profile for each Ontario hospital
-- corporation by combining current peer-benchmark gaps with five-year
-- persistent gap status and CIHI performance metadata for both ED indicators.


WITH peer_benchmarks AS (

  SELECT
    corporation,
    hospital_peer_group,
    region,
    urban_or_rural_remote,
    time_frame,

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
)

SELECT
  p.corporation,
  p.hospital_peer_group,
  p.region,
  p.urban_or_rural_remote,

  p.initial_p90_hours,
  ROUND(p.peer_median_initial_p90, 2) AS peer_median_initial_p90,

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
  s.initial_gap_status,

  p.admitted_p90_hours,
  ROUND(p.peer_median_admitted_p90, 2) AS peer_median_admitted_p90,

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
  s.admitted_gap_status

FROM peer_benchmarks AS p

INNER JOIN corporation_status AS s
  ON p.corporation = s.corporation
  AND p.hospital_peer_group = s.hospital_peer_group

WHERE p.time_frame = '2024–2025'

ORDER BY p.corporation;
