-- ============================================================
-- 08_validate_join_keys.sql
-- Purpose:
-- Validate that the two cleaned ED datasets can be joined
-- reliably using corporation + time_frame as the composite key.
-- ============================================================


-- 1. Count matching corporation-year records
-- INNER JOIN keeps only records that exist in both datasets.
-- Expected result: 320 matched rows.

SELECT
  COUNT(*) AS matched_rows
FROM `ontario-ed-performance-2026.ontario_ed.clean_ed_admitted` AS admitted

INNER JOIN `ontario-ed-performance-2026.ontario_ed.clean_ed_initial` AS initial
  ON admitted.corporation = initial.corporation
  AND admitted.time_frame = initial.time_frame;


-- 2. Check for unmatched records in either dataset
-- FULL OUTER JOIN keeps matched records as well as records that
-- exist in only one of the two datasets.
-- Expected result:
-- only_in_initial = 0
-- only_in_admitted = 0

SELECT
  COUNTIF(admitted.corporation IS NULL) AS only_in_initial,
  COUNTIF(initial.corporation IS NULL) AS only_in_admitted

FROM `ontario-ed-performance-2026.ontario_ed.clean_ed_admitted` AS admitted

FULL OUTER JOIN `ontario-ed-performance-2026.ontario_ed.clean_ed_initial` AS initial
  ON admitted.corporation = initial.corporation
  AND admitted.time_frame = initial.time_frame;
