-- https://leetcode.com/problems/sales-by-day-of-the-week/

select 
i.item_category as CATEGORY, 
sum(if(dayofweek(order_date) = 2, quantity,0)) as MONDAY,
sum(if(dayofweek(order_date) = 3, quantity,0)) as TUESDAY,
sum(if(dayofweek(order_date) = 4, quantity,0)) as WEDNESDAY,
sum(if(dayofweek(order_date) = 5, quantity,0) )as THURSDAY,
sum(if(dayofweek(order_date) = 6, quantity,0)) as FRIDAY,
sum(if(dayofweek(order_date) = 7, quantity,0)) as SATURDAY,
sum(if(dayofweek(order_date) = 1, quantity,0)) as SUNDAY
from orders o right join items i on o.item_id = i.item_id
group by item_category
order by 1