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



