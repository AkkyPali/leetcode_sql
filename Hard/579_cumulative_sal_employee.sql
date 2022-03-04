-- https://leetcode.com/problems/find-cumulative-salary-of-an-employee/

with cte as (select 
id, 
month as m1,
lag(month,1,0) over(partition by id order by month) as m2,
lag(month,2,0) over(partition by id order by month) as m3,
salary as s1,
lag(salary,1,0) over(partition by id order by month) as s2,
lag(salary,2,0) over(partition by id order by month) as s3,
max(month) over(partition by id) as mm
from employee)

select id, m1 as month, # s1, s2,s3, m1, m2, m3,
case when m1-m2 = 1 and m2 - m3 = 1 then s1 + s2+ s3
    when m1-m2 = 1 and m2 - m3 > 1 then s1 + s2+ 0
    when m1-m2 = 2 then s1+ s2+ 0
    else s1 + 0 + 0 end as salary
from cte
where m1 < mm
order by id asc, month desc
