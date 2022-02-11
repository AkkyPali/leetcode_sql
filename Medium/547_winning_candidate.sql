-- https://leetcode.com/problems/winning-candidate/

select name
from vote v join candidate c on v.candidateid = c.id
group by v.candidateid
order by count(v.id) DESC
limit 1