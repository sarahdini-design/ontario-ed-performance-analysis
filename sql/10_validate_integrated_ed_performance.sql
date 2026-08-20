-- Validate row counts and P90 completeness
-- after integrating the two ED performance datasets.

SELECT
  COUNT(*) AS total_rows,

  COUNT(initial_p90_hours) AS numeric_initial_p90,
  COUNTIF(initial_p90_hours IS NULL) AS null_initial_p90,
  COUNTIF(initial_p90_is_suppressed = TRUE) AS suppressed_initial_rows,

  COUNT(admitted_p90_hours) AS numeric_admitted_p90,
  COUNTIF(admitted_p90_hours IS NULL) AS null_admitted_p90

FROM `ontario-ed-performance-2026.ontario_ed.ed_performance_integrated`;
