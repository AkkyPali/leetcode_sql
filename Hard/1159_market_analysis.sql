-- https://leetcode.com/problems/market-analysis-ii/

# Write your MySQL query statement below

with cte as (select 
rank() over(partition by seller_id order by order_date) as r,
seller_id, 
item_brand
from orders o left join items i on o.item_id = i.item_id
)

,cte2 as (select 
seller_id,
if(item_brand = favorite_brand, "yes", "no") as 2nd_item_fav_brand
from cte left join users u on u.user_id = cte.seller_id
where r = 2
)

select u.user_id as seller_id,
if(2nd_item_fav_brand is null, "no", 2nd_item_fav_brand) as 2nd_item_fav_brand
from cte2 right join users u on u.user_id = cte2.seller_id
