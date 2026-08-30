# Ontario Emergency Department Performance Analysis

A five-year analysis of emergency department wait times across Ontario hospital corporations using public data from the Canadian Institute for Health Information (CIHI).

## Project Overview

Emergency department performance can look very different depending on which part of the patient journey is being measured. In this project, I looked at two CIHI indicators:

- Physician Initial Assessment wait time
- Total ED time for patients who were admitted

I wanted to see how these measures changed over time, how hospital corporations compared with similar hospitals, and whether some performance gaps appeared repeatedly across several years.

## Interactive Dashboard

View the interactive Tableau dashboard https://public.tableau.com/views/OntarioEmergencyDepartmentPerformanceAnalysis/OntarioEDPerformanceOverview?:language=en-US&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link


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


## Question 1

### How did emergency department wait times change across Ontario hospital corporations over the five-year period?

### Finding

At the corporation level, the median P90 wait for initial physician assessment increased from **2.5 hours in 2020–2021 to 4.3 hours in 2024–2025**.

For admitted patients, the pattern was different. The median P90 ED stay increased from **23.0 hours in 2020–2021 to 35.6 hours in 2022–2023**, then declined somewhat over the next two years to about **33.3 hours in 2024–2025**.

![Five-year trend in Ontario ED wait times](images/five-year-ed-trends.png)

### Insight

Both measures ended the five-year period higher than where they started, but they followed different paths.

Initial assessment waits increased fairly steadily. Admitted-patient ED stay rose much more sharply through 2022–2023, then showed some improvement afterward.

Seeing the two measures side by side made it clear that the pattern was not the same across different stages of the ED visit.

### Recommendation

The continued increase in initial-assessment wait times is worth looking at more closely because it appears across several years rather than in a single period.

The improvement in admitted-patient ED stay after 2022–2023 is also worth following to see whether it continues in future years.


## Question 2  
### Were the same hospital corporations consistently performing above their peer-group median over time?

### Finding  
The five-year results showed that performance gaps were not concentrated in just one part of the ED journey.

Out of 64 Ontario hospital corporations:

- **25** did not show a persistent gap in either measure.
- **15** showed a persistent gap only in admitted-patient ED stay.
- **11** showed a persistent gap only in initial physician assessment.
- **9** showed persistent gaps in both measures.
- **4** could not be fully classified for initial assessment because of suppressed values; one of these still showed a persistent gap in admitted ED stay.

### Insight  
The results suggest that there is no single pattern of ED performance across Ontario corporations.

Some corporations consistently had longer waits before the initial physician assessment, while others were more often above their peer median later in the ED journey for admitted patients. A smaller group showed persistent gaps in both measures.

This was important because a corporation that performs relatively well on one measure may still have a persistent gap on the other. Looking at only one indicator would have missed part of that difference.

### Recommendation  
Corporations with persistent gaps in both measures would be a reasonable starting point for deeper review because the pattern appears across more than one stage of the ED visit.

Corporations with a gap in only one measure should be looked at separately rather than grouped together, since the area that may need further investigation is different.

The next step would be to combine these results with operational information such as patient volumes, case mix, staffing, and inpatient capacity to better understand what may be contributing to the persistent gaps.

For admitted patients, it would also be useful to understand whether the improvement after 2022–2023 occurred broadly across Ontario or was mainly driven by particular corporations or peer groups.

Additional operational data, such as patient volumes, case mix, staffing, and inpatient bed availability, would be needed before making conclusions about what caused these patterns.


## Question 3  
### How much did 2024–2025 performance vary between hospital corporations when compared with their own peer group?

### Finding  
The 2024–2025 results showed a wide range of performance gaps across Ontario hospital corporations.

For both indicators, some corporations had P90 wait times below their peer-group median, while others were well above it. The variation was especially noticeable for admitted-patient ED stay.

One of the more extreme examples was Haliburton Highlands Health Services, where the admitted-patient P90 was **70.3 hours**, compared with a peer-group median of **15.6 hours**. This represented a gap of about **350.6% above the peer median**.

### Insight  
The provincial trend alone does not show how different the experience can be from one corporation to another.

Even among hospitals in the same peer group, the distance from the peer median varied considerably. This made the peer comparison useful because it provided more context than simply comparing raw wait times across all corporations.

It also showed why a single Ontario-wide number should not be used to describe the performance of every hospital organization.

### Recommendation  
Corporations with unusually large positive gaps should be reviewed more closely, especially when the gap also appears repeatedly over several years.


## Question 4  
### Does a corporation’s 2024–2025 performance tell the same story as its five-year pattern?

### Finding  
Not always.

The 2024–2025 comparison gives a useful snapshot of where a corporation currently stands relative to its peer group, but that snapshot does not necessarily represent its longer-term pattern.

A corporation can be above its peer median in the latest year without having shown the same gap consistently across the previous years. The reverse is also possible: a corporation may have a persistent five-year gap even if its most recent result has moved closer to, or below, the peer median.

### Insight  
This was an important distinction in the analysis.

Looking only at 2024–2025 could make a recent change look like a long-standing performance issue. At the same time, looking only at the five-year classification could hide recent improvement or deterioration.

Using both views together gives a better picture: the latest-year result shows where a corporation is now, while the persistent-gap classification adds the longer-term context.

### Recommendation  
Current-year performance and longer-term patterns should be reviewed together rather than used interchangeably.

Corporations that have both a persistent gap and a large current-year gap may deserve more immediate attention. Corporations whose latest-year result differs from their historical pattern may also be worth reviewing to understand whether the change represents improvement, deterioration, or normal year-to-year variation.

Additional years of data would help determine whether recent changes continue or are temporary.

However, a large gap should be treated as a signal for further investigation rather than a conclusion about why a corporation is performing differently.


## Question 5
### Were persistent performance gaps concentrated in particular hospital peer groups?

### Finding
Persistent performance gaps appeared across all four hospital peer groups rather than being concentrated in one type of hospital.

Community–Medium had the highest share of corporations with a confirmed persistent gap in at least one indicator, with **10 of 16 corporations (62.5%)**. This was followed by Community–Large at **14 of 25 (56.0%)** and Teaching hospitals at **6 of 12 (50.0%)**.

Community–Small hospitals also showed persistent gaps, although several corporations in this group had suppressed initial-assessment values, making the comparison less complete.

The type of gap also varied by peer group. For example, **3 of 12 Teaching corporations (25.0%)** had persistent gaps in both indicators, compared with **1 of 16 Community–Medium corporations (6.3%)**.

### Insight
There was no single hospital peer group where persistent ED performance gaps were overwhelmingly concentrated.

Although Community–Medium had the highest proportion, persistent gaps were still common across the other peer groups. What stood out more was that the type of gap differed between groups. Some had more corporations with a gap in only one part of the ED journey, while Teaching hospitals had a relatively larger share with persistent gaps in both indicators.

### Recommendation
Peer group provides useful context when comparing hospital corporations, but it should not be used on its own to explain persistent performance gaps.

A useful next step would be to examine corporations with persistent gaps within each peer group alongside operational information such as patient volume, case mix, staffing, and inpatient capacity.

For Community–Small hospitals, suppressed initial-assessment values should also be considered before making broader comparisons with the other peer groups.

Patient volumes, case mix, hospital capacity, staffing, and other operational factors would be needed to understand what may be behind these differences.


## Question 6
### Which hospital corporations stand out for further investigation when long-term and current performance are considered together?

### Finding
Nine hospital corporations showed persistent gaps in both ED indicators over the five-year period.

When I compared those corporations with their 2024–2025 peer-group benchmarks, **7 of the 9 were still above the peer median in both indicators**.

Two corporations showed a more mixed current-year pattern. Hamilton Health Sciences was slightly below its peer median for initial assessment but remained above it for admitted-patient ED stay. Arnprior Regional Health remained well above its peer median for initial assessment but was below the peer median for admitted ED stay.

Some of the largest current gaps among the persistent-gap group were seen at Cambridge Memorial Hospital, Niagara Health System, and Peterborough Regional Health Centre.

### Insight
For most corporations with a persistent gap in both indicators, the longer-term pattern was still visible in the most recent year.

This makes the 7 corporations that remained above their peer median in both measures particularly useful starting points for further investigation. At the same time, the results for Hamilton Health Sciences and Arnprior Regional Health show why the latest year should not simply be treated as a continuation of the historical pattern. Performance can change differently across the two stages of the ED journey.

### Recommendation
Corporations that combine a five-year persistent gap with above-peer performance in both indicators in 2024–2025 would be reasonable priorities for a closer operational review.

The purpose of that review would be to understand what is contributing to the pattern, not to assume a cause from the wait-time data alone. Patient volume, case mix, staffing, inpatient capacity, and other operational measures would be needed before making conclusions about why these corporations differ from their peers.

Corporations whose latest-year results have moved away from their historical pattern should also be followed over additional years to see whether the change continues.


## Limitations

This analysis is based on publicly reported CIHI data and is intended to identify patterns in ED wait-time performance, not to explain why those patterns occurred.

A few limitations are important when interpreting the results:

- The analysis uses corporation-level P90 wait times. It does not include patient-level records, so differences in patient acuity, case mix, or individual patient experience could not be examined.

- The peer-group benchmark is based on the median corporation within each hospital peer group. It is not volume-weighted, so a smaller and a larger corporation each contribute equally to the benchmark.

- Some physician initial-assessment values were suppressed by CIHI. These values were kept as unavailable rather than estimated, which means that a small number of corporations could not be fully classified for persistent initial-assessment gaps.

- The datasets do not include operational factors such as staffing levels, ED visit volumes, inpatient bed availability, or local capacity constraints. For that reason, the analysis cannot determine what caused a corporation to perform above or below its peer benchmark.

- The persistent-gap definition used in this project — being above the annual peer-group median in at least 4 of 5 years — is an analytical rule created for this analysis. It is not CIHI's official performance classification.

- The study covers five fiscal years, from 2020–2021 to 2024–2025. Recent changes may therefore need additional years of data before they can be considered a sustained improvement or deterioration.


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

These recommendations are intended to identify where further investigation may be useful. The wait-time data alone is not enough to determine the underlying cause of a corporation's performance.



## Conclusion

This analysis showed that Ontario ED performance changed over the five-year period, but the pattern was not the same across the two stages of the patient journey.

Initial physician assessment waits increased fairly steadily, while admitted-patient ED stay rose more sharply and then showed some improvement after 2022–2023. Looking at both indicators together also showed that persistent performance gaps were not limited to one type of hospital or one part of the ED visit.

The peer-group comparison helped add context to the raw wait times, and the five-year persistent-gap view made it possible to separate longer-term patterns from a single-year result.

The main value of this analysis is not to label hospitals as good or bad, but to identify where performance gaps appear repeatedly and where a closer operational review may be useful.

Further analysis using patient volume, case mix, staffing, inpatient capacity, and other operational data would be needed to understand what is driving the differences observed in this project.


