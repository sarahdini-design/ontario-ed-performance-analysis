WITH corporation_level AS (
  SELECT DISTINCT
    corporation,
    hospital_peer_group,
    performance_gap_pattern
  FROM `ontario-ed-performance-2026.ontario_ed.ed_performance_analysis_ready`
),

pattern_counts AS (
  SELECT
    hospital_peer_group,
    performance_gap_pattern,
    COUNT(*) AS corporation_count
  FROM corporation_level
  GROUP BY
    hospital_peer_group,
    performance_gap_pattern
)

SELECT
  hospital_peer_group,
  performance_gap_pattern,
  corporation_count,

  SUM(corporation_count) OVER (
    PARTITION BY hospital_peer_group
  ) AS total_corporations_in_peer_group,

  ROUND(
    100 * SAFE_DIVIDE(
      corporation_count,
      SUM(corporation_count) OVER (
        PARTITION BY hospital_peer_group
      )
    ),
    1
  ) AS pct_of_peer_group

FROM pattern_counts

ORDER BY
  hospital_peer_group,
  corporation_count DESC;
