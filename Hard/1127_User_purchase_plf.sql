-- https://leetcode.com/problems/user-purchase-platform/

# Write your MySQL query statement below

with ct as (select 
user_id, spend_date, platform, amount,
dense_rank() over(partition by user_id, spend_date order by platform) as dr
from spending
)

,ct2 as (select 
user_id, 
spend_date, platform, amount,
max(dr) over(partition by user_id, spend_date) as plf_ct
# sum(amount) as total_amount,
# count(distinct user_id) as total_users
from ct)

,gp as (select 
spend_date, 
if(plf_ct >1, "both", platform) as platform,
sum(amount) as total_amount,
count(distinct user_id) as total_users
from ct2
group by 1, 2)

# select * from ct3

,dt as (select distinct spend_date from spending)
,dp as (select distinct platform from gp)
,dtp as (select * from dt, dp)

# select * from dtp

select 
dtp.spend_date,
dtp.platform, 
if(gp.total_amount is null,0, gp.total_amount) as total_amount,
if(gp.total_users is null,0, gp.total_users) as total_users
from gp right join dtp on gp.spend_date = dtp.spend_date and gp.platform =  dtp.platform
