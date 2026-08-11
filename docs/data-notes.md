# Data Familiarization Notes

## Dataset 1
**Name:** Total Time Spent in Emergency Department for Admitted Patients  
**Source:** Canadian Institute for Health Information (CIHI)

### What does this dataset measure?
To be completed after reviewing the dataset documentation.

### Time period
To be confirmed.

### Geographic / reporting levels
To be confirmed.

### Key fields
To be confirmed.

### Potential KPI
To be confirmed.

### Data quality observations
To be confirmed.

### Limitations
To be confirmed.


## Dataset 2
**Name:** Emergency Department Wait Time for Physician Initial Assessment  
**Source:** Canadian Institute for Health Information (CIHI)

### What does this dataset measure?
To be completed after reviewing the dataset documentation.

### Time period
To be confirmed.

### Geographic / reporting levels
To be confirmed.

### Key fields
To be confirmed.

### Potential KPI
To be confirmed.
### Grain
At the Ontario corporation level, each row represents one hospital corporation for one fiscal year.

The dataset contains five fiscal years of data (2020–2021 through 2024–2025), resulting in 320 Ontario corporation-level records across 64 hospital corporations.
### Data quality observations
Performance comparison and performance trend appear to be populated only for the most recent fiscal year (2024–2025), so they will be treated as current-status metadata rather than longitudinal measures.

### Limitations
To be confirmed.

### Dataset 1 grain: one Ontario hospital corporation per fiscal year
64 Ontario hospital corporations × 5 fiscal years = 320 corporation-level rows
90th percentile is the main numerical measure
lower values indicate better performance
Performance comparison and Performance trend appear to be populated mainly for the latest fiscal year
### example observation: some corporations show worsening trends over time, while others level off; these are preliminary observations only, not final findings
Preliminary review shows different longitudinal patterns across hospital corporations. Some organizations show increasing 90th-percentile ED times over several years, while others appear relatively stable after an earlier increase. These observations will be validated during formal analysis

### Data coverage 
No Ontario corporation-level records were flagged as having partial data coverage in this indicator dataset.

### Performance trend (2024–2025) 
Among 64 Ontario hospital corporations, 57 were classified by CIHI as “No change,” 5 as “Weakening,” and 2 as “Improving.” The CIHI methodology for assigning trend classifications should be reviewed before using this field in the final analysis.

### CIHI Performance Classifications

**Performance comparison**
For hospitals, CIHI compares performance with the hospital's peer group average.
Results are classified as:
- Above average performance
- Same as average performance
- Below average performance

These classifications reflect statistical comparison, not simply whether the reported value is numerically above or below the peer-group average.

**Performance trend**
CIHI classifies longitudinal performance as:
- Improving
- No change
- Weakening

"Improving" and "Weakening" indicate statistically significant trends over time.
"No change" indicates that no statistically significant trend was identified and suggests relatively stable performance.
