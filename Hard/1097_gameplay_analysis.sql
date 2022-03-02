# Write your MySQL query statement below
with cte as (select 
min(event_date) over(partition by player_id) as min_date,
player_id,
event_date
from activity
)

, total_install as (select count(distinct player_id) as total_installs, min_date 
from cte
group by min_date)

, retention_ct as (select 
count(distinct c.player_id) as retention, c.min_date
from cte c join cte c1 on c.player_id = c1.player_id and datediff(c1.event_date, c.min_date) = 1
group by c.min_date)

select 
    ti.min_date as install_dt, 
    total_installs as installs,
    round(if(retention is null, 0, retention)/total_installs,2) as Day1_retention
from total_install ti left join retention_ct rc on ti.min_date = rc.min_date