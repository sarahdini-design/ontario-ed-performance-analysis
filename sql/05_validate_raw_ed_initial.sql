-- ============================================================
-- 05_validate_raw_ed_initial.sql
-- Purpose:
-- Validate the raw Physician Initial Assessment dataset
-- before creating the clean analytical table.
-- ============================================================

-- 1. Validate Ontario corporation-level row count
-- Expected result: 320 rows

SELECT
  COUNT(*) AS ontario_corporation_rows
FROM `ontario-ed-performance-2026.ontario_ed.raw_ed_initial`
WHERE province_territory = 'Ontario'
  AND reporting_level = 'Corporation';


-- 2. Validate number of unique corporations
-- Expected result: 64 corporations

SELECT
  COUNT(DISTINCT corporation) AS unique_corporations
FROM `ontario-ed-performance-2026.ontario_ed.raw_ed_initial`
WHERE province_territory = 'Ontario'
  AND reporting_level = 'Corporation';


-- 3. Count suppressed P90 records
-- Expected result: 17 suppressed records

SELECT
  COUNT(*) AS suppressed_rows
FROM `ontario-ed-performance-2026.ontario_ed.raw_ed_initial`
WHERE province_territory = 'Ontario'
  AND reporting_level = 'Corporation'
  AND p90_hours_raw = 'Suppressed';


-- 4. Check for duplicate corporation-year records
-- Expected result: no rows returned

SELECT
  corporation,
  time_frame,
  COUNT(*) AS row_count
FROM `ontario-ed-performance-2026.ontario_ed.raw_ed_initial`
WHERE province_territory = 'Ontario'
  AND reporting_level = 'Corporation'
GROUP BY corporation, time_frame
HAVING COUNT(*) > 1;


-- 5. Identify suppressed corporation-year records

SELECT
  corporation,
  time_frame,
  p90_hours_raw
FROM `ontario-ed-performance-2026.ontario_ed.raw_ed_initial`
WHERE province_territory = 'Ontario'
  AND reporting_level = 'Corporation'
  AND p90_hours_raw = 'Suppressed'
ORDER BY corporation, time_frame;


-- 6. Summarize suppressed records by corporation

SELECT
  corporation,
  COUNT(*) AS suppressed_count
FROM `ontario-ed-performance-2026.ontario_ed.raw_ed_initial`
WHERE province_territory = 'Ontario'
  AND reporting_level = 'Corporation'
  AND p90_hours_raw = 'Suppressed'
GROUP BY corporation
ORDER BY suppressed_count DESC;
