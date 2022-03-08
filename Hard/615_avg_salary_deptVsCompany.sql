-- https://leetcode.com/problems/average-salary-departments-vs-company/
with cte as 
(select 
 DATE_FORMAT(pay_date,'%Y-%m') as pay_date, 
 department_id,
 s.employee_id,
 s.amount
from salary s left join employee d on s.employee_id = d.employee_id 
)

# select * from cte
,cte2 as (select pay_date, department_id,
Round(avg(amount) over(partition by pay_date),2) as avg_company_sal,
Round(avg(amount) over(partition by department_id, pay_date),2) as avg_dept_sal
from cte)

select 
    distinct pay_date as pay_month, 
    department_id,
    case when avg_company_sal > avg_dept_sal then "lower" 
    when avg_company_sal = avg_dept_sal then "same" 
    when avg_company_sal < avg_dept_sal then "higher" end as comparison
    from cte2