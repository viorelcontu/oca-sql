-- union
select job_id, job_title, min_salary, max_salary 
  from jobs where min_salary > 10000
union
select job_id, job_title, min_salary, max_salary 
  from jobs where min_salary > 20000;


-- union all
select job_id, job_title, min_salary, max_salary 
  from jobs where min_salary > 10000
union all
select job_id, job_title, min_salary, max_salary 
  from jobs where min_salary > 20000;


-- minus
select job_id, job_title, min_salary, max_salary 
  from jobs where min_salary > 10000
minus
select job_id, job_title, min_salary, max_salary 
  from jobs where min_salary > 20000;
  
  
-- intersect
select job_id, job_title, min_salary, max_salary 
  from jobs where min_salary > 10000
intersect
select job_id, job_title, min_salary, max_salary 
  from jobs where min_salary > 20000;
  
  
-- use case
select job_id, sum(salary)
  from employees group by job_id
union
select 'TOTAL', sum(salary)
  from employees;
