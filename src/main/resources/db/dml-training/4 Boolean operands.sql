/*+-----------------------------------------+*/
/*|		AND operator through table			|*/
/*+-----------------------------------------+*/
/*|	Condit. X	|	Condit. Y	|	Result	|*/
/*+-------------+---------------+-----------+*/
/*|	TRUE		|	TRUE		|	TRUE	|*/  select * from dual where 'T' = 'T' and 'T' = 'T';
/*|	TRUE		|	FALSE		|	FALSE	|*/  select * from dual where 'T' = 'T' and 'T' = 'F';
/*|	TRUE		|	NULL		|	NULL	|*/  select * from dual where 'T' = 'T' and 'T' = null;      --
/*|	FALSE		|	TRUE		|	FALSE	|*/  select * from dual where 'T' = 'F' and 'T' = 'T';
/*|	FALSE		|	FALSE		|	FALSE	|*/  select * from dual where 'T' = 'F' and 'T' = 'F';
/*|	FALSE		|	NULL		|	FALSE	|*/  select * from dual where 'T' = 'F' and 'T' = null;      --
/*|	NULL		|	TRUE		|	NULL	|*/  select * from dual where NULL = 'T' and 'T' = 'T';      --
/*|	NULL		|	FALSE		|	FALSE	|*/  select * from dual where NULL = 'T' and 'T' = 'F';      --
/*|	NULL		|	NULL		|	NULL	|*/  select * from dual where NULL = 'T' and NULL = 'T';     --
/*+-------------+---------------+-----------+*/



/*+-----------------------------------------+*/
/*|		OR operator through table			|*/
/*+-----------------------------------------+*/
/*|	Condit. X	|	Condit. Y	|	Result	|*/
/*+-------------+---------------+-----------+*/
/*|	TRUE		|	TRUE		|	TRUE	|*/  select * from dual where 'T' = 'T' or 'T' = 'T';
/*|	TRUE		|	FALSE		|	TRUE	|*/  select * from dual where 'T' = 'T' or 'T' = 'F';
/*|	TRUE		|	NULL		|	TRUE	|*/  select * from dual where 'T' = 'T' or 'T' = null;       --
/*|	FALSE		|	TRUE		|	TRUE	|*/  select * from dual where 'T' = 'F' or 'T' = 'T';
/*|	FALSE		|	FALSE		|	FALSE	|*/  select * from dual where 'T' = 'F' or 'T' = 'F';
/*|	FALSE		|	NULL		|	NULL	|*/  select * from dual where 'T' = 'F' or 'T' = null;       --
/*|	NULL		|	TRUE		|	TRUE	|*/  select * from dual where NULL = 'T' or 'T' = 'T';       --
/*|	NULL		|	FALSE		|	NULL	|*/  select * from dual where NULL = 'T' or 'T' = 'F';       --
/*|	NULL		|	NULL		|	NULL	|*/  select * from dual where NULL = 'T' or NULL = 'T';      --
/*+-------------+---------------+-----------+*/

select 'URA!'
from dual
where 1=1
  and 1=1
   or 1=1;


select 'URA!'
from dual
where 1=0
  and 1=1
   or 1=1;


select 'URA!'
from dual
where 1=1
  and 1=0
   or 1=1;


select 'URA!'
from dual
where 1=1
  and 1=1
   or 1=0;


---------------------------------------------------------


select 'URA!'
from dual
where 1=0
   or 1=1
  and 1=1;


select 'URA!'
from dual
where 1=1
   or 1=0
  and 1=1;


select 'URA!'
from dual
where 1=1
   or 1=1
  and 1=0;

--------------------------------------------------

select 'URA!'
from dual
where ( 1=0
     or 1=1 )
    and 1=0;


select 'URA!'
from dual
where ( 1=1
    and 1=1 )
    and 1=0;


select 'URA!'
from dual
where ( 1=1
    and 1=1 )
     or 1=0;


select 'URA!'
from dual
where ( 1=1
     or 1=1 )
     or 1=0;


select *
  from employees
 where department_id = 50           --
   and job_id = 'IT_PROG'           --
    or first_name = 'Alexander'     --
   and salary > 5000                --
    or job_id = 'IT_PROG'           --
    or job_id = 'ST_MAN';           --


-- TEST
select *
  from employees
 where department_id = 50
   and not job_id = 'IT_PROG'
    or not first_name like 'Alex%'
   and manager_id is not null
   and not (
            salary not between 5000 and 100000
            or job_id not in ('IT_PROG', 'ST_MAN')
            );