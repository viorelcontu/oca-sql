-- dual table
select * from dual;


select 'hello' || ' world' from dual;


select sysdate from dual;


select to_date('15-feb-2018') from dual;


-- projections
select * from jobs;


select job_title, max_salary from jobs;


select job_title || ', ' || max_salary from jobs;


-- alias
select job_title as "job", max_salary salary from jobs;


select 'Description: ' || job_title  || ', salary=' || max_salary job_description 
from jobs;


select j.* from jobs j;


-- selection
select * from jobs where job_title = 'Programmer';

 
select *
  from jobs
 where job_title = 'Programmer'
   and max_salary > 8000
    or min_salary > 10000;
    
    
select *
  from jobs
 where max_salary between 20000 and 25000;
    

select *
  from jobs
 where 10000 between min_salary and max_salary;


select *
  from jobs
 where job_title between 'Account' and 'Manager';

    
select *
  from jobs
 where max_salary in (5000,10000,15000,20000);


select *
  from jobs
 where 10000 in (min_salary, max_salary);

    
select *
  from jobs
 where job_title like '%Manager%';
 
 
select *
  from jobs
 where job_title like '%Ma__ger%';
 
 
select *
  from jobs
 where length(job_title) > 20;


--Test
select *
  from jobs
 where length(job_title) > 10
   and max_salary between 1000 and 10000
   and max_salary > 2000
   and max_salary < 9000
   and max_salary in (1000, 2000, 3000, 4000, 5000, 6000, 7000, 8000, 9000, 10000)