-- https://leetcode.com/problems/active-users/

with cte as (select a.id, a.name, l.login_date
             from accounts a 
join logins l on a.id = l.id )

select distinct l1.id, l1.name 
from cte l1 join logins l2 on l1.id = l2.id and datediff(l1.login_date, l2.login_date) = 1
join logins l3 on l2.id = l3.id and datediff(l2.login_date, l3.login_date) = 1
join logins l4 on l3.id = l4.id and datediff(l3.login_date, l4.login_date) = 1
join logins l5 on l4.id = l5.id and datediff(l4.login_date, l5.login_date) = 1
order by 1