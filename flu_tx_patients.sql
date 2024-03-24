/* Task: Figure out how many patients had a flu shot (code = 5302) in the year 2022, 
that have been diagnosed as needing an organ transplant ( ICD9 = V49.83 ) sometime 2021 or earlier, 
and do not have an end date for this condition (meaning that the problem is still active). */

with flu_pat_2022 as (
	
select distinct patient 
from immunizations
where code = 5302 -- flu shot
	and date between '2022-01-01 00:00:00' and '2022-12-31 23:59:59' -- in 2022
),

org_trans_2021 as (

select patient
from conditions
where code = 'V49.83' -- need organ transplants
	and start < '2022-01-01'
	and stop is null
	-- subquery below
	and patient in (select patient from flu_pat_2022)
)

select * from org_trans_2021

-------------------Or another method using more traditional join---------------
with tx as (
select patient
from conditions
where code = 'V49.83'
	and start < '2022-01-01'
	and stop is null
)

select distinct tx.patient 
from tx
join immunizations as imm
	on tx.patient = imm.patient
where code = 5302 -- flu shot
	and date between '2022-01-01 00:00:00' and '2022-12-31 23:59:59' -- in 2022	