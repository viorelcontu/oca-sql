--imagine add as a command to add a new line in definition of a table
--you can add either an entire new column with in-line constraints
--or just a new contraint for one of the existing already columns
ALTER TABLE students ADD new_column VARCHAR2(100);

ALTER TABLE students DROP COLUMN new_column;

ALTER TABLE students ADD CHECK (LENGTH(new_column) > 1);

--you need to learn the automatic name of the constaint first
ALTER TABLE students drop constraint SYS_C007603;

ALTER TABLE students ADD
    CONSTRAINT new_column_length_check CHECK (LENGTH(new_column) > 1);

ALTER TABLE students DROP CONSTRAINT new_column_length_check;

ALTER TABLE students
    ADD CONSTRAINT group_id_foreign_key foreign key (group_id) references groups(group_id);

--an example of data dictionary
--we need to find the name of the constraint for foreign key in student table

SELECT * from user_constraints WHERE table_name = 'STUDENTS' AND constraint_type = 'R';