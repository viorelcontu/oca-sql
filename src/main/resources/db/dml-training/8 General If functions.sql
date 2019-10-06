select nullif(123, 456) from dual;
select nullif(123, 123) from dual;


select nvl(null, 123) from dual;
select nvl(4561, 123) from dual;


select nvl2(null, 123, 456) from dual;
select nvl2(0, 123, 456) from dual;
select * from employees;
select first_name, last_name, nvl2(commission_pct, salary - (salary *  commission_pct), salary) as salary from employees;


select coalesce(null, null, 1, null, 2) from dual;


select decode('val', 'opt1', 'then1', 'opt2', 'then2', 'default') from dual;
select * from employees



select case when 1=1 then 'equalce' else 'different' end from dual;


/*+---------------------------------------------------------------------------------------------------------------------------------+*\
/*|	NULLIF(123, 456)		|	123	|	The values must be the STRICT same type! First arg can't be EXPLICIT NULL					|*\
/*|	NVL(null, 123)			|	123	|	The type of the first parameter leads, the second parameter must be convertible to 1		|*\
/*|	NVL2(null, 123, 456)	|	456	|	The type of the second parameter leads, the second parameter must be convertible to 2		|*\
/*|	COALESCE				|		|	At least 2 arguments! STRICT same type!														|*\
/*|	DECODE					|		|	Frist checked and returned values dictates the type. Conversions are resolved in runtime.	|*\
/*|	CASE					|		|	The possible returned values must be the STRICT same type!									|*\
/*+---------------------------------------------------------------------------------------------------------------------------------+*\