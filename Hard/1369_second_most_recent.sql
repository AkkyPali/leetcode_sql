-- https://leetcode.com/problems/get-the-second-most-recent-activity/

with cte as (select rank() over(partition by username order by startdate DESC) r, 
             count(activity) over(partition by username) as cnt,
             username, activity, startdate, enddate
from useractivity)

select username, activity, startdate, enddate
from cte 
where r = 2 or cnt = 1