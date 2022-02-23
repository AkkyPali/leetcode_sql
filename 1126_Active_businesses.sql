-- https://leetcode.com/problems/active-businesses/

with cte as (select 
business_id, 
event_type, 
occurences,
avg(occurences) over(partition by event_type) as avg_act
from events
)

, cte2 as (select 
business_id
,sum(if(occurences > avg_act, 1, 0)) as s_avg
from cte
group by business_id)

select business_id
from cte2
where s_avg > 1