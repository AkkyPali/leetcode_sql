-- https://leetcode.com/problems/count-student-number-in-departments/

-- # Write your MySQL query statement below

select dept_name, if(count(student_id) is null, 0, count(student_id)) as student_number
from student s right join department d on s.dept_id = d.dept_id
group by d.dept_id 
order by 2 DESC, 1