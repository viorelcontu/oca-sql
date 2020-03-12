-- We will run all the scripts on DUAL
SELECT *
FROM dual;

--We do not have boolean type in Oracle
--We cannot assign the boolean result of an operator to the output of query
SELECT 1 < 999 AS first_is_greater
FROM dual;
--fail

--CASE WHEN ELSE END COMMAND
--CASE statement can work like an multiple if statement

SELECT CASE WHEN 1 < 999 THEN 'true' END AS first_is_greater
FROM dual;

SELECT CASE WHEN 1 >= 999 THEN 'true' END AS first_is_greater
FROM dual;

SELECT CASE WHEN 1 < 999 THEN 'true' ELSE 'false' END AS first_is_greater
FROM dual;

SELECT CASE WHEN 1 >= 999 THEN 'true' ELSE 'false' END AS first_is_greater
FROM dual;

--Multiple "if" statements
SELECT CASE
           WHEN 1 > 999 THEN 'first if is true'
           WHEN 1 < 999 THEN 'second if is true'
           END AS result
FROM dual;

--ELSE statement, when every WHEN statement is false
SELECT CASE
           WHEN 1 > 999 THEN 'first if is true'
           WHEN 1 = 999 THEN 'second if is true'
           ELSE 'none of them are true'
           END AS result
FROM dual;

--input data
CREATE TABLE testing
(
    id NUMBER(10) GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    letter CHAR (1)
);

INSERT INTO testing (letter) VALUES ('a');
INSERT INTO testing (letter) VALUES ('b');
INSERT INTO testing (letter) VALUES ('c');

--CASE can work as SWITCH statement (similar to java)
SELECT letter,
       CASE letter
           WHEN 'a' THEN 'found letter A'
           WHEN 'b' THEN 'found letter B'
           ELSE 'found different letter'
           END AS result
FROM testing;

--alternative to the "SWITCH case"
SELECT letter,
       decode(letter, 'a', 'found letter A', 'b', 'found letter B', 'found different letter') AS result
FROM testing;