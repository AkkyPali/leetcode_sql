-- https://leetcode.com/problems/nth-highest-salary/


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