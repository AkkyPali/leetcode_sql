-- https://leetcode.com/problems/all-people-report-to-the-given-manager/

select e.employee_id
from employees e join employees e1 on e.manager_id = e1.employee_id join employees e2 on e1.manager_id = e2.employee_id
where e2.manager_id = 1 and e.employee_id != 1