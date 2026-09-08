# Ontario Emergency Department Performance Analysis

A five-year analysis of emergency department wait times across Ontario hospital corporations using public data from the Canadian Institute for Health Information (CIHI).

**Tools:** BigQuery (SQL) · Tableau Public · GitHub

## Project Overview

Emergency department performance can look very different depending on which part of the patient journey is being measured. In this project, I looked at two CIHI indicators:

- Physician Initial Assessment wait time
- Total ED time for patients who were admitted

When I first reviewed the CIHI data, I noticed that the two ED indicators could tell very different stories about the same hospital corporation. That led me to a question I wanted to explore: were some performance gaps showing up repeatedly over time, and if so, at which stage of the ED visit?

## Data Sources

This analysis uses two publicly available emergency department indicators from the Canadian Institute for Health Information (CIHI):

- [Emergency Department Wait Time for Physician Initial Assessment](https://www.cihi.ca/en/indicators/emergency-department-wait-time-for-physician-initial-assessment)
- [Total Time Spent in Emergency Department for Admitted Patients](https://www.cihi.ca/en/indicators/total-time-spent-in-emergency-department-for-admitted-patients)

Both datasets were filtered to Ontario hospital corporations and cover five fiscal years, from 2020–2021 to 2024–2025.

The underlying data source is CIHI's National Ambulatory Care Reporting System (NACRS).

The raw CIHI files are not included in this repository. Data preparation, cleaning, and analytical decisions are documented in the [`sql`](./sql) folder and [`data-notes.md`](./docs/data-notes.md).

## Interactive Dashboard

[View the interactive Tableau dashboard.](https://public.tableau.com/views/OntarioEmergencyDepartmentPerformanceAnalysis/OntarioEDPerformanceOverview?:language=en-US&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link)


## Main Analytical Question

Which Ontario hospital corporations show persistent emergency department performance gaps, and do those gaps appear mainly before initial physician assessment, later in the ED stay for admitted patients, or in both stages?

## Analytical Approach

CIHI already reports both indicators, along with hospital peer groups and its own performance comparison and trend measures.

For this case study, I used the published indicator values to build a separate longitudinal comparison at the Ontario hospital corporation level. I:

- compared each corporation with the annual median of its hospital peer group;
- measured the size of the gap from that peer benchmark;
- looked for gaps that persisted across multiple fiscal years;
- compared the two ED indicators to see where those persistent gaps appeared.

The peer-median benchmark and persistent-gap definition used here are analytical methods created for this project and are separate from CIHI's official performance comparison methodology.
I initially looked at the mean as a possible peer benchmark, but some corporation-level P90 values were quite high. I chose the median because it was less affected by those extreme values and gave me a more stable reference point for this analysis.

### SQL example

One of the main steps was calculating an annual median within each hospital peer group:

```sql
PERCENTILE_CONT(initial_p90_hours, 0.5)
OVER (
  PARTITION BY time_frame, hospital_peer_group
) AS peer_median_initial_p90
```
I then used those yearly peer benchmarks to identify corporations with gaps that persisted over time.

The following condition flags corporations that were above their annual peer-group median in at least 4 of 5 years:

```sql
COUNTIF(
  initial_p90_hours > peer_median_initial_p90
) >= 4
```
A persistent gap was defined as being above the annual peer-group median in at least **4** of **5** years.
[View all SQL queries](https://github.com/sarahdini-design/ontario-ed-performance-analysis/tree/main/sql)


## Question 1

### How did emergency department wait times change across Ontario hospital corporations over the five-year period?

### Finding

The first thing I looked at was how the two wait-time measures changed over the five years.

For initial physician assessment, the median P90 wait increased from **2.5** hours in 2020–2021 to **4.3** hours in **2024–2025**.

Admitted-patient ED stay followed a different pattern. It increased from **23.0** hours to **35.6** hours by **2022–2023**, then came down somewhat over the next two years to about **33.3** hours in **2024–2025**.

![Five-year trend in Ontario ED wait times](images/five-year-ed-trends.png)
*Five-year median P90 trends for initial physician assessment and admitted-patient ED stay.*


### Insight

What stood out to me was that the two parts of the ED journey did not move in the same way.

Initial-assessment waits increased fairly steadily, while admitted-patient ED stay increased much more sharply and then started to improve after **2022–2023**.

Looking at the two measures together gave a clearer picture than looking at either one alone.

### Recommendation

The continued increase in initial-assessment waits is worth watching because it appears across several years, not just one.

The improvement in admitted-patient ED stay after **2022–2023** is also worth following to see whether it continues.


## Question 2

### Did the same hospital corporations remain above their peer-group median over time?

### Finding

When I looked at the five-year pattern for each corporation, the results fell into several different groups:

- **25** did not show a persistent gap in either measure.
- **15** showed a persistent gap only in admitted-patient ED stay.
- **11** showed a persistent gap only in initial physician assessment.
- **9** showed persistent gaps in both measures.
- **4** could not be fully classified for initial assessment because of suppressed values; among them, **1** still showed a persistent gap in admitted-patient ED stay.

![Persistent performance gap patterns](images/persistent-gap-patterns.png)
*Five-year persistent-gap patterns across 64 Ontario hospital corporations.*

### Insight

There was not one common pattern across the hospitals.

Some corporations were repeatedly above their peer median mainly for initial assessment, while others stood out more for admitted-patient ED stay. Nine showed persistent gaps in both.

For me, this was an important result because it showed that one ED measure alone would not tell the full story.

### Recommendation

I would look first at corporations with persistent gaps in both measures, since the pattern is showing up at more than one stage of the ED visit.

Corporations with a gap in only one measure should be looked at separately because the issue may be happening at a different part of the patient journey.

To understand what is behind these patterns, I would need operational data such as patient volume, case mix, staffing, and inpatient capacity.


## Question 3

### How much did 2024–2025 performance vary between hospital corporations when compared with their own peer group?

### Finding

When I looked at **2024–2025** on its own, there was a wide range of results even among corporations in the same peer group.

Some corporations were below their peer median, while others were well above it. The difference was especially large for admitted-patient ED stay.

One example that stood out was Haliburton Highlands Health Services. Its admitted-patient P90 was **70.3** hours compared with a peer-group median of **15.6** hours, a gap of about **350.6%**.

<a href="(https://public.tableau.com/views/OntarioEmergencyDepartmentPerformanceAnalysis/20242025InitialvsAdmittedPeerGaps?:language=en-US&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link)">
  <img
    src="images/peer-benchmark-gaps-2024-2025.png"
    alt="2024–2025 initial and admitted peer gaps"
    width="400"
  > </a>
  
*2024–2025 corporation-level gaps relative to hospital peer-group medians. Each point represents one Ontario hospital corporation.* [View this chart interactively in Tableau Public.](https://public.tableau.com/views/OntarioEmergencyDepartmentPerformanceAnalysis/20242025InitialvsAdmittedPeerGaps?:language=en-US&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link)


### Insight

This made it clear that an Ontario-wide number can hide a lot of variation between individual corporations.

Even hospitals in the same peer group could be quite far apart.

Looking at the gap from the peer median gave me more useful context than comparing the raw wait times alone.

### Recommendation

Large positive gaps are useful flags for a closer look, especially when the same corporation also shows a persistent gap over several years.

I would not use these results to rank hospitals. I would use them to decide where a deeper review might be useful.


## Question 4

### Does a corporation's 2024–2025 performance tell the same story as its five-year pattern?

### Finding

This was one of the more useful checks for me because the latest year did not always tell the same story as the five-year pattern. A corporation could look better in **2024–2025** and still have a clear persistent gap over time.

Among the nine corporations with persistent gaps in both indicators, seven were still above their peer median in both measures in **2024–2025**. Two showed a mixed latest-year result.

Hamilton Health Sciences was slightly below its peer median for initial assessment but remained above it for admitted-patient ED stay. Arnprior Regional Health showed the opposite pattern: initial assessment remained above the peer median, while admitted-patient ED stay moved below it.

<img src="images/arnprior-five-year-peer-comparison.png" alt="Five-year P90 trends for Arnprior Regional Health compared with annual peer-group medians for initial assessment and admitted-patient ED stay." width="700"></p>
*Five-year P90 trends for Arnprior Regional Health compared with annual peer-group medians for initial assessment and admitted-patient ED stay.*
[Explore corporation-level trends in Tableau Public.](https://public.tableau.com/views/OntarioEmergencyDepartmentPerformanceAnalysis/CorporationPerformanceDetail?:language=en-US&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link)


### Insight

This is why I did not want to rely on only one year of data.

The latest year tells me where a corporation stands now, while the five-year view shows whether that pattern has been happening repeatedly.

Looking at both together gives a much better picture.

### Recommendation

I would review the latest-year result together with the longer-term pattern.

If the two tell different stories, I would keep following the corporation over the next few years before deciding that the pattern has really changed.

A large gap is still a reason to look more closely, but it does not explain why the gap exists.


## Question 5

### Were persistent performance gaps concentrated in particular hospital peer groups?

### Finding

I wanted to see whether persistent gaps were mostly linked to one type of hospital, but that was not really what the data showed.

Persistent gaps appeared across all four peer groups.

Community–Medium had the highest share, with **10** of **16** corporations **(62.5%)** showing a confirmed persistent gap in at least one indicator. Community–Large followed at **14** of **25** **(56.0%)**, and Teaching hospitals were **6** of **12 (50.0%)**.

Community–Small hospitals also showed persistent gaps, although suppressed initial-assessment values made that comparison a little less complete.

The type of gap also differed between groups. For example, **3** of **12** Teaching corporations had persistent gaps in both indicators, compared with **1** of **16** Community–Medium corporations.

#### Peer-group summary

| Hospital Peer Group | Corporations with a Persistent Gap | Total Corporations | Share |
|---|---:|---:|---:|
| Community-Medium | 10 | 16 | 62.5% |
| Community-Large | 14 | 25 | 56.0% |
| Community-Small | 6 | 11 | 54.5% |
| Teaching | 6 | 12 | 50.0% |

<sub>Persistent gap refers to a confirmed persistent gap in at least one of the two ED indicators. Community-Small results should be interpreted with some caution because of suppressed initial-assessment values.</sub>

[View the SQL query](./sql/23_analyze_persistent_gaps_by_peer_group.sql)


<img
  src="images/persistent-gaps-by-peer-group.png"
  alt="Persistent performance gap patterns by hospital peer group"
  width="1700"
/>
*Distribution of five-year persistent-gap patterns within each Ontario hospital peer group.* [View this chart interactively in Tableau Public.](https://public.tableau.com/views/OntarioEmergencyDepartmentPerformanceAnalysis/PersistentGapsbyHospitalPeerGroup?:language=en-US&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link)

### Insight

No single peer group clearly explained the persistent gaps.

What I found more interesting was the mix of gap types inside each group. Some groups had more corporations with a gap in only one part of the ED journey, while Teaching hospitals had a larger share with gaps in both measures.

### Recommendation

Peer group is useful for making a fairer comparison, but I would not use hospital type by itself to explain the gaps.

The next step would be to look at individual corporations together with operational information such as patient volume, case mix, staffing, and inpatient capacity.

For Community–Small hospitals, I would also keep the suppressed initial-assessment values in mind when interpreting the results.


## Question 6

### Which hospital corporations stand out for further investigation when long-term and current performance are considered together?

### Finding

The last step was to bring the long-term and current-year results together.

Nine corporations had persistent gaps in both ED indicators over the five-year period. When I checked them against their **2024–2025** peer medians, seven were still above the median in both measures.

Hamilton Health Sciences and Arnprior Regional Health were different. Each had moved below its peer median in one of the two measures.

Some of the largest current gaps within this group were at Cambridge Memorial Hospital, Niagara Health System, and Peterborough Regional Health Centre.

#### Current position of persistent-gap corporations

| Corporation | Peer Group | Initial Gap % | Admitted Gap % | 2024–2025 Position |
|---|---|---:|---:|---|
| Cambridge Memorial Hospital Corporation | Community-Medium | 72.4% | 84.0% | Above peer median in both |
| Niagara Health System (Ont.) | Community-Large | 40.0% | 75.7% | Above peer median in both |
| Peterborough Regional Health Centre | Community-Large | 35.6% | 40.2% | Above peer median in both |
| Sunnybrook Health Sciences Centre | Teaching | 64.9% | 39.7% | Above peer median in both |
| Brant Community Healthcare System | Community-Large | 68.9% | 15.2% | Above peer median in both |
| The Ottawa Hospital (Ont.) | Teaching | 50.5% | 10.6% | Above peer median in both |
| Halton Healthcare Services (Ont.) | Community-Large | 8.9% | 5.7% | Above peer median in both |
| Hamilton Health Sciences (Ont.) | Teaching | -3.1% | 3.8% | Above peer median in admitted only |
| Arnprior Regional Health (Ont.) | Community-Small | 77.8% | -6.4% | Above peer median in initial only |

[View the SQL query](./sql/24_identify_current_persistent_priorities.sql)


<img
  src="images/persistent-gap-current-position.png"
  alt="2024–2025 peer-group gaps for corporations with persistent gaps in both ED indicators"
  width="400"/></a>

*2024–2025 peer-group gaps for the nine hospital corporations with persistent gaps in both ED indicators over the five-year period.* [Explore this view interactively in Tableau Public.](https://public.tableau.com/views/OntarioEmergencyDepartmentPerformanceAnalysis/CurrentPerformanceofPersistent-GapCorporations?:language=en-US&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link)

### Insight

For most of these corporations, the five-year pattern was still visible in the latest year.

But Hamilton and Arnprior were good reminders that the latest result does not always continue the historical pattern.

That is why I found it more useful to look at current and long-term performance together.

### Recommendation

The seven corporations that remained above their peer median in both measures would be my first group for a closer operational review.

The goal would not be to assume what is causing the gap. I would want to bring in patient volume, case mix, staffing, inpatient capacity, and other operational data before drawing conclusions.

For corporations where the latest result has started to change, I would keep following the trend to see whether the improvement continues.


## Limitations

This analysis is based on publicly reported CIHI data, so it can show where performance gaps appear, but it cannot explain why they happen.

A few limitations are important to keep in mind:

- The analysis uses corporation-level P90 wait times rather than patient-level data. This means I could not look at differences in patient acuity, case mix, or individual patient experience.

- The peer benchmark is based on the median corporation within each hospital peer group. It is not weighted by patient volume, so a small corporation and a large corporation contribute equally to the benchmark.

- Some physician initial-assessment values were suppressed by CIHI. I kept these values as missing rather than estimating them, which means a small number of corporations could not be fully classified for persistent initial-assessment gaps.

- The datasets do not include operational information such as staffing, ED visit volumes, inpatient bed availability, or local capacity. Because of this, the analysis can identify patterns but cannot determine what caused them.

- The persistent-gap rule used in this project — being above the annual peer-group median in at least **4** of **5** years — was created for this analysis. It is separate from CIHI's official performance-comparison methodology.

- The study covers five fiscal years, from **2020–2021** to **2024–2025**. More years of data would be needed to know whether recent changes are temporary or part of a longer-term shift.


## Final Recommendations

Based on the patterns identified in this analysis, a few areas would be worth prioritizing for further review:

- **Focus first on corporations with persistent gaps in both indicators.**  
  These organizations showed repeated above-peer wait times across both initial physician assessment and admitted-patient ED stay, making them the clearest candidates for deeper operational investigation.

- **Consider current performance together with the five-year pattern.**  
  A single year can look better or worse than the longer-term trend. Corporations that remain above their peer median in 2024–2025 after showing persistent gaps over several years deserve particular attention, while recent improvements should be followed to see whether they continue.

- **Investigate the two stages of the ED journey separately.**  
  Some corporations showed persistent gaps only in initial assessment, while others showed gaps mainly in admitted-patient ED stay. These patterns should not automatically be treated as the same type of performance issue.

- **Keep peer-group context in the comparison.**  
  Persistent gaps were present across all hospital peer groups, so hospital type alone does not explain the differences. Comparing corporations with similar peers remains more informative than using a single Ontario-wide benchmark.

- **Combine wait-time results with operational data before making decisions.**  
  Patient volumes, case mix, staffing, inpatient bed availability, and other capacity measures would help determine what may be contributing to the gaps identified here.


## Conclusion

My original question was whether some Ontario hospital corporations showed persistent ED performance gaps, and whether those gaps were mainly happening in initial assessment, admitted-patient ED stay, or both.

The answer turned out to be different across corporations. Some showed a persistent gap mainly in initial assessment, some in admitted-patient ED stay, and nine showed persistent gaps in both.

The gaps also appeared across all hospital peer groups, so there was no single hospital type or single stage of the ED journey that explained the overall pattern.

Using annual peer-group medians helped me put each corporation's wait time in context, while the five-year view helped separate a repeated pattern from a single-year result.

This analysis cannot explain why the gaps exist, but it does show where a closer operational review could be most useful.

