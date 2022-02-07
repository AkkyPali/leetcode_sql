-- https://leetcode.com/problems/new-users-daily-count/

with cte as (select min(activity_date) over(partition by user_id) as first_login,
             user_id
from traffic
where activity = 'login' 
             # and datediff("2019-06-30", activity_date)<=90 
# group by user_id
            )

select first_login as login_date, count(distinct user_id) as user_count
from cte
where datediff("2019-06-30", first_login) <=90 
group by first_login
