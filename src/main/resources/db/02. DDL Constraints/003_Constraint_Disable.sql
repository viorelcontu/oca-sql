SELECT table_name, constraint_name, constraint_type, status, deferrable, deferred, validated
FROM user_constraints
WHERE table_name = 'STUDENTS';

DROP TABLE groups;
DROP TABLE students;

CREATE TABLE students
(
    id       NUMBER(6)
        CONSTRAINT pk_students PRIMARY KEY,
    login    VARCHAR2(32)
        CONSTRAINT nn_students_login NOT NULL
        CONSTRAINT uq_students_login UNIQUE
        CONSTRAINT ck_students_login CHECK (LENGTH(login) >= 5)
);

--Constraint: ENABLED [VALIDATE]
--ON for insertions and updates
--ON for existing table data
INSERT INTO students (id, login) VALUES (1, NULL);
INSERT INTO students (id, login) VALUES (1, '123');

-----------------------------------------------------------

--Constraint: DISABLED [NOVALIDATE]
--OFF for insertions and updates
--OFF for existing table data
ALTER TABLE students MODIFY CONSTRAINT nn_students_login DISABLE;
INSERT INTO students (id, login) VALUES (1, NULL);

ALTER TABLE students MODIFY CONSTRAINT ck_students_login DISABLE;
INSERT INTO students (id, login) VALUES (2, '123');

-- DISABLING a PRIMARY KEY or UNIQUE constraints removes the unique index.
ALTER TABLE students MODIFY UNIQUE (login) DISABLE NOVALIDATE;
ALTER TABLE students MODIFY PRIMARY KEY DISABLE NOVALIDATE;

SELECT constraint_name, status, deferrable, deferred, validated
FROM user_constraints
WHERE table_name = 'STUDENTS' and constraint_type = 'C';




--Do not confuse with removing the NOT NULL constraint all together
ALTER TABLE students MODIFY login null;
ALTER TABLE students DROP PRIMARY KEY;
ALTER TABLE students DROP UNIQUE (login);



---------------------------------------------------------------------
--Constraint: ENABLED NOVALIDATE
--ON for insertions and updates
--OFF for existing table data
SELECT *
FROM students;

ALTER TABLE students MODIFY CONSTRAINT ck_students_login ENABLE; --will fail, we already have data inside
ALTER TABLE students MODIFY CONSTRAINT ck_students_login ENABLE VALIDATE; --will fail, we already have data inside

ALTER TABLE students MODIFY CONSTRAINT ck_students_login ENABLE NOVALIDATE;
ALTER TABLE students MODIFY CONSTRAINT nn_students_login ENABLE NOVALIDATE;
INSERT INTO students(id, login) VALUES (3, '123'); --will fail
INSERT INTO students(id, login) VALUES (3, null); --will fail

INSERT INTO students(id, login) VALUES (3, 'johndoe'); -- OK: not null, and length(login) >=5

-----------------------------------------------------------------------------------

--Constraint: DISABLED VALIDATE
--TABLE IS READ ONLY
SELECT table_name, constraint_name, constraint_type, status, deferrable, deferred, validated
FROM user_constraints
WHERE table_name = 'STUDENTS';

SELECT *
FROM students;




