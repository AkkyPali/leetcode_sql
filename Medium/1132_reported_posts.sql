-- https://leetcode.com/problems/reported-posts-ii/

-- Correct Solution
with cte as (select count(distinct r.post_id)/count(distinct a.post_id) as frac
from actions a left join removals r on a.post_id = r.post_id
where action = "report" and extra = "spam"
group by action_date)


select round(sum(frac)/count(*) *100,2) as average_daily_percent
from cte 


-- Almost Correct Solution
with cte as (select (sum(if(remove_date is not null ,1,0)))/count(distinct a.post_id) as frac
from actions a left join removals r on a.post_id = r.post_id
where action = "report" and extra = "spam"
group by action_date)


select round(sum(frac)/count(*) *100,2) as average_daily_percent
from cte 