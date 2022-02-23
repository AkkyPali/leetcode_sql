-- https://leetcode.com/problems/product-price-at-a-given-date/

# Write your MySQL query statement below

with cte as (select 
product_id
,change_date
,max(change_date) over(partition by product_id) as max_dt
,new_price 
from products
where change_date <= "2019-08-16")

# select distinct product_id from products
select 
if(cte.new_price is null, 10, new_price) as price
, pid.product_id 
from cte right join (select distinct product_id from products) pid 
on cte.product_id = pid.product_id
where max_dt = change_date or max_dt is null