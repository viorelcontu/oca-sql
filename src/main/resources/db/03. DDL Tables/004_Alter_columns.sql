--ALTER COLUMN DATA TYPE RULES
-- ALTER TABLE MODIFY -> can change column datatype only if it is empty or contains nulls only.

CREATE TABLE empty_table
(
    id   NUMBER(6),
    text VARCHAR2(100)
);

ALTER TABLE empty_table
    MODIFY id VARCHAR2(100);

SELECT *
FROM user_tab_columns
WHERE table_name = 'EMPTY_TABLE';

-------------------------------------------------------------------------------------
--cannot modify data type on non emty

CREATE TABLE non_empty_table
(
    id   NUMBER(6),
    text VARCHAR2(100)
);

INSERT INTO non_empty_table
VALUES (1, 'text');

--table should not be empty!!
ALTER TABLE non_empty_table
    MODIFY id VARCHAR2(100);

SELECT *
FROM user_tab_columns
WHERE table_name = 'NON_EMPTY_TABLE';

DROP TABLE non_empty_table;

---------------------------------------------------------------------------
--changing precision is ok as long as it does not violate existing data

CREATE TABLE non_empty_table
(
    id   NUMBER(6),
    text VARCHAR2(100)
);

INSERT INTO non_empty_table
VALUES (1, 'text');

--table should not be empty!!
ALTER TABLE non_empty_table
    MODIFY text VARCHAR2(4);

SELECT *
FROM user_tab_columns
WHERE table_name = 'NON_EMPTY_TABLE';


-- You can ALTER table <tablename> MODIFY, not null constaint only if there are no rows at all, otherwise you need to add a default value
-------------------------------------------------------------------------------------
--VISIBLE INVISIBLE

CREATE TABLE table_with_invisibles
(
    id   NUMBER(6),
    text VARCHAR2(100) INVISIBLE
);

INSERT INTO table_with_invisibles
VALUES (1, 'text'); --TOO MANY values! invisible columns are not included!!!
INSERT INTO table_with_invisibles
VALUES (2);
INSERT INTO table_with_invisibles(id, text)
VALUES (3, 'explicit text');

SELECT *
FROM table_with_invisibles;

SELECT id, text
FROM table_with_invisibles;

ALTER TABLE table_with_invisibles
    MODIFY text VISIBLE;

SELECT *
FROM table_with_invisibles;

DROP TABLE table_with_invisibles;


--------------------------------------------------------------------------------------
-- SET UNUSED

CREATE TABLE table_with_unused
(
    id   NUMBER(6),
    text VARCHAR2(100)
);

--there is no returning back! it is faster than drop column!!
ALTER TABLE table_with_unused
    SET UNUSED COLUMN text;

alter table table_with_unused drop UNUSED COLUMNS;
