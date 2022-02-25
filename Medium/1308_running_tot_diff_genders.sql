-- https://leetcode.com/problems/running-total-for-different-genders/

select 
gender,
day,
sum(score_points) over(partition by gender order by gender, day) as total
from scores
group by 1, 2
# order by 1, 2