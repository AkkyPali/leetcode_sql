-- https://leetcode.com/problems/last-person-to-fit-in-the-bus/

with cte as (select 
turn,
person_id as id,
person_name,
weight
,sum(Weight) over(order by turn) as total_weight 
from queue)


select person_name
from cte
where total_weight <= 1000 
order by total_weight DESC
limit 1