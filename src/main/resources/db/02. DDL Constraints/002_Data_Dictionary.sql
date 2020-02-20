-- One to Many relationship:
-- Student 1:N Groups
DROP TABLE students;
DROP TABLE groups;

CREATE TABLE groups
(
    id          NUMBER(6),
    title       VARCHAR2(32),
    description VARCHAR2(255),
    PRIMARY KEY (id),
    UNIQUE (title)
);

CREATE TABLE students
(
    id       NUMBER(6)
        CONSTRAINT pk_students PRIMARY KEY,
    login    VARCHAR2(32)
        CONSTRAINT nn_students_login NOT NULL
        CONSTRAINT uq_students_login UNIQUE
        CONSTRAINT ck_students_login CHECK (LENGTH(login) >= 5),
    group_id NUMBER(6)
        CONSTRAINT fk_students_group_id REFERENCES groups (id)
);
-- CHECK constraint: the condition to be satisfied must be either TRUE or unknown
-- (unknown means when expression results in null)

--lets see how these tables are defined in the dictionary
SELECT table_name, temporary, num_rows, external
FROM user_tables;

--these are all the visible tables to the user
SELECT owner, table_name, temporary, num_rows, external
FROM all_tables;

--lets see the columns
SELECT table_name, column_name, data_type, data_length, data_precision, data_scale, nullable
FROM user_tab_columns;

--lets see the constraints
SELECT *
FROM user_constraints
WHERE lower(table_name) IN ('students', 'groups')
ORDER BY table_name, constraint_type;

--Above does not tell us the column name to which the constraint is referring to!!
--you need a different dictionary
SELECT *
FROM user_cons_columns
WHERE lower(table_name) IN ('students', 'groups')
ORDER BY table_name;


--B O N U S
-- find out the REFERENCE for FK in Students
SELECT child.table_name,
       child.constraint_type,
       child.constraint_name,
       child_cols.column_name,
       parent_cols.table_name AS R_TABLE_NAME,
       child.r_constraint_name,
       parent_cols.column_name AS R_COLUMN_NAME
FROM user_constraints child
         INNER JOIN user_cons_columns child_cols ON (child.constraint_name = child_cols.constraint_name)
         INNER JOIN user_cons_columns parent_cols ON (child.r_constraint_name = parent_cols.constraint_name)
WHERE constraint_type = 'R'
ORDER BY table_name, constraint_type;


