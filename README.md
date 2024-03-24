# Data_Wiz_SQL
A repo with sql files pertaining to the Data Wizardry clinical cohort. 

flu_tx_patients 
  - This sequel file contains a CTE with subquery joining an immunizations table and conditions table.

<h2>vw_cte_subquery_join</h2>
  0.1.5.1 A query for End Stage Renal Disease (ESRD) patients, that provides informationabout each patients Blood Urea Nitogen (Bun) in the year 20220.
  1.5.2 RequirementsInclusion Criteria:Patient must have been active: as defined by at least 1 encounter bewteeen 2020-2022Patient must be diagnosed with:End Stage Renal Disease (ESRD)Exclusion Criteria:Patient DeathPatient cured of ESRD
  0.1.5.2.1 Required Columns:Patient ID numberHighest BUN level or each patient for 2022 for blood BUNLowest BUN level for each patient for 2022Average BUN level for each patient for 2022
