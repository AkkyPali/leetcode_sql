-- https://leetcode.com/problems/sales-analysis-ii/

select distinct buyer_id
from sales s join product p on p.product_id = s.product_id
where product_name = 'S8' 
and buyer_id NOT IN(select buyer_id
    from sales s join product p on p.product_id = s.product_id
    where product_name = 'iphone')