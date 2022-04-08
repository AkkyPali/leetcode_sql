-- Q: How would you select stratified samples, N samples from each strata from a table? 
-- table has 2 columns id, lables  


with cte as (select row_number() over(partition by labels order by rand()) r, lables, id
from table) 

select id, labels
from cte where r < = N


