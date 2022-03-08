-- https://leetcode.com/problems/human-traffic-of-stadium/

with cte as (select 
id, lag(id,1,0) over() as l_id, lag(id,2, 0) over() as l2_id,
visit_date, lag(visit_date,1,0) over() as l_visit_date, lag(visit_date,2,0) over() as l2_visit_date,
people, lag(people,1,0) over() as l_people , lag(people,2,0) over() as l2_people 
from stadium )

(select 
id, visit_date, people
from cte
where id - l_id = 1 and l_id - l2_id = 1
    and people >= 100 and l_people >= 100 and l2_people >= 100)

union 
(select 
l_id, l_visit_date, l_people
from cte
where id - l_id = 1 and l_id - l2_id = 1
    and people >= 100 and l_people >= 100 and l2_people >= 100
)

union 
(select 
l2_id, l2_visit_date, l2_people
from cte
where id - l_id = 1 and l_id - l2_id = 1
    and people >= 100 and l_people >= 100 and l2_people >= 100
)

order by 2