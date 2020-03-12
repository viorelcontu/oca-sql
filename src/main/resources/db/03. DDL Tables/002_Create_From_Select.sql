DROP TABLE groups CASCADE CONSTRAINTS;
DROP TABLE students CASCADE CONSTRAINTS;

CREATE TABLE groups
(
    group_id NUMBER(6) PRIMARY KEY
);

CREATE TABLE students
(
    student_id NUMBER(6),
    login      VARCHAR2(32) CONSTRAINT nn_students_login NOT NULL,
    group_id   NUMBER(6),
    CONSTRAINT pk_students PRIMARY KEY (student_id),
    CONSTRAINT fk_students_group_id FOREIGN KEY (group_id) REFERENCES groups,
    CONSTRAINT uq_students_login UNIQUE (login),
    CONSTRAINT ck_students_login CHECK (LENGTH(login) >= 5)
);


INSERT into groups VALUES (1);
INSERT INTO students(student_id, login, group_id) VALUES (100, 'important user', 1);
COMMIT;

SELECT * from students;

-------------- create table form subquery
SELECT table_name, constraint_name, constraint_type, status, deferrable, deferred, validated
FROM user_constraints
WHERE table_name = 'STUDENTS';

CREATE TABLE people AS
SELECT *
FROM students;

SELECT *
FROM people;

--  ONLY THE NOT NULL CONSTRAINT HAS BEEN COPIED
SELECT table_name, constraint_name, constraint_type, search_condition, status, deferrable, deferred, validated
FROM user_constraints
WHERE table_name = 'PEOPLE';

CREATE TABLE humans AS
SELECT student_id, login --the columns in the select will define what the table will contain
FROM students;

SELECT *
FROM humans;

-- Global temporary table generated from a subquery.
-- The contents of subquery will be wiped out after session or commit, other sessions will never see it anyways