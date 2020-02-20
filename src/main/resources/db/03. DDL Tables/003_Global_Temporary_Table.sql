-- Data in a temporary table is private to the session
DROP TABLE groups CASCADE CONSTRAINTS;
DROP TABLE students CASCADE CONSTRAINTS;

CREATE GLOBAL TEMPORARY TABLE students
(
    student_id NUMBER(6) PRIMARY KEY,
    login      VARCHAR2(32) NOT NULL
) ON COMMIT DELETE ROWS;

INSERT INTO students (student_id, login) VALUES (1, 'bill');
INSERT INTO students (student_id, login) VALUES (2, 'joe');

SELECT *
FROM students;

COMMIT;

--rows are gone after commit
SELECT *
FROM students;
-----------------------------------------

CREATE GLOBAL TEMPORARY TABLE persons
(
    person_id NUMBER(6) PRIMARY KEY,
    login      VARCHAR2(32) NOT NULL
) ON COMMIT PRESERVE ROWS;

INSERT INTO persons (person_id, login) VALUES (1, 'bill');
INSERT INTO persons (person_id, login) VALUES (2, 'joe');

SELECT *
FROM persons;

COMMIT;

--Rows are still present and will remain until end of session
--STILL NOT VISIBLE FROM OTHER SESSIONS!!!
SELECT *
FROM persons;


------------------------------------------
--combining global temporary table with create from select;

CREATE TABLE info_source
(
    student_id NUMBER(6) PRIMARY KEY,
    login      VARCHAR2(32) NOT NULL
);

INSERT INTO info_source (student_id, login) VALUES (1, 'bill');
INSERT INTO info_source (student_id, login) VALUES (2, 'joe');

COMMIT;

SELECT *
FROM info_source;

drop TABLE consumer_source;

CREATE GLOBAL TEMPORARY TABLE consumer_source
ON COMMIT preserve rows
as (SELECT * from info_source);

SELECT *
FROM consumer_source;
