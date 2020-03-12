--please read about SQL literals before reading the following text:
--https://docs.oracle.com/cd/B19306_01/server.102/b14200/sql_elements003.htm

SELECT *
FROM nls_session_parameters
WHERE parameter = 'NLS_DATE_FORMAT';

CREATE TABLE datetable (
    event DATE
);

INSERT INTO datetable(event) VALUES ('1-APR-2019');
INSERT INTO datetable(event) VALUES (DATE '2019-10-01');
INSERT INTO datetable(event) VALUES (to_DATE('2019-10-01', 'YYYY-MM-DD'));

SELECT * from datetable;

-- TYPE CONVERSION
-- https://docs.oracle.com/cd/B19306_01/server.102/b14200/sql_elements002.htm
-- IMPLICIT TYPE CONVERSION

/*
 CHAR/VARCHAR2 -> DATE/TIMESTAMP
 CHAR/VARCHAR2 -> NUMBER

 NUMBER -> CHAR/VARCHAR2
 DATE -> CHAR/VARCHAR2

 NO IMPLICIT CONVERSION NUMBER <> DATE
 */

-- 1. Arithmetic operations
/*
    During arithmetic operations on and comparisons between character and noncharacter datatypes, Oracle converts from any character datatype to a numeric, date, or rowid, as appropriate. In arithmetic operations between CHAR/VARCHAR2 and NCHAR/NVARCHAR2, Oracle converts to a NUMBER.

    Arithmetic operators: "+"  "-"  "/"  "*"
 */

SELECT 1 + 2 FROM dual;
SELECT '1' + 2 FROM dual;
SELECT 1 + '2' FROM dual;
SELECT '1' + '2' FROM dual;

SELECT 1 + 'blabla' FROM dual; --invalid number

SELECT 1 + '2.5' FROM dual; --works for floating point numbers

SELECT event, event + 53/3600 from datetable; --event is date therefore the result will be a date.
SELECT event, 10 + event from datetable; --order does not matter
SELECT event, 1 + '10' + event from datetable; --it's a date!

SELECT 1 + '5-SEP-2020' from dual; -- not working because by default '5-SEP-2020' is a VARCHAR!
/* it does not know that '5-SEP-2020' is a date, and since we have a number + varchar, it tries to convert it to number
   and we hav no implicit conversion
 */

SELECT 1 + Cast('5-SEP-2020' as Date) from dual; -- not working because by default '5-SEP-2020' is a VARCHAR!

-- When comparing a character value with a numeric value, Oracle converts the character data to a numeric value.
SELECT CASE
           WHEN 10 > '1' THEN 'we are comparing numbers'
           END
FROM dual;

--if both are varchars/chars, then we are comparing by varchars
SELECT CASE
           WHEN 'a' < 'b' THEN 'varchars'
           END
FROM dual;


--------------------------------------------------------------------------------------------

-- 2.
/* When comparing a character value with a DATE value, Oracle converts the character data to DATE. */
SELECT event < '25-MAR-1999' from datetable; --we cannot output the result of such comparisons, let's use case for this

SELECT event,
       CASE
           WHEN event < '1-JUL-2019' THEN 'is before 1st of July'
           ELSE
               'event is after 1st of July'
       END
FROM datetable
ORDER BY event;

CREATE TABLE comparables
(
    id NUMBER(10),
    textvalue VARCHAR2(32),
    datevalue DATE

);

INSERT INTO comparables(id, textvalue, datevalue) VALUES (1, '1-FEB-2019', '1-FEB-2019');
INSERT INTO comparables(id, textvalue, datevalue) VALUES (2, '1-APR-2019', '1-APR-2019');
INSERT INTO comparables(id, textvalue, datevalue) VALUES (3, '1-MAY-2019', '1-MAY-2019');

SELECT * from comparables ORDER BY textvalue;
SELECT * from comparables ORDER BY datevalue;

/* when both values are varchars, compares them as varchars. at least one needs to be a date for them to be compared as dates */
SELECT CASE
           WHEN '1-MAR-2019' < '1-APR-2019' THEN 'this will never display, because you are comparing varchars'
           ELSE
                'you are comparing varchars'
           END hellofield
FROM dual;

--Oracle needs to see at least one as a date
--we are using conversion function to_date here
SELECT CASE
           WHEN to_date('1-MAR-2019')  < '1-APR-2019' THEN 'you are comparing dates now'
           ELSE
               'you are comparing varchars'
           END
FROM dual;

--we are casting varchar as a date
SELECT CASE
           WHEN '1-MAR-2019'  < cast ('1-APR-2019' as date) THEN 'you are comparing dates now'
           ELSE
               'you are comparing varchars'
           END
FROM dual;

------------------------------------------------------------------------------------

--During concatenation operations, Oracle converts from noncharacter datatypes to CHAR or NCHAR.--
SELECT event || 'hello world' FROM datetable;

--During INSERT and UPDATE operations, Oracle converts the value to the datatype of the affected column.
INSERT INTO datetable(event) VALUES '1-JAN-2019'; --event is a date, therefore it compares it with a date


------------------------------------------------------------------------------
-- When you use a SQL function or operator with an argument of a datatype other than the one it accepts, Oracle converts the argument to the accepted datatype.

--Lower works with varchar, implicit conversion date-to-varchar
SELECT lower(event) from datetable;

SELECT round(event, 'YY') from datetable; --has overloaded accepts both dates and numbers

-- if the function expects string, and you give it a date literal, it will work with it as a string!
SELECT lower('14-APR-2019') from dual;

SELECT length(123456) from DUAL;


/*+-------------------------------------------------------------------------------------------------+*/
/*| 				Examples of Implicit Character to Date Conversion								|*/
/*+---------------------------------------------+-------------------------------+-------------------+*/
/*|	add_months('24-JAN-09', 1)					|	DD-MON-RRR					|	24-FEB-09		|*/	select add_months('24-JAN-09', 1) from dual;
/*+---------------------------------------------+-------------------------------+-------------------+*/
/*|	add_months('1/January\8', 1)	    		|	D\MONTH/R					|	01-FEB-08		|*/	select add_months('1/January\8', 1) from dual;
/*+---------------------------------------------+-------------------------------+-------------------+*/
/*|	months_between('13*jan*8', '13/feb/2008')	|	DD*MON*R DD/MON/RR			|	-1				|*/	select months_between('13*jan*8', '13/feb/2008') from dual;
/*+---------------------------------------------+-------------------------------+-------------------+*/
/*|	add_months('01$jan/08', 1)					|	DD-MON-RR 					|	01-FEB-08		|*/	select add_months('01$jan/08', 1) from dual;
/*+---------------------------------------------+-------------------------------+-------------------+*/
/*|	add_months('13!jana08', 1)					|	JANA is an invalid month	|	ORA-01861: ...	|*/	select add_months('13!jana08', 1) from dual;
/*+---------------------------------------------+-------------------------------+-------------------+*/
/*|	add_months('24-JAN-09 18:45')   			|	DD-MON-RR HH24:MI			|	ORA-01830: ...	|*/	select add_months('24-JAN-09 18:45') from dual;
/*+---------------------------------------------+-------------------------------+-------------------+*/
/*|	sysdate - '01-JAN-2007'						|								|	ORA-01722: ...	|*/	select sysdate - '01-JAN-2007' from dual;
/*+---------------------------------------------+-------------------------------+-------------------+*/



--EXPLICIT type conversion
-- to_char
-- to_date
-- to_number


/*+-----------------------------------------------------------------------------------------+*/
/*|	Using Conversion (does round if something doesn't fit)									|*/
/*+---------------------------------+-------------------------------------------------------+*/
/*|	to_char(00001)					|	1													|*/	select to_char(00001) from dual;
/*+---------------------------------+-------------------------------------------------------+*/
/*|	to_char(00001,'0999')			|	0001												|*/	select to_char(00001, '0999') from dual;
/*+---------------------------------+-------------------------------------------------------+*/
/*|	to_char(1,'0999')				|	0001												|*/	select to_char(1, '0999') from dual;
/*+---------------------------------+-------------------------------------------------------+*/
/*|	to_char(40000,'$99,999.99')		| 	$40,000.00											|*/	select to_char(40000, '$99,999.99') from dual;
/*+---------------------------------+-------------------------------------------------------+*/
/*|	to_char(40000,'$9,999.99')		| 	##########											|*/	select to_char(40000, '$9,999.99') from dual;
/*+---------------------------------+-------------------------------------------------------+*/
/*|	to_number(123.45, '99999.9')	|	ERROR! Invalid number if it doesn't fit the mask	|*/	select to_number(123.45, '99999.9') from dual;
/*+---------------------------------+-------------------------------------------------------+*/



/*+-----------------------------------------------------------------------------------------------------------------------------------------+*/
/*|										Element	Description	Format	Number	Character Result												|*/
/*+---------+-----------------------------------------------+-----------------------+-------------------+-----------------------------------+*/
/*|	Element	|	Description									|	Format				|	Number			|	Character Result              	|*/
/*+---------+-----------------------------------------------+-----------------------+-------------------+-----------------------------------+*/
/*|	9		|	Numeric width								|	9999				|	12				|	12                             	|*/
/*+---------+-----------------------------------------------+-----------------------+-------------------+-----------------------------------+*/
/*|	0		|	Displays leading zeros (output 5 digits)	|	09999( = 00000)		|	0012			|	00012                          	|*/
/*+---------+-----------------------------------------------+-----------------------+-------------------+-----------------------------------+*/
/*|	.		|	Position of decimal point					|	09999.999			|	030.40			|	00030.400                      	|*/
/*+---------+-----------------------------------------------+-----------------------+-------------------+-----------------------------------+*/
/*|	D		|	Decimal separator(period is default)		|	09999D999			|	030.40			|	00030.400                      	|*/
/*+---------+-----------------------------------------------+-----------------------+-------------------+-----------------------------------+*/
/*|	,		|	Position of comma symbol					|	09999,999			|	03040			|	00003,040                      	|*/
/*+---------+-----------------------------------------------+-----------------------+-------------------+-----------------------------------+*/
/*|	G		|	Group separator pos. (comma default)		|	09999G999			|	03040			|	00003,040                      	|*/
/*+---------+-----------------------------------------------+-----------------------+-------------------+-----------------------------------+*/
/*|	$		|	Dollar sign									|	$099999 			|	(= 099999$)		|	03040	$003040                	|*/
/*+---------+-----------------------------------------------+-----------------------+-------------------+-----------------------------------+*/
/*|	L		|	Local currency								|	L099999 			|	(099999L)		|	03040	$003040 (003040$)       |*/
/*+---------+-----------------------------------------------+-----------------------+-------------------+-----------------------------------+*/
/*|	MI		|	Position of minus sigh for negatives		|	99999MI				|	-3040			|	3040-                          	|*/
/*+---------+-----------------------------------------------+-----------------------+-------------------+-----------------------------------+*/
/*|	PR		|	Wrap negatives in parentheses				|	99999PR				|	-3040			|	<3040>                         	|*/
/*+---------+-----------------------------------------------+-----------------------+-------------------+-----------------------------------+*/
/*|	EEEE	|	Scientific notation							|	99.99999EEEE		|	121.976			|	1.21976E+02                    	|*/
/*+---------+-----------------------------------------------+-----------------------+-------------------+-----------------------------------+*/
/*|	U		|	Nls_dual_currency							|	U099999 (099999U)	|	03040			|	$003040 (003040$)   		    |*/
/*+---------+-----------------------------------------------+-----------------------+-------------------+-----------------------------------+*/
/*|	V		|	Mult by 10n times (dosn't work with 		|	9999V99 (n = 2)		|	3040			|	304000                         	|*/
/*|			|	.||D. G||, can be used before V)	        |	                	|	                |	                               	|*/
/*+---------+-----------------------------------------------+-----------------------+-------------------+-----------------------------------+*/
/*|	S		|	+ or – sign is fixed						|	S999999 (999999S)	|	3040			|	+3040 (3040+)          			|*/
/*+---------------------------------------------------------+-----------------------+-------------------+-----------------------------------+*/



/*+---------------------------------------------+*/
/*|				Date to Character				|*/
/*+-----------------------------+---------------+*/
/*|	to_char(sysdate)			|	31-DEC-15	|*/
/*+-----------------------------+---------------+*/
/*|	to_char(sysdate, 'Month')	|	December	|*/
/*+-----------------------------+---------------+*/
/*|	to_char(sysdate, 'fmMonth')	|	December	|*/
/*+-----------------------------+---------------+*/



/*+-------------------------------------------------------------------------------------------------------------+*/
/*|											Date Format Masks 	                                    			|*/
/*+---------+-------------------------------------------------------+-------------------------------------------+*/
/*|	Element	|	Description											|	Result									|*/
/*+---------+-------------------------------------------------------+-------------------------------------------+*/
/*|	Y		|	Last digit of year									|	5										|*/
/*+---------+-------------------------------------------------------+-------------------------------------------+*/
/*|	YY		|	Last two digits of year								|	15										|*/
/*+---------+-------------------------------------------------------+-------------------------------------------+*/
/*|	YYY		|	Last three digits of year							|	015										|*/
/*+---------+-------------------------------------------------------+-------------------------------------------+*/
/*|	YYYY	|	Four-digit year										|	2015									|*/
/*+---------+-------------------------------------------------------+-------------------------------------------+*/
/*|	RR		|	Two-digit year										|	15										|*/
/*+---------+-------------------------------------------------------+-------------------------------------------+*/
/*|	RRRR	|	Four-digit year										|	2015									|*/
/*+---------+-------------------------------------------------------+-------------------------------------------+*/
/*|	YEAR	|	Case-sensitive English spelling of year				|	TWENTY FIFTEEN							|*/
/*+---------+-------------------------------------------------------+-------------------------------------------+*/
/*|	MM		|	Two-digit month										|	06										|*/
/*+---------+-------------------------------------------------------+-------------------------------------------+*/
/*|	MON		|	Case-sensitive Tree-letter abbreviation of month	|	JUN										|*/
/*+---------+-------------------------------------------------------+-------------------------------------------+*/
/*|	MONTH	|	Case-sensitive English spelling of month. 			|	DECEMBER								|*/
/*|			|	Ads blank space after spelled day.					|											|*/
/*+---------+-------------------------------------------------------+-------------------------------------------+*/
/*|	D		|	Day of the week										|	5										|*/
/*+---------+-------------------------------------------------------+-------------------------------------------+*/
/*|	DD		|	Two-digit day of month								|	31										|*/
/*+---------+-------------------------------------------------------+-------------------------------------------+*/
/*|	DDD		|	Day of the year										|	153										|*/
/*+---------+-------------------------------------------------------+-------------------------------------------+*/
/*|	DY		|	Case-sensitive Three-letter abbreviation of day		|	THU										|*/
/*+---------+-------------------------------------------------------+-------------------------------------------+*/
/*|	DAY		|	Case-sensitive English spelling of day.				|	THURSDAY								|*/
/*|			|	Ads blank space after spelled day.					|											|*/
/*+---------+-------------------------------------------------------+-------------------------------------------+*/
/*|	SP		|	Spelled out number: 'MmSP Month Yyyysqp'			|	Twelve December  Two Thousand Fifteen	|*/
/*+---------+-------------------------------------------------------+-------------------------------------------+*/
/*|	FM		|	Removes extra blacks from the spelled components	|											|*/
/*|			|	Also removes extra '0' from number components		|											|*/
/*+---------+-------------------------------------------------------+-------------------------------------------+*/
/*|	TH		|	Positional or ordinal text: 'DDth "of" Month'		|	31ST of December						|*/
/*+---------+-------------------------------------------------------+-------------------------------------------+*/



/*+---------------------------------------------------------------------------------+*/
/*|									Date Format Masks		 	                    |*/
/*+-------------------------+-------------------------------------------+-----------+*/
/*|	Element					|	Description								|	Result	|*/
/*+-------------------------+-------------------------------------------+-----------+*/
/*|	AM, PM, A.M. and P.M	|	Meridian indicators						|	PM		|*/
/*+-------------------------+-------------------------------------------+-----------+*/
/*|	HH, HH12 and HH24		|	Hours of day, 1-12 hours, and 1-23hours	|	03		|*/
/*+-------------------------+-------------------------------------------+-----------+*/
/*|	MI						|	Minute (0-59)							|	55		|*/
/*+-------------------------+-------------------------------------------+-----------+*/
/*|	SS						|	Seconds(0-59)							|	56		|*/
/*+-------------------------+-------------------------------------------+-----------+*/
/*|	SSSSS					|	Seconds past midnight (0-86399)			|	(57453)	|*/
/*+-------------------------+-------------------------------------------+-----------+*/