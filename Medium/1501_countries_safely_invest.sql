-- https://leetcode.com/problems/countries-you-can-safely-invest-in/

# Write your MySQL query statement below

with cte as(
    select caller_id, left(p1.phone_number,3) as caller_cc, 
       callee_id, left(p2.phone_number,3) as callee_cc,
    duration
from calls c left join person p1 on c.caller_id = p1.id 
             left join person p2 on c.callee_id = p2.id
)
,
cte_caller as
(select caller_cc,
    sum(duration)  as caller_duration, 
    count(caller_id) as cnt_caller
from cte 
group by caller_cc)
, 
cte_callee as 
(select callee_cc,
    sum(duration) as callee_duration, 
    count(callee_id)  as cnt_callee
from cte
group by callee_cc)
,

cte_cc as
(select caller_cc as country_code, caller_duration, cnt_caller,
    if(callee_duration is null, 0, callee_duration) as callee_duration, 
    if(cnt_callee is null, 0, cnt_callee) as cnt_callee
from cte_caller cca left join cte_callee cce on cca.caller_cc = cce.callee_cc
union
select callee_cc as country_code,
    if(caller_duration is null, 0, caller_duration) as caller_duration, 
    if(cnt_caller is null,0,cnt_caller) as cnt_caller,
    callee_duration, cnt_callee
from cte_caller cca right join cte_callee cce on cca.caller_cc = cce.callee_cc
)

,cte_cc_avg as (
select (caller_duration + callee_duration)/(cnt_caller + cnt_callee) as cc_avg, 
    country_code,
    sum(caller_duration) over() as global_duration,
    sum(cnt_caller) over() as global_count
from cte_cc
)

# select * 
# from cte_cc_avg
select c.name as country
from country c left join cte_cc_avg on c.country_code = cte_cc_avg.country_code
where cc_avg > global_duration/global_count 
