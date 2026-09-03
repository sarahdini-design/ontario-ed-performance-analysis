-- Compare the latest-year position of corporations with persistent gaps in both indicators.
-- Use 2024–2025 peer-group gaps to identify useful candidates for further investigation.

SELECT
  corporation,
  hospital_peer_group,

  ROUND(initial_p90_hours, 1) AS initial_p90_hours,
  ROUND(peer_median_initial_p90, 1) AS peer_median_initial_p90,
  ROUND(initial_gap_pct, 1) AS initial_gap_pct,

  ROUND(admitted_p90_hours, 1) AS admitted_p90_hours,
  ROUND(peer_median_admitted_p90, 1) AS peer_median_admitted_p90,
  ROUND(admitted_gap_pct, 1) AS admitted_gap_pct,

  CASE
    WHEN initial_gap_pct > 0 AND admitted_gap_pct > 0
      THEN 'Above peer median in both'
    WHEN initial_gap_pct > 0
      THEN 'Above peer median in initial only'
    WHEN admitted_gap_pct > 0
      THEN 'Above peer median in admitted only'
    ELSE 'At or below peer median in both'
  END AS current_2024_25_position

FROM `ontario-ed-performance-2026.ontario_ed.ed_performance_analysis_ready`

WHERE time_frame = '2024–2025'
  AND performance_gap_pattern = 'Persistent gap in both indicators'

ORDER BY
  CASE
    WHEN initial_gap_pct > 0 AND admitted_gap_pct > 0 THEN 1
    ELSE 2
  END,
  admitted_gap_pct DESC;


-- Create a concise latest-year summary for corporations
-- with persistent gaps in both ED indicators.

SELECT
  corporation,
  hospital_peer_group,
  ROUND(initial_gap_pct, 1) AS initial_gap_pct,
  ROUND(admitted_gap_pct, 1) AS admitted_gap_pct,

  CASE
    WHEN initial_gap_pct > 0 AND admitted_gap_pct > 0
      THEN 'Above peer median in both'
    WHEN initial_gap_pct > 0
      THEN 'Above peer median in initial only'
    WHEN admitted_gap_pct > 0
      THEN 'Above peer median in admitted only'
    ELSE 'At or below peer median in both'
  END AS current_2024_25_position

FROM `ontario-ed-performance-2026.ontario_ed.ed_performance_analysis_ready`

WHERE time_frame = '2024–2025'
  AND performance_gap_pattern = 'Persistent gap in both indicators'

ORDER BY
  CASE
    WHEN initial_gap_pct > 0 AND admitted_gap_pct > 0 THEN 1
    ELSE 2
  END,
  admitted_gap_pct DESC;
