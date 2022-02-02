-- https://leetcode.com/problems/managers-with-at-least-5-direct-reports/

with cte as (
select managerid, count(managerid) as count 
from employee 
group by managerid
having managerid is not null and count > 4 )

select e.name
from cte join employee e on cte.managerid = e.id