# Project Log

A short record of the main milestones and analytical decisions made during the Ontario Emergency Department Performance Analysis project.

## August 2026 — Project Setup

- Chose Ontario emergency department performance as the focus of the project.
- Defined the initial scope around publicly available healthcare data.
- Created the GitHub repository and started outlining the analytical questions.

## August 2026 — Data Source Review

- Selected two CIHI datasets:
  - Emergency Department Wait Time for Physician Initial Assessment
  - Total Time Spent in Emergency Department for Admitted Patients
- Confirmed that both datasets contain multi-year Ontario data at the hospital corporation level.
- Began reviewing the structure, definitions, and available comparison fields.

## August 2026 — Data Familiarization

- Defined the analytical scope as Ontario hospital corporations.
- Confirmed a grain of one hospital corporation per fiscal year.
- Confirmed 64 corporations across five fiscal years, giving 320 corporation-year records in each dataset.
- Identified 17 suppressed physician initial-assessment records across five corporations.
- Reviewed CIHI trend notes and other data-quality considerations that could affect longitudinal comparisons.
- Confirmed that the two datasets could be aligned using `Corporation + Time frame`.le filtering and cleaning, validate the analytical subsets, and integrate the two indicators.

## August 2026 — Data Cleaning and Validation

- Imported both CIHI datasets into BigQuery.
- Filtered the data to Ontario hospital corporations and removed non-data rows.
- Checked row counts, duplicate corporation-year records, numeric fields, and missing values.
- Treated suppressed physician initial-assessment values as unavailable rather than zero.
- Created cleaned tables for both indicators.

## August 2026 — Data Integration

- Joined the two cleaned datasets using `Corporation + Time frame`.
- Confirmed that all 320 corporation-year combinations matched across the two datasets.
- Created an integrated table containing both ED indicators.
- Kept suppression flags so missing initial-assessment values could still be identified during analysis.

## August 2026 — Peer Benchmarking

- Compared corporations with others in the same hospital peer group rather than using one Ontario-wide benchmark.
- Used the annual peer-group median as the analytical benchmark because the data included some unusually high values.
- Calculated each corporation's gap from its peer median in both hours and percentage.
- Kept this benchmark separate from CIHI's official performance-comparison methodology.

## August 2026 — Persistent Gap Analysis

- Defined a persistent gap as being above the annual peer-group median in at least 4 of 5 fiscal years.
- Used the rule for both initial physician assessment and admitted-patient ED stay.
- Marked corporations with too few usable initial-assessment years as `Insufficient data`.
- Compared persistent-gap patterns across the two indicators and hospital peer groups.
- Created an analysis-ready dataset for visualization.

## August–September 2026 — Tableau Analysis

- Built five-year trend views for both ED indicators.
- Created peer-benchmark comparisons for the latest fiscal year.
- Added a persistent-gap pattern view across Ontario hospital corporations.
- Built corporation-level views to compare individual P90 values with annual peer-group medians.
- Added filters and tooltips so the results could be explored interactively.

## September 2026 — Final Analysis

- Compared the latest-year results with the five-year persistent-gap classifications.
- Identified corporations where long-term and current-year patterns were aligned, as well as cases where the latest year showed a different pattern.
- Reviewed results by hospital peer group.
- Added limitations to avoid treating wait-time differences as evidence of operational causes.

## September 2026 — Case Study Completed

- Finalized the Tableau Public dashboards.
- Documented the main findings, insights, limitations, and recommendations in the README.
- Added selected dashboard screenshots and links to the interactive Tableau views.
- Organized SQL scripts, methodology notes, and supporting documentation in the GitHub repository.
