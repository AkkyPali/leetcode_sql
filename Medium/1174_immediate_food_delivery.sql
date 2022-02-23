-- https://leetcode.com/problems/immediate-food-delivery-ii/

with cte as (select 
min(order_date) over(partition by customer_id) as min_dt
 ,order_date
,customer_pref_delivery_date
, delivery_id
from delivery )


select 
round(sum(if(abs(datediff(order_date, customer_pref_delivery_date)) = 0, 1,0))/count(delivery_id)*100,2) as immediate_percentage
from cte 
where abs(datediff(min_dt,order_date)) = 0