-- https://leetcode.com/problems/find-the-start-and-end-number-of-continuous-ranges/

with cte as (select 
log_id - row_number() over(order by log_id) as rdiff, 
row_number() over(order by log_id) as rn,
log_id
from logs)

select 
min(log_id)as start_id,
max(log_id) as end_id
from cte
group by rdiff