-- https://leetcode.com/problems/median-employee-salary/

with cte as (select row_number() over(partition by company order by salary) as r, 
             count(id) over(partition by company) as max_rn, 
             salary, 
             company,
             id
from employee
)

select id, salary, company
from cte 
where if(mod(max_rn,2) = 0, r = max_rn/2 or r = max_rn/2 + 1, r = round(max_rn/2))