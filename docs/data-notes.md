
# Data Familiarization Notes

This document records the structure, methodology, data-quality observations, and preliminary analytical considerations for the two CIHI datasets used in the Ontario Emergency Department Performance Analysis project.

---

## Dataset 1

### Total Time Spent in Emergency Department for Admitted Patients

**Analytical dataset name:** Ontario Corporation-Level ED Admitted Patient Data

**Raw source:** Total Time Spent in Emergency Department for Admitted Patients  
**Source organization:** Canadian Institute for Health Information (CIHI)  
**Underlying data source:** National Ambulatory Care Reporting System (NACRS)

### Analytical Subset

The original CIHI dataset contains multiple reporting levels and jurisdictions.

For this project, the analytical subset is restricted to:

- **Province/Territory:** Ontario
- **Reporting level:** Corporation

The resulting analytical dataset contains:

- **320 corporation-year records**
- **64 Ontario hospital corporations**
- **5 fiscal years**
- **Time period:** 2020–2021 through 2024–2025

### Analytical Grain

**One row represents one Ontario hospital corporation in one fiscal year.**

Therefore:

`64 hospital corporations × 5 fiscal years = 320 corporation-level rows`

This analytical grain is different from the CIHI indicator's underlying unit of analysis.

### Indicator Definition

**Indicator:** Total Time Spent in Emergency Department for Admitted Patients

The indicator measures the time interval between the earlier of registration or triage and the time an admitted patient leaves the emergency department.

- **CIHI unit of analysis:** Single ED visit
- **Type of measurement:** Number of hours, percentile
- **Primary project measure:** 90th percentile
- **Direction:** Lower values indicate better performance.
- **Geographic assignment:** Place of service
- **Adjustment:** None

### Interpretation of the 90th Percentile

The 90th percentile represents the maximum ED length of stay within which 90% of admitted ED patients completed their ED stay.

For example, a value of 30 hours means that 90% of admitted patients completed their ED stay within 30 hours, while approximately 10% experienced longer ED stays.

The 90th percentile is not an average.

### Inclusion / Exclusion Notes

The indicator includes:

- Unscheduled emergency department visits resulting in admission.
- ED visits with valid and known registration or triage timestamps.
- Records with a valid and known time when the patient left the ED.

Excluded records include:

- Scheduled emergency visits.
- Non-admitted unscheduled emergency visits.
- Stillborn records.
- Records with missing or invalid required timestamps.

### Hospital Peer Groups

Ontario hospital corporations are classified into peer groups such as:

- Teaching
- Community—Large
- Community—Medium
- Community—Small

Peer groups provide a more appropriate comparison context because hospital organizations may differ substantially in size, role, and patient population.

For hospital performance comparisons, CIHI compares hospitals with their **peer group average** rather than simply comparing all hospitals with the Ontario average.

### Exploratory Peer-Group Benchmark

As an exploratory exercise, Ontario `Community—Large` corporations were examined for fiscal year 2024–2025.

There were:

- **25 Community—Large corporations**
- **Mean 90th-percentile ED time:** approximately 43.6 hours
- **Median 90th-percentile ED time:** 42.0 hours

The difference between the mean and median suggests that high values among some corporations may influence the arithmetic mean.

The median may therefore be useful as a robust descriptive benchmark when examining peer-group performance.

This is an analyst-created exploratory benchmark and should not be confused with CIHI's official statistical performance classification.

### Data Coverage

No Ontario corporation-level records in this indicator dataset were explicitly flagged as having **partial data coverage**.

This does not necessarily mean that every record has 100% coverage; it means that none of the 320 Ontario corporation-level records were marked by CIHI with the `Partial data coverage` flag.

### CIHI Performance Classifications

#### Performance Comparison

For hospitals, CIHI compares performance with the hospital's peer group average.

Results are classified as:

- **Above average performance**
- **Same as average performance**
- **Below average performance**

These categories are based on statistical comparison.

Therefore, `Same as average performance` does not mean that a hospital's numerical value is exactly equal to the peer-group average. It means that its performance is not statistically different from the comparison average according to CIHI's methodology.

#### Performance Trend

CIHI classifies longitudinal performance as:

- **Improving**
- **No change**
- **Weakening**

`Improving` indicates a statistically significant trend toward improved performance over time.

`Weakening` indicates a statistically significant trend toward declining performance over time.

`No change` indicates that no statistically significant trend was identified and suggests relatively stable performance.

Therefore, `No change` does not mean that yearly values are numerically identical.

### Performance Trend Profile — 2024–2025

Among the 64 Ontario hospital corporations in 2024–2025:

- **57** were classified as `No change`
- **5** were classified as `Weakening`
- **2** were classified as `Improving`

These are CIHI-generated classifications and should not be treated as analyst-calculated trends.

### Preliminary Longitudinal Observations

Initial exploration shows that hospital corporations can follow different patterns over time.

Some corporations show increasing 90th-percentile ED times across several fiscal years, while others show an earlier increase followed by relatively stable values.

These observations are preliminary and will be validated during formal analysis rather than treated as final findings.

Care should also be taken not to describe small numerical differences as statistically significant unless a statistical test or an official CIHI classification supports that conclusion.

### Trend Notes

Two Ontario corporation-level records contain CIHI trend notes:

- **Sunnybrook Health Sciences Centre**
- **Scarborough Health Network**

The notes indicate historical organizational and/or data-attribution changes.

Longitudinal comparisons involving these organizations should therefore be interpreted with caution because changes over time may partly reflect changes in organizational structure or data attribution rather than ED performance alone.

### Methodological Considerations

CIHI notes that coverage in the National Ambulatory Care Reporting System (NACRS) can change over time as additional jurisdictions participate.

This should be considered when interpreting longitudinal results.

The methodology page lists:

- **Targets/Benchmarks:** Not applicable
- **Method of adjustment:** Not applicable
- **Adjustment applied:** None

Therefore, the project should avoid presenting an analyst-created peer-group mean or median as an official CIHI target.

### Key Fields

Important fields for the planned analysis include:

- Indicator
- Reporting level
- Place or organization
- Hospital Peer Group
- Corporation
- Region
- Province/Territory
- Trend note
- Time Scale
- Time frame
- 90th percentile
- 90th percentile: Data coverage
- 90th percentile: Performance comparison
- 90th percentile: Performance trend

### Potential KPI

**90th-percentile total ED time for admitted patients (hours)**

Additional derived metrics may later include:

- Change over time
- Peer-group comparison
- Gap from peer-group benchmark
- Persistence of relatively poor performance

These derived metrics will be finalized during the analysis-design stage.

---

## Dataset 2 — Emergency Department Wait Time for Physician Initial Assessment

**Analytical dataset name:** Ontario Corporation-Level ED Physician Initial Assessment Data  
**Raw source:** Emergency Department Wait Time for Physician Initial Assessment  
**Source organization:** Canadian Institute for Health Information (CIHI)  
**Underlying data source:** National Ambulatory Care Reporting System (NACRS)

### Analytical Subset

The original CIHI dataset contains multiple reporting levels and jurisdictions.

For this project, the analytical subset is restricted to:

- **Province/Territory:** `Ontario`
- **Reporting level:** `Corporation`

The resulting analytical dataset contains:

- **320 corporation-year records**
- **64 Ontario hospital corporations**
- **5 fiscal years**
- **Time period:** 2020–2021 through 2024–2025

### Analytical Grain

**One row represents one Ontario hospital corporation in one fiscal year.**

Therefore:

`64 hospital corporations × 5 fiscal years = 320 corporation-level rows`

This analytical grain is different from the CIHI indicator's underlying unit of analysis.

### Indicator Definition

**Indicator:** Emergency Department Wait Time for Physician Initial Assessment

The indicator measures the time interval between the earlier of registration or triage and the time of the patient's initial physician assessment in the emergency department.

CIHI uses the earlier of registration or triage as the starting point because either event may occur first depending on hospital workflow and patient circumstances.

- **CIHI unit of analysis:** Single ED visit
- **Type of measurement:** Number of hours, percentile
- **Primary project measure:** 90th percentile
- **Direction:** Lower values indicate better performance.
- **Geographic assignment:** Place of service
- **Adjustment:** None

### Interpretation of the 90th Percentile

The 90th percentile represents the maximum wait time within which 90% of included ED patients received their initial physician assessment.

For example, a value of 5 hours means that 90% of included ED visits received an initial physician assessment within 5 hours, while approximately 10% waited longer.

The 90th percentile is not an average.

### Inclusion / Exclusion Notes

The indicator includes unscheduled emergency department visits with:

- A valid and known registration or triage date/time.
- A valid and known physician assessment date/time.

Excluded records include:

- Scheduled emergency visits.
- Stillborn records.
- Unscheduled ED visits with Visit Disposition 61 (`leave post-registration`).
- Unscheduled ED visits with Visit Disposition 63 (`left after triage`).
- Records where both registration and triage date/time are unknown.
- Records where physician assessment date/time is unknown.

### Targets / Benchmarks

CIHI lists the formal target/benchmark for this indicator as:

`Not applicable`

Therefore, analyst-created peer-group averages or medians should not be presented as official CIHI targets.

### Data Quality — Suppressed Values

Unlike Dataset 1, Dataset 2 contains records where the `90th percentile` value is reported as:

`Suppressed`

There are:

- **17 suppressed corporation-year records**
- **303 non-suppressed corporation-year records**

Suppressed values must not be interpreted as zero.

They will be treated as unavailable values during analysis.

### Distribution of Suppressed Records

The 17 suppressed records are concentrated in five hospital corporations:

| Hospital Corporation | Suppressed Years |
|---|---:|
| North Shore Health Network | 3 |
| Blanche River Health | 4 |
| MICs Group of Health Services | 4 |
| Weeneebayko Area Health Authority | 5 |
| North of Superior Healthcare Group | 1 |
| **Total** | **17** |

Weeneebayko Area Health Authority has suppressed values for all five fiscal years, meaning a five-year trend for this indicator cannot be evaluated for that corporation using the published values.

For the other affected corporations, some fiscal years remain available for analysis.

### Analytical Implication of Suppression

Suppression is concentrated in a small number of organizations rather than being distributed across all 64 corporations.

This should be considered when:

- Comparing hospital corporations.
- Calculating peer-group statistics.
- Evaluating longitudinal trends.
- Combining this indicator with Dataset 1.

The available indicator methodology reviewed so far does not state the specific reason for these suppressed values.

Therefore, no assumption will be made that suppression is caused by low counts, privacy rules, or another specific factor unless confirmed by CIHI documentation.


### Methodological Considerations

CIHI notes that coverage in the National Ambulatory Care Reporting System (NACRS) can change over time as additional jurisdictions participate.

This should be considered when interpreting longitudinal results.

The methodology page lists:

- **Targets/Benchmarks:** Not applicable
- **Method of adjustment:** Not applicable
- **Adjustment applied:** None
- **Geographic assignment:** Place of service
- **Data source:** NACRS

  **Two Ontario corporation-level records contain CIHI trend notes:**

- **Scarborough Health Network**
- **Sunnybrook Health Sciences Centre**

The notes indicate historical organizational and/or data-attribution changes.

For Scarborough Health Network, data previously attributed to legacy organizations are now attributed to Scarborough Health Network, with specified exceptions.

For Sunnybrook Health Sciences Centre, CIHI notes that the former Sunnybrook and Women's College Health Sciences Centre organization no longer exists and that historical data have been reassigned to successor organizations.

Longitudinal comparisons involving these organizations should therefore be interpreted with caution, because changes over time may partly reflect organizational restructuring or data-attribution changes rather than ED performance alone.

### Performance Trend Profile — 2024–2025

Among the 64 Ontario hospital corporations in 2024–2025:

- **53** were classified as `No change`
- **6** were classified as `Weakening`
- **5** had no reported trend classification (`–`)
- **0** were classified as `Improving`

The five corporations without a reported trend classification are the same organizations affected by suppressed values in this indicator dataset.

This suggests a possible relationship between data suppression and the absence of a trend classification; however, this relationship should not be treated as causal unless confirmed by CIHI documentation.

### Performance Comparison Profile — 2024–2025

Among the 64 Ontario hospital corporations in 2024–2025:

- **17** were classified as `Above average performance`
- **38** were classified as `Same as average performance`
- **8** were classified as `Below average performance`
- **1** had no reported performance comparison (`–`)

The corporation without a reported performance comparison was **Weeneebayko Area Health Authority**, for which the published 90th-percentile value is suppressed.

For hospitals, CIHI performance comparison is relative to the hospital's **peer group average** and reflects a statistical comparison rather than a simple numerical comparison with the overall Ontario average.

### Performance Comparison and Trend Metadata

- Performance Comparison and Performance Trend are populated only for the
  most recent fiscal year (2024–2025) in the Ontario corporation-level subset.
- Performance Comparison is available for 63 of 64 corporations.
- The five corporations without a trend classification are the same five
  corporations with at least one suppressed P90 observation during the
  five-year period.
- Trend classifications should therefore be interpreted cautiously for
  organizations with incomplete longitudinal data.



### Planned Data Integration

Datasets 1 and 2 share the same analytical structure:

- Ontario
- Corporation level
- 64 hospital corporations
- 5 fiscal years
- 320 corporation-year records

The planned analytical join key is:

`Corporation + Time frame`

After integration, each corporation-year record can potentially contain both:

1. **90th-percentile physician initial assessment wait time**
2. **90th-percentile total ED time for admitted patients**

Suppressed values in Dataset 2 will remain missing/unavailable after the datasets are joined and will not be replaced with zero.

### Analytical Purpose of Using Both Indicators

The two indicators represent different stages of the emergency department patient journey.




**Dataset 2** represents the period from arrival/triage or registration to initial physician assessment.

**Dataset 1** represents the broader ED stay for patients who are ultimately admitted, from registration/triage until they leave the ED after admission.

Using both measures may help distinguish between:

- Performance pressure before initial physician assessment.
- Performance pressure later in the ED journey for admitted patients.

This supports a more informative analysis than ranking hospital corporations using only a single ED wait-time measure.

