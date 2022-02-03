-- https://leetcode.com/problems/consecutive-numbers/

select distinct c1.num as ConsecutiveNums
from logs c1 join logs c2 on c1.num = c2.num and c1.id = c2.id + 1
    join logs c3 on c2.num = c3.num and c2.id = c3.id + 1
    