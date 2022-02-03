-- https://leetcode.com/problems/game-play-analysis-iv/

with cte as 
(select  
    event_date - min(event_date) over(partition by player_id) as consec,
    player_id
    from activity)

,cte1 as (select
cte.player_id, consec
from cte
where consec = 1)

select 
round(count(distinct cte1.player_id)/count(distinct cte.player_id),2) as fraction
from cte1, cte