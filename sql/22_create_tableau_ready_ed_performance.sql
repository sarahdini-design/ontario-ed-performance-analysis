CREATE OR REPLACE TABLE
  `ontario-ed-performance-2026.ontario_ed.ed_performance_tableau_ready` AS

SELECT
  *,

  CASE time_frame
    WHEN '2020–2021' THEN 1
    WHEN '2021–2022' THEN 2
    WHEN '2022–2023' THEN 3
    WHEN '2023–2024' THEN 4
    WHEN '2024–2025' THEN 5
  END AS year_order

FROM `ontario-ed-performance-2026.ontario_ed.ed_performance_analysis_ready`;
