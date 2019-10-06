SELECT * from all_users;

SELECT *
FROM nls_session_parameters
WHERE parameter = 'NLS_DATE_FORMAT';

CREATE TABLE datetable (
    event DATE
);

INSERT INTO datetable(event) VALUES ('1-APR-2019');
INSERT INTO datetable(event)VALUES ('1-OCT-2019');

SELECT * from datetable;

SELECT * from datetable;

-- TYPE CONVERSION
-- https://docs.oracle.com/cd/B19306_01/server.102/b14200/sql_elements002.htm
-- IMPLICIT TYPE CONVERSION

/*
 CHAR/VARCHAR2 -> DATE/TIMESTAMP
 CHAR/VARCHAR2 -> NUMBER

 NUMBER -> CHAR/VARCHAR2
 DATE -> CHAR/VARCHAR2
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
SELECT 10 + event from datetable; --order does not matter
SELECT 1 + '10' + event from datetable; --it's a date!

SELECT 1 + '5-SEP-2020' from dual; -- not working because by default '5-SEP-2020' is a VARCHAR!
/* it does not know that '5-SEP-2020' is a date, and since we have a number + varchar, it tries to convert it to number
   and we hav no implicit conversion
 */

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


--EXPLICIT type conversion
-- to_char
-- to_date
-- to_number
