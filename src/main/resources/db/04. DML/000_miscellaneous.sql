-- 1. FROM
-- 2. ON
-- 3. JOIN -> Table aliases are visible below
-- 4. WHERE
-- 5. GROUP BY
-- 6. WITH CUBE or WITH ROLLUP
-- 7. HAVING
-- 8. SELECT  ----> Aliases defined here are only visible in order by, you cannot refer to aliases above.
-- 9. DISTINCT
-- 10. ORDER BY
-- 11. TOP

SELECT dummy as column1
FROM DUAL
ORDER BY column1;

SELECT dummy as column1
FROM DUAL
WHERE column1 like '%X%'
ORDER BY column1;

--------------------------------------------------------------
CREATE TABLE escape_example (
    text VARCHAR2(100)
);

INSERT INTO escape_example VALUES ('%HELLO');
INSERT INTO escape_example VALUES ('%HELLO-WORLD');
INSERT INTO escape_example VALUES ('prefix-HELLO');

SELECT *
FROM escape_example
WHERE text LIKE '%HELLO';

SELECT *
FROM escape_example
WHERE text LIKE '/%HELLO%' ESCAPE '/';

-----------------------------------------------------------------
---- QUOTE OPERATOR

SELECT 'prefix' || ' suffix''' as concatenated FROM dual;
SELECT 'prefix' || q'[ suffix''']' as concatenated FROM dual;
SELECT 'prefix' || q'( suffix''')' as concatenated FROM dual;
SELECT 'prefix' || q'< suffix >' as concatenated FROM dual;
SELECT 'prefix' || q'$ suffix $' as concatenated FROM dual;
