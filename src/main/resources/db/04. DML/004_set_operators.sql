CREATE TABLE first_table
(
    id   NUMBER(6),
    text CHAR(23)
);

INSERT INTO first_table  VALUES (1, 'first table insert nr 1');
INSERT INTO first_table  VALUES (2, 'first table insert nr 2');


CREATE TABLE second_table
(
    other_id   NUMBER(6),
    other_text VARCHAR2(200)
);

INSERT INTO second_table VALUES (123456, 'second table insert nr 2');

--ONLY the column names form first table matter!
SELECT id, text FROM first_table
UNION
SELECT other_id, other_text FROM second_table
ORDER BY 1, text;

SELECT id, text as information FROM first_table
UNION
SELECT other_id, other_text FROM second_table
ORDER BY 1, information;

--NO IMPLICIT CONVERSION BETWEEN TYPES WITH SET OPERATORS!!!
--EXPRESSION Must have same data type!!!
SELECT text FROM first_table
UNION
SELECT other_id FROM second_table;
