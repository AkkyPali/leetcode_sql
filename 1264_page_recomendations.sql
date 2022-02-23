-- https://leetcode.com/problems/page-recommendations/

# Write your MySQL query statement below

select distinct page_id as recommended_page
from friendship f
join likes l on f.user2_id = l.user_id
where page_id not in (select page_id
                     from likes where user_id = 1) and user1_id = 1

union 

select distinct page_id as recommended_page
from friendship f
join likes l on f.user1_id = l.user_id
where page_id not in (select page_id
                     from likes where user_id = 1) and user2_id = 1