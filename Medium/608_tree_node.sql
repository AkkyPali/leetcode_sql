-- https://leetcode.com/problems/tree-node/

select id,
case when t.p_id is null then "Root"
when t1.p_id is null then "Leaf"
else "Inner" end type
from tree t left join (select p_id from tree group by p_id) t1 on t.id = t1.p_id