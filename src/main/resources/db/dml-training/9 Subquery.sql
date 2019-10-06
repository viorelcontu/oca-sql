--Single-row/scalar subqueries
-- check execution plan
select e.job_id,
       e.first_name
     , e.last_name
     , e.salary
     , ( select (min_salary + max_salary) / 2 
           from jobs j 
          where j.job_id = e.job_id) avarage
  from employees e;


select e.first_name, e.last_name, e.salary, (min_salary + max_salary) / 2 avarage
  from employees e inner JOIN jobs j using(job_id);


select *
  from employees
 where job_id = ( select job_id from jobs order by max_salary desc fetch first 1 row only );


--Multiple-row subqueries
select *
  from employees
 where job_id in ( select job_id from jobs where max_salary > 20000);


--Correlated subqueries
select e.*
  from employees e
 where job_id in ( select job_id 
                     from jobs j 
                    where ((j.max_salary + j.min_salary) / 2) < e.salary);
                  

select *
  from employees e
  join jobs j using(job_id)
 where lower(job_title) like '%programmer%';


-- with query
WITH managers AS (
    select 'manager' , first_name, last_name
      from employees e
      join jobs j using(job_id)
     where lower(job_title) like '%manager%'
),
programmers AS (
    select 'programmer' , first_name, last_name
      from employees e
      join jobs j using(job_id)
     where lower(job_title) like '%manager%'
)
select * from managers
union
select * from programmers;

