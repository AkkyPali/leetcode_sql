-- https://leetcode.com/problems/friend-requests-ii-who-has-the-most-friends/

with req_cte as (select requester_id, 
count(requester_id) over(partition by requester_id) as req_ct
from RequestAccepted)

, acc_cte as (select accepter_id, 
count(accepter_id) over(partition by accepter_id) as acc_ct
from RequestAccepted)

, cte as (select req_cte.requester_id as id,
req_cte.req_ct + if(acc_ct is null,0, acc_ct) as num
from req_cte left join acc_cte on req_cte.requester_id = acc_cte.accepter_id

union

select acc_cte.accepter_id as id, 
if(req_ct is null, 0, req_ct) + acc_cte.acc_ct as num
from req_cte right join acc_cte on req_cte.requester_id = acc_cte.accepter_id
)

select id, num
from cte
order by num DESC
limit 1