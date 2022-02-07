
--  https://leetcode.com/problems/department-highest-salary/


with cte as (select e.departmentid, e.name as Employee, d.name as Department, salary,
rank() over(partition by departmentid order by salary DESC) as r
from employee e left join department d on e.departmentid = d.id)

select cte.Department, cte.Employee, cte.salary as Salary 
from cte
where r = 1