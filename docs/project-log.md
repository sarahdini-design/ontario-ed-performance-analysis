# Project Log

This log documents the key decisions, milestones, and changes made throughout the Ontario Emergency Department Performance Analysis project.

## August 2026 — Project Planning

- Selected healthcare analytics as the project domain.
- Chose Ontario emergency department performance as the initial area of investigation.
- Defined the goal of developing an end-to-end analysis using real-world public healthcare data.
- Planned to demonstrate SQL, data quality assessment, visualization, analytical reasoning, and responsible use of AI.

## August 2026 — Data Source Investigation

- Identified two official CIHI datasets related to emergency department performance:
  - Emergency Department Wait Time for Physician Initial Assessment.
  - Total Time Spent in Emergency Department for Admitted Patients.
- Confirmed that both datasets contain multi-year Ontario data at the hospital corporation level.
- Created the GitHub repository for the project.
- Next step: inspect both datasets and refine the business problem, analytical questions, and KPIs.

## August 2026 — Data Familiarization Completed

- Reviewed the structure and methodology of both CIHI emergency department datasets.
- Defined the analytical scope as Ontario hospital corporations.
- Confirmed an analytical grain of one hospital corporation per fiscal year.
- Confirmed 64 Ontario hospital corporations across five fiscal years, resulting in 320 corporation-year records per dataset.
- Reviewed CIHI definitions, inclusion/exclusion criteria, 90th-percentile interpretation, peer groups, performance classifications, data coverage, and trend notes.
- Identified 17 suppressed physician initial assessment records across five hospital corporations.
- Identified organizational/data-attribution considerations affecting longitudinal interpretation for Sunnybrook Health Sciences Centre and Scarborough Health Network.
- Confirmed that the two analytical datasets can be aligned using `Corporation + Time frame`.

**Next step:** Prepare the raw CIHI data for SQL import, perform reproducible filtering and cleaning, validate the analytical subsets, and integrate the two indicators.
