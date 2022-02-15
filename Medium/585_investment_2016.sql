-- https://leetcode.com/problems/investments-in-2016/

with cte as (select tiv_2016, count(pid) over(partition by concat(lat,lon)) as loc_ct, count(pid) over(partition by tiv_2015) as tiv_ct
from insurance)

select round(sum(tiv_2016),2) as tiv_2016
from cte
where loc_ct = 1 and tiv_ct >1