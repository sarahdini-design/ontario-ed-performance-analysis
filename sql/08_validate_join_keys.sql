SELECT
  COUNT(*) AS matched_rows
FROM `ontario-ed-performance-2026.ontario_ed.clean_ed_admitted` AS admitted
INNER JOIN `ontario-ed-performance-2026.ontario_ed.clean_ed_initial` AS initial
  ON admitted.corporation = initial.corporation
  AND admitted.time_frame = initial.time_frame;
