
-- https://leetcode.com/problems/monthly-transactions-ii/
-- Write your MySQL query statement below

-- each month and country count(approved txns) and sum(amount)

with approved_cte as (select date_format(trans_date, "%Y-%m") as month, country, count(id) as approved_count, sum(amount) as approved_amount
from transactions 
where state = "approved"
group by date_format(trans_date, "%Y-%m") , country)

# each month and country count(chargeback txns) and sum(chargebackamount)

,chargeback_cte as (select date_format(c.trans_date, "%Y-%m") as month, country, count(c.trans_id) as chargeback_count, sum(amount) as chargeback_amount
from chargebacks c left join transactions t on c.trans_id = t.id
group by date_format(c.trans_date, "%Y-%m"), country
)

# # # union 
select approved_cte.month, approved_cte.country, approved_count, approved_amount, if(chargeback_count is null, 0 ,chargeback_count) as chargeback_count,if(chargeback_amount is null, 0 , chargeback_amount) as chargeback_amount
from approved_cte left join chargeback_cte 
    on approved_cte.month = chargeback_cte.month
    and approved_cte.country = chargeback_cte.country

union

select chargeback_cte.month, chargeback_cte.country, 
if(approved_count is null, 0, approved_count) as approved_count, if(approved_amount is null, 0 ,approved_amount) as approved_amount, chargeback_count, chargeback_amount
from approved_cte right join chargeback_cte 
    on approved_cte.month = chargeback_cte.month 
    and approved_cte.country = chargeback_cte.country