SELECT table_name, constraint_name, constraint_type, status, deferrable, deferred, validated
FROM user_constraints
WHERE table_name = 'STUDENTS';

DROP TABLE students;
DROP TABLE groups CASCADE CONSTRAINTS ;

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
INSERT INTO students (id, login) VALUES (1, NULL); -- constraint violation
INSERT INTO students (id, login) VALUES (1, '123'); -- constraint violation

-----------------------------------------------------------

--Constraint: DISABLED [NOVALIDATE]
--OFF for insertions and updates
--OFF for existing table data
--works both on ALTER TABLE and CREATE TABLE

ALTER TABLE students MODIFY CONSTRAINT nn_students_login DISABLE;
--similar result as above:
ALTER TABLE students DISABLE CONSTRAINT nn_students_login;

INSERT INTO students (id, login) VALUES (1, NULL); --now we can insert null values, constraint is disabled

ALTER TABLE students MODIFY CONSTRAINT ck_students_login DISABLE;
INSERT INTO students (id, login) VALUES (2, '123'); --CHECK constraint disabled, we can insert values LENGTH(login) < 5

-- DISABLING a PRIMARY KEY or UNIQUE constraints removes the unique index.
ALTER TABLE students MODIFY UNIQUE (login) DISABLE NOVALIDATE; --NOVALIDATE can be omitted, it is implicit for DISABLE
ALTER TABLE students MODIFY PRIMARY KEY DISABLE;
ALTER TABLE students DISABLE PRIMARY KEY CASCADE; -- will also disable all FK that point to this PK

--Enabling them again:
ALTER TABLE students ENABLE PRIMARY KEY;
ALTER TABLE students MODIFY UNIQUE (login) ENABLE VALIDATE; --VALIDATE can be omitted, it is implicit for ENABLE


SELECT constraint_name, status, deferrable, deferred, validated
FROM user_constraints
WHERE table_name = 'STUDENTS' and constraint_type = 'C';

--------------------------------------------------------------------
--Constraint: ENABLED NOVALIDATE
--ON for insertions and updates
--OFF for existing table data
SELECT *
FROM students;

ALTER TABLE students MODIFY CONSTRAINT ck_students_login ENABLE; --will fail, we already have data inside
ALTER TABLE students MODIFY CONSTRAINT ck_students_login ENABLE VALIDATE; --will fail, we already have data inside

ALTER TABLE students MODIFY CONSTRAINT ck_students_login ENABLE NOVALIDATE; --OK. No inserting bad data, old data remains
ALTER TABLE students MODIFY CONSTRAINT nn_students_login ENABLE NOVALIDATE; --OK
INSERT INTO students(id, login) VALUES (3, 'abc'); --will fail. CHECK LENGTH(login) >= 5
INSERT INTO students(id, login) VALUES (3, null); --will fail

INSERT INTO students(id, login) VALUES (5, 'johndoe'); -- OK: not null, and length(login) >=5

-----------------------------------------------------------------------------------

--Constraint: DISABLED VALIDATE
--TABLE IS READ ONLY (i know, it is a bit counter intuitive, but this is how it works)
--https://oracle4newbies.wordpress.com/2009/10/14/disable-validate/

-- DISABLE VALIDATE disables the constraint and drops the index on the
-- constraint, yet keeps the constraint valid. This clause is most useful
-- for unique constraints. This option disallows all DML on the table(meaning
-- the table becomes read only), but guarantees the validity of existing data.

-- One benefit from the DISABLE VALIDATE constraint state is that it saves
-- space because it requires no index on a unique or primary key, yet it guarantees
-- the validity of all existing data in the table.

SELECT table_name, constraint_name, constraint_type, status, deferrable, deferred, validated
FROM user_constraints
WHERE table_name = 'STUDENTS';

SELECT * FROM students;

ALTER TABLE students MODIFY CONSTRAINT nn_students_login ENABLE VALIDATE; --not possible we have bad data inside
ALTER TABLE students MODIFY CONSTRAINT nn_students_login DISABLE VALIDATE; --same as above

DELETE FROM students WHERE login is null;
SELECT * FROM students;

ALTER TABLE students MODIFY CONSTRAINT nn_students_login DISABLE VALIDATE; --you cannot change ANYTHING in the table

UPDATE students set
 id =  100
where length(login) <5; -- FAIL. No insert/update/delete on table with constraint


------------------------------------------------------------------------------
-- By default, Oracle will attempt to create a Unique Index to police a PK or UK constraint
-- Disabling constraints for PK and UNIQUE drops unique-indexes
-- A NOVALIDATE constraint requires a Non-Unique Index for the constraint to really be “Novalidated”



---------------------------------------------------------------------------------
--Removing Constraints:
--Do not confuse constraint disabling with removing them completely
ALTER TABLE students MODIFY login null; -- Null is the opposite of not null :)
ALTER TABLE students DROP PRIMARY KEY; -- There is only one primary key
ALTER TABLE students DROP UNIQUE (login); --
