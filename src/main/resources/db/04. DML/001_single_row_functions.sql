/*+-----------------------------------------------------------------------------+*/
/*| 					Operating on Character Data								|*/
/*+---------+-------------------------------------------+-----------------------+*/
/*|	lower	|	lower('Camel CASE')						|	camel case			|*/  select lower('Camel CASE') from dual;
/*|			|	lower('10+10'||' = ' || (10 + 10))		|	10+10 = 20			|*/  select lower('10+10'||' = ' || (10 + 10)) from dual;
/*|			| 	lower(sysdate)							|	05-oct-18			|*/  select lower(sysdate) from dual;
/*+---------+-------------------------------------------+-----------------------+*/
/*|	upper	|	upper('Camel CASE')						|	CAMEL CASE			|*/  select upper('Camel CASE') from dual;
/*+---------+-------------------------------------------+---------------------	+*/
/*|	initcap	|	initcap('Camel CASE')					|	Camel Case			|*/  select initcap('Camel CASE') from dual;		
/*|			|	initcap('in_cp in%cp in%cp')			|	It_Cap It%Cp It!Cp	|*/  select initcap('it_cap it%cp it!cp') from dual;
/*+---------+-------------------------------------------+-----------------------+*/
/*|	length	|	length('Camel CASE')					|	10					|*/  select length('Camel CASE') from dual;
/*+---------+-------------------------------------------+-----------------------+*/
/*|	concat	|	concat('Camel CASE','  test')			|	Camel CASE test		|*/  select concat('Camel CASE','  test') from dual;
/*+---------+-------------------------------------------+-----------------------+*/
/*|	substr	|	substr('123456789', 7)                  |	789               	|*/  select substr('123456789', 7) from dual;
/*|			|	substr('123456789', 0, 3)               |	123               	|*/  select substr('123456789', 0, 3) from dual;       
/*|			|	substr('123456789', 1, 3)               |	123               	|*/  select substr('123456789', 1, 3) from dual;
/*|			|	substr('123456789', 7, 100)             |	789               	|*/  select substr('123456789', 7, 100) from dual;
/*|			|	substr('123456789', 7, 0)               |	Null              	|*/  select substr('123456789', 7, 0) from dual;  
/*|			|	substr('123456789', 7, -2)              |	Null              	|*/  select substr('123456789', 7, -2) from dual;
/*|			|	substr('123456789', -4)                 |	6789              	|*/  select substr('123456789', -4) from dual;
/*|			|	substr('123456789', -6, 4)	            |	4567              	|*/  select substr('123456789', -6, 4) from dual;
/*+---------+-------------------------------------------+-----------------------+*/
/*|	Instr	|	instr('Camel CASE', 'am')               |	2                 	|*/  select instr('Camel CASE', 'am') from dual;
/*|			|	instr('Camel CASE', 'am', 3)            |	0                 	|*/  select instr('Camel CASE', 'am', 3) from dual;
/*|			|	instr('1#3#5#7#9#','#',3,4)             |	10                	|*/  select instr('1#3#5#7#9#','#',3,4) from dual;
/*|			|	instr('1#3#5#7#9#','#',-4,2)	        |	4                 	|*/  select instr('1#3#5#7#9#','#',-4,2) from dual;
/*+---------+-------------------------------------------+-----------------------+*/
/*|	Lpad	|	lpad('Camel CASE', 15, '#*$')			|	#*$#*Camel CASE		|*/  select lpad('Camel CASE', 15, '#*$') from dual;
/*+---------+-------------------------------------------+-----------------------+*/
/*|	Rpad	|	rpad('Camel CASE', 15, '#*$')			|	Camel CASE#*$#*		|*/  select rpad('Camel CASE', 15, '#*$') from dual;
/*+---------+-------------------------------------------+-----------------------+*/
/*|	Trim	|	trim(' Camel CASE ')					|	Camel CASE        	|*/  select trim(' Camel CASE ') from dual;
/*|			|	trim(both '*' from '**Hidden**')        |	Hidden            	|*/  select trim(both '*' from '**Hidden**') from dual;
/*|			|	trim(both '*' from '**Hidden**')        |	Hidden            	|*/  select trim(both '*' from '**Hidden**') from dual;
/*|			|	trim(leading '*' from '**Hidden**')     |	Hidden**          	|*/  select trim(leading '*' from '**Hidden**') from dual;
/*|			|	trim(trailing '*' from '**Hidden**')	|	**Hidden          	|*/  select trim(trailing '*' from '**Hidden**')	 from dual;
/*+---------+-------------------------------------------+-----------------------+*/
/*|	replace	|	replace('Camel CASE', 'CASE', 'case')	|	Camel case			|*/  select replace('Camel CASE', 'CASE', 'case') from dual;
/*|			|	replace(10000-3,'9','85')				|	8585857				|*/  select replace(10000-3,'9','85') from dual;
/*+---------+-------------------------------------------+-----------------------+*/



/*+-------------------------------------------------+*/
/*| 			Operating on Numeric Data			|*/
/*+---------+---------------------------+-----------+*/
/*|	round	|	round(10.5)				|	11		|*/  select round(10.5) from dual;
/*|			|	round(3.14159)			|	3		|*/  select round(3.14159) from dual;
/*|			| 	round(3.14159, 2)		|	3.14	|*/  select round(3.14159, 2) from dual;
/*|			| 	round(1601.916718,-3)	|	2000	|*/  select round(1601.916718,-3) from dual;
/*+---------+---------------------------+-----------+*/
/*|	trunc	|	trunc(3.14159)			|	3		|*/  select trunc(3.14159) from dual;
/*|			|	trunc(3.14159, 2)		|	3.14	|*/  select trunc(3.14159, 2) from dual;
/*|			|	trunc(299.72, -2)		|	200		|*/  select trunc(299.72, -2) from dual;
/*+---------+---------------------------+-----------+*/
/*|	mod		|	mod(7, 2)				|	1		|*/  select mod(7, 2) from dual;
/*|			|	mod(2, 7)				|	2		|*/  select mod(2, 7) from dual;
/*+---------+---------------------------+-----------+*/



/*+-------------------------------------------------------------------------------------------------+*/	
/*| 							Operating on Date													|*/	
/*+-----------------+---------------------------------------------------+---------------------------+*/	
/*|	Sysdate			|	Sysdate											|	26-DEC-15				|*/	select Sysdate from dual;
/*+-----------------+---------------------------------------------------+---------------------------+*/	
/*|	months_between	|	months_between('15-FEB-1995', '01-JAN-1995')	|	1.45161290322580645...	|*/	select months_between('15-FEB-1995', '01-JAN-1995') from dual;
/*|					|	months_between('01-JAN-1995', '15-FEB-1995')	|	-1.45161290322580645...	|*/	select months_between('01-JAN-1995', '15-FEB-1995') from dual;
/*+-----------------+---------------------------------------------------+---------------------------+*/	
/*|	add_months		|	add_months('15-FEB-1995', 3)					|	15-MAY-95				|*/	select add_months('15-FEB-1995', 3) from dual;
/*+-----------------+---------------------------------------------------+---------------------------+*/	
/*|	last_day		|	last_day('15-FEB-1995')							|	28-FEB-95				|*/	select last_day('15-FEB-1995') from dual;
/*+-----------------+---------------------------------------------------+---------------------------+*/	
/*|	next_day		|	next_day('15-FEB-1995', 'Monday')				|	20-FEB-95				|*/	select next_day('15-FEB-1995', 'Monday') from dual;
/*|					|	next_day('15-FEB-1995', 2)						|	20-FEB-95				|*/	select next_day('15-FEB-1995', 2) from dual;
/*+-----------------+---------------------------------------------------+---------------------------+*/	
/*|	Round			|	round(to_date('30-jun-1995'),'year')			|	01-JAN-96				|*/	select round(to_date('30-jun-1995'),'year') from dual;
/*|					|	round(to_date('1-jul-1995'),'year')				|	01-JAN-96				|*/	select round(to_date('1-jul-1995'),'year') from dual;
/*|					|	round(to_date('1-jul-1995'))					|	01-JUL-95				|*/	select round(to_date('1-jul-1995')) from dual;
/*+-----------------+---------------------------------------------------+---------------------------+*/	
/*|	Trunc			|	trunc(to_date('1-jul-1995'), 'month')			|	26-DEC-15				|*/	select trunc(to_date('1-jul-1995'), 'month') from dual;
/*+-----------------+---------------------------------------------------+---------------------------+*/