-- DEFERRABLE CONSTRAINTS
-- you can defer checking constraint validity until after committing the transaction
DROP TABLE students CASCADE CONSTRAINTS;
DROP TABLE groups CASCADE CONSTRAINTS;

CREATE TABLE groups
(
    id          NUMBER(6),
    title       VARCHAR2(32),
    description VARCHAR2(255)
);

CREATE TABLE students
(
    id       NUMBER(6)
        CONSTRAINT pk_students PRIMARY KEY,
    login    VARCHAR2(32)
        CONSTRAINT nn_students_login NOT NULL DEFERRABLE -- implicit [INITIALLY IMMEDIATE]
        CONSTRAINT uq_students_login UNIQUE
        CONSTRAINT ck_students_login CHECK (LENGTH(login) >= 5),
    group_id NUMBER(6)
);

-- A DEFERRABLE constraint can have the following status IMMEDIATE or DEFERRED
ALTER TABLE groups ADD
    CONSTRAINT pk_groups PRIMARY KEY (id) DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE students ADD
    CONSTRAINT fk_students_group_id FOREIGN KEY (group_id) REFERENCES groups(id) ON DELETE CASCADE DEFERRABLE INITIALLY IMMEDIATE  ;

--You cannot change the DEFERRABLE property of a constraint after it's creation!!!
-- You can only change the state of of DEFERRABLE CONSTRAINTS TO either: 1. IMMEDIATE 2. DEFERRED.
SET CONSTRAINT pk_groups IMMEDIATE;
SET CONSTRAINT pk_groups DEFERRED ;

-- Or you can just change all the constraints to either IMMEDIATE or DEFERRED
SET CONSTRAINT ALL IMMEDIATE ;
SET CONSTRAINT ALL DEFERRED;

-- Change constraints status for a session
ALTER SESSION SET CONSTRAINTS = IMMEDIATE;
ALTER SESSION SET CONSTRAINTS = DEFERRED;

---------------------- PRACTICE ----------------------
--this dictionary query ONLY SHOWS how constraints are set initially!! no actual situation!!!
SELECT table_name, constraint_name, constraint_type, status, deferrable, deferred, validated
FROM user_constraints
WHERE table_name in ('STUDENTS', 'GROUPS') AND
      deferrable = 'DEFERRABLE';

ALTER SESSION SET CONSTRAINTS = IMMEDIATE; --after commit, all the constraints deferrable constraints will be reverted to this state
-- Scenario 1: CONSTRAINT IMMEDIATE
SET CONSTRAINTS pk_groups IMMEDIATE;
INSERT INTO groups (id) VALUES (null); -- IMMEDIATE FAIL. Cannot insert a null into a PK field

-- Scenario 2: SESSION IMMEDIATE, CONSTRAINT DEFERRED
SET CONSTRAINT pk_groups DEFERRED;
INSERT INTO groups (id) VALUES (null); -- will fail AFTER commit.
INSERT INTO groups (id) VALUES (1); -- will fail AFTER commit.

SELECT * FROM groups;

COMMIT; --transaction will roll back completely
--------------------------------------------------


--Scenario 3: set a PK and FK in one single transaction regardless of statements order
ALTER SESSION SET CONSTRAINT = DEFERRED;
TRUNCATE TABLE students CASCADE;

INSERT INTO students(id, login, group_id) VALUES (25, 'hello', 1);
INSERT INTO groups(id, title, description) VALUES (1,'Group Nr.1', 'First group ever');

SELECT s.id as student_id, s.login, s.group_id, g.title
FROM students s INNER JOIN groups g ON s.group_id = g.id;

COMMIT;

--Scenario 5: same as scenario 4 but should fail
TRUNCATE TABLE groups CASCADE ;
ALTER SESSION SET CONSTRAINT = IMMEDIATE;

INSERT INTO students(id, login, group_id) VALUES (25, 'hello', 1);
INSERT INTO groups(id, title, description) VALUES (1,'Group Nr.1', 'First group ever');

SELECT s.id as student_id, s.login, s.group_id, g.title
FROM students s INNER JOIN groups g ON s.group_id = g.id;