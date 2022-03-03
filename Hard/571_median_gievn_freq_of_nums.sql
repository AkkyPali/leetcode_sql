-- https://leetcode.com/problems/find-median-given-frequency-of-numbers/


with cte as (select num,
sum(frequency) over() as total_nums,
sum(frequency) over(order by num) as running_tot
from numbers)

, cte2 as (select num, 
total_nums,
running_tot,
lag(running_tot,1,0) over() as lag_running_tot
from cte )

select avg(num) as median
from cte2
where 
if(
    total_nums%2 != 0,
    ((total_nums+1)/2 between (lag_running_tot+1) and running_tot),
    (
        (((total_nums)/2 + 1) between (lag_running_tot+1) and running_tot) or
        ((total_nums)/2 between (lag_running_tot+1) and running_tot)
    )
)