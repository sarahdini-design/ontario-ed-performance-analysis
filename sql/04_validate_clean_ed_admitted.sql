SELECT
  COUNT(*) AS total_rows,
  COUNTIF(p90_data_coverage IS NULL) AS null_coverage,
  COUNTIF(p90_performance_comparison IS NULL) AS null_comparison,
  COUNTIF(p90_performance_trend IS NULL) AS null_trend,
  COUNTIF(trend_note IS NULL) AS null_trend_note
FROM `ontario-ed-performance-2026.ontario_ed.clean_ed_admitted`;
