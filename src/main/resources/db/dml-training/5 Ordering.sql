select * from employees order by 1;


select * from employees order by first_name asc;


select * from employees order by first_name, salary + 100 desc;


select * from employees order by commission_pct desc nulls first;


select first_name, last_name from employees order by salary asc;


select first_name, last_name "surname" from employees order by "surname";