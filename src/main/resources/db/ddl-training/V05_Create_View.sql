CREATE VIEW student_group as
    SELECT USER_ID, USER_NAME, FULL_NAME, GROUP_NAME
    FROM students natural join groups;

SELECT * FROM student_group;