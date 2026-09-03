-- Validate the cleaned physician initial-assessment ED table.
-- Checks P90 and suppression consistency, metadata completeness, and the availability of comparison and trend fields by fiscal year.

-- 1. Validate P90 values and suppression

SELECT
  COUNT(*) AS total_rows,

  COUNT(p90_hours) AS numeric_p90_rows,

  COUNTIF(p90_hours IS NULL) AS null_p90_rows,

  COUNTIF(p90_is_suppressed = TRUE) AS suppressed_rows,

  COUNTIF(
    p90_hours IS NULL
    AND p90_is_suppressed = FALSE
  ) AS unexpected_nulls,

  COUNTIF(
    p90_hours IS NOT NULL
    AND p90_is_suppressed = TRUE
  ) AS inconsistent_suppression

FROM `ontario-ed-performance-2026.ontario_ed.clean_ed_initial`;



-- 2. Validate metadata completeness

SELECT
  COUNT(*) AS total_rows,
  COUNTIF(p90_data_coverage IS NULL) AS null_coverage,
  COUNTIF(p90_performance_comparison IS NULL) AS null_comparison,
  COUNTIF(p90_performance_trend IS NULL) AS null_trend,
  COUNTIF(trend_note IS NULL) AS null_trend_note
FROM `ontario-ed-performance-2026.ontario_ed.clean_ed_initial`;


-- 3. Check which fiscal year contains comparison and trend metadata

SELECT
  time_frame,
  COUNT(*) AS total_rows,
  COUNT(p90_performance_comparison) AS populated_comparison,
  COUNT(p90_performance_trend) AS populated_trend
FROM `ontario-ed-performance-2026.ontario_ed.clean_ed_initial`
GROUP BY time_frame
ORDER BY time_frame;
