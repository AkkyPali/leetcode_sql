-- https://leetcode.com/problems/nth-highest-salary/

-- Using Cross Join

CREATE FUNCTION getNthHighestSalary(N INT) RETURNS INT
BEGIN
  RETURN (
      with cte as (select salary, dense_rank() over(order by salary DESC) as r 
      from employee)
      
      select distinct cte1.salary 
      from cte as cte1
      cross join cte as cte2 
      where cte2.r = N and cte1.r = N
  );
END

-- creating a table
CREATE FUNCTION getNthHighestSalary(N INT) RETURNS INT
BEGIN
  RETURN (
      
      with cte as 
      (select salary, id,
      dense_rank() over(order by salary desc) as num
      from employee )
      
      select distinct salary 
      from cte c 
      right join (select n as id) r on c.num = r.id
  );
END
