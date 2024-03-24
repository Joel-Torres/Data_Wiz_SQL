# Data_Wiz_SQL
A repo with sql files pertaining to the Data Wizardry clinical cohort. 

<h3>flu_tx_patients</h3>
  <ul>
    <li>This sequel file contains a CTE with subquery joining an immunizations table and conditions table.</li>
  </ul>

<h3>vw_cte_subquery_join</h3>
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
