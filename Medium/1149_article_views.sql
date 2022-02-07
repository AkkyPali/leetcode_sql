-- https://leetcode.com/problems/article-views-ii/

with cte as (select *
from views
group by view_date, viewer_id, article_id
)

select distinct viewer_id as id
from cte
group by view_date, viewer_id
having count(article_id) >= 2
order by 1