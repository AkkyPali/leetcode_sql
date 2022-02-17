-- https://leetcode.com/problems/exchange-seats/


select
    case when mod(id,2) != 0 and id != s1.count then id + 1
    when mod(id, 2) != 0 and id = s1.count then id
else id - 1
end id, student 
from seat, (select count(id) as count from seat) s1
order by 1
