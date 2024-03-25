/*
A query for End Stage Renal Disease (ESRD) patients, that provides informationabout each patients Blood Urea Nitogen (Bun) in the year 2022.

Inclusion Criteria:
Patient must have been active: as defined by at least 1 encounter bewteeen 2020-2022
Patient must be diagnosed with: End Stage Renal Disease (ESRD)

Exclusion Criteria:
Patient Death.
Patient cured of ESRD.

Required Columns:
Patient ID number
Highest BUN level or each patient for 2022 for blood BUN
Lowest BUN level for each patient for 2022
Average BUN level for each patient for 2022

--Skills--
-CTE's
-Subquery's
-View
*/


create view vw_bun_esrd as

with active_pats as
(
select distinct patient
from encounters as enc
join patients as pat
	on enc.patient = pat.id
where start between '2020-01-01 00:00:00' and '2022-12-31 23:59:59'
	and pat.deathdate is null
),

cond_pats as
(
select *
from conditions
where 
	--lower(description) like 'end stage renal disease'
	code = '585.6'
	and start < '2022-01-01'
	and stop is null
	-- Subquery below that connects to CTE
	and patient in (select patient from active_pats)
),

obs_pat as (
select patient,
	   min(cast(value as float)) as min_bun,
	   max(cast(value as float)) as max_bun,
	   avg(cast(value as float)) as avg_bun
from observations
where code = '6299-2' -- Blood Urea Nitrogen
	and date between '2022-01-31 00:00:00' and '2022-12-31 23:59:59'
	and patient in (select patient from cond_pats)
group by patient
)

select *
from obs_pat

select * from vw_bun_esrd


/*
 Project Clarifications
 
 Provider wants all lab values displayed (increase granularity),
 in addition to the aggregate values.
 
 They also want additional columns
 1. The total count of BUN for each patient in 2022
 2. The peer average of ESRD BUN values for the whole year of 2022
 3. Each row shows the Nth BUN lab for the patient in 2022
 
 --Skill--
 - Partitions
 */
create view vw_esrd_bun_partition as

with active_pats as
(
select patient
from encounters as enc
join patients as pat
	on enc.patient = pat.id
where start between '2020-01-01 00:00:00' and '2022-12-31 23:59:59'
	and pat.deathdate is null
),

cond_pats as
(
select *
from conditions
where 
	--lower(description) like 'end stage renal disease'
	code = '585.6'
	and start < '2022-01-01 00:00'
	and stop is null
	-- Subquery below that connects to CTE
	and patient in (select patient from active_pats)
),

observation_pat as (

select *, -- The removal of the cte, min, max, and avg aggrate functions necessary to un-aggregate data and return to a more granular form.
		  -- The over clause creates/casts the window over the data set for the partition of values. 
		  -- over function should take two arguments partition a column and order by. however, since we are getting the average of the value column for all encounters of all 
		  -- patients then we can just leave the over function blank.
	   avg(cast(value as float)) over (partition by patient) as avg_patient_bun,
	   min(cast(value as float)) over (partition by patient) as min_patient_bun,
	   max(cast(value as float)) over (partition by patient) as max_patient_bun,
	   count(cast(value as float)) over (partition by patient) as count_patient_bun,
	   avg(cast(value as float)) over () as avg_esrd_peer_bun,
	   row_number() over (partition by patient order by date asc) as nth_bun_patient
from observations
where code in (
				'6299-2' -- Blood Urea Nitrogen
			  )  
	and date between '2022-01-01 00:00:00' and '2022-12-31 23:59:59'
	and patient in (select patient from cond_pats)
	order by patient, date asc
	-- See below to ungroup data by patient. We'll get all individual row values (all encounters) for each patient. Hence we'll see repeated patient values.
--group by patient
)

select * from esrd_bun_partition

/*,


obs_pat as (
select patient,
	   min(cast(value as float)) as min_bun,
	   max(cast(value as float)) as max_bun,
	   avg(cast(value as float)) as avg_bun
from observations
where code = '6299-2' -- Blood Urea Nitrogen
	and date between '2022-01-31 00:00:00' and '2022-12-31 23:59:59'
	and patient in (select patient from cond_pats)
group by patient
)

select *
from obs_pat
*/