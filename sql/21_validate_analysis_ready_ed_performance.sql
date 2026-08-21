SELECT
  corporation,
  time_frame,
  COUNT(*) AS row_count
FROM `ontario-ed-performance-2026.ontario_ed.ed_performance_analysis_ready`
GROUP BY
  corporation,
  time_frame
HAVING COUNT(*) > 1;
