select job_id, department_id, email, sum(salary)
  from employees
 group by job_id, department_id
ORDER BY 1, 2;


-- bug demo
select j.job_title, count(*) 
  from employees e
  join jobs j using (job_id)
 group by j.job_title
 order by 2 desc;


update departments set manager_id = 200 where department_id = 20;
delete job_history where employee_id = 201;
update employees set manager_id = 200 where manager_id = 201;
delete employees where employee_id = 201;


select * from jobs where job_title = 'Marketing Manager';
select * from employees where job_id = 'MK_MAN';


select job_id, AVG(salary) avarage, max(salary) maximum, min(salary) minimum
  from employees
 group by job_id;

-- AVG for timestamp???
-- AVG – doesn’t work with DATE types
select job_id, AVG(salary) avarage, max(salary) maximum, min(salary) minimum
  from employees
 group by job_id;


select job_id, min(salary)
from employees
group by job_id;
 
-- nested grouping
select max(min(salary))
  from employees
 group by department_id;

 
-- having
select job_id, AVG(salary) avarage, max(salary) maximum, min(salary) minimum
  from employees
 group by job_id
having min(salary) > 5000 and max(salary)!= min(salary);


FROM
WHERE
GROUP BY
HAVING
SELECT
ORDER BY

SELECT
FROM
WHERE
GROUP BY
HAVING
ORDER BY