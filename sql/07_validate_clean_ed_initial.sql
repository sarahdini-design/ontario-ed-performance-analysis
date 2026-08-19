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
