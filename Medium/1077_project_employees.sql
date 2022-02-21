-- https://leetcode.com/problems/project-employees-iii/

with cte as (select 
 rank() over(partition by project_id order by experience_years DESC) as r, 
 project_id, 
p.employee_id
from project p left join employee e on p.employee_id = e.employee_id
)

select project_id, employee_id
from cte 
where r = 1