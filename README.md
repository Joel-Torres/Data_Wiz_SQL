# Data_Wiz_SQL
A repo with sql files pertaining to the Data Wizardry clinical cohort. 

<h2>flu_tx_patients</h2>
  <ul>
    <li>This sequel file contains a CTE with subquery joining an immunizations table and conditions table.</li>
  </ul>

<h2>vw_cte_subquery_join</h2>
  <h4>A query for End Stage Renal Disease (ESRD) patients, that provides informationabout each patients Blood Urea Nitogen (Bun) in the year 2022.</h4>
  <h5>Inclusion Criteria:</h5>
  <ul>
    <li>Patient must have been active: as defined by at least 1 encounter bewteeen 2020-2022</li>
    <li>Patient must be diagnosed with: End Stage Renal Disease (ESRD)</li>
  </ul>
  <h5>Exclusion Criteria:</h5>
  <ul>
    <li>Patient Death.</li>
    <li>Patient cured of ESRD.</li>
  </ul>

  <h5>Required Columns:</h5>
  <ul>
    <li>Patient ID number</li>
    <li>Highest BUN level or each patient for 2022 for blood BUN</li>
    <li>Lowest BUN level for each patient for 2022</li>
    <li>Average BUN level for each patient for 2022</li>
  </ul>

  <h2>esrd_bun_pat_deagragate_partition</h2>
  <h4>An extension of the vw_cte_subquery_join query with a partition</h4>
  <p>We aggregated data with a groub by clause into min, max, and average values. This extension or new ask was to keep the granularity of the data before aggregating. We want to see all the BUN and encounter values for each patient but we also want to show the min, max, and average all on the same table. To accomplish this task we need to take advantage of the partition function in Sequel.</p>

<h3>Project Clarifications</h3>
<p>Provider wants all lab values displayed (increase granularity), in addition to the aggregate values</p>
<h5>They also want additional columns</h5>
<ul>
  <li>The total count of BUN for each patient in 2022</li>
  <li>The peer average of ESRD BUN values for the whole year of 2022</li>
  <li>Each row shows the Nth BUN lab for the patient in 2022</li>
</ul>


