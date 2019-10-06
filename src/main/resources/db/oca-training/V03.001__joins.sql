CREATE TABLE alpha (
    id NUMBER(10) PRIMARY KEY ,
    value_A VARCHAR2(10)
);

INSERT INTO alpha(id, value_a) VALUES (1, 'A');
INSERT INTO alpha(id, value_a) VALUES (2, 'AA');
INSERT INTO alpha(id, value_a) VALUES (3, 'AAA');

CREATE TABLE beta (
    id NUMBER(10) PRIMARY KEY,
    value_B VARCHAR2(10)
);

INSERT INTO beta(id, value_b) VALUES (1, 'B');
INSERT INTO beta(id, value_b) VALUES (200, 'BB');
INSERT INTO beta(id, value_b) VALUES (300, 'BBB');

SELECT * from beta;

--Cartesian product
SELECT value_a, value_b from alpha, beta;
SELECT value_a, value_b from alpha cross join beta;

--INNER JOIN
SELECT * from alpha NATURAL JOIN beta;
SELECT id, a.value_a, b.value_b from alpha a inner JOIN beta b using (id);
SELECT * from alpha a, beta b WHERE a.id < b.id;

SELECT a.id, b.id, a.value_a, b.value_b
FROM alpha a INNER JOIN beta b ON a.id = b.id;

SELECT a.value_a, b.value_b
FROM alpha a JOIN beta b ON a.id = b.id; --INNER IS OPTIONAL

--Left JOIN
SELECT a.id aID, b.id bID, a.value_a, b.value_b
FROM alpha a
         LEFT JOIN beta b ON a.id = b.id;

--RIGHT JOIN
SELECT a.id aID, b.id bID, a.value_a, b.value_b
FROM alpha a
         RIGHT JOIN beta b ON a.id = b.id;


--FULL OUTER JOIN
SELECT a.id aID, b.id bID, a.value_a, b.value_b
FROM alpha a
         FULL JOIN beta b ON a.id = b.id;

--NON EQUI-JOINS
CREATE table student_exams (
    exam_id NUMBER(10),
    student_name VARCHAR2(32),
    exam_result number (3),
    PRIMARY KEY (exam_id, student_name)
);

INSERT into student_exams(exam_id, student_name, exam_result) VALUES (1,'John', 95);
INSERT into student_exams(exam_id, student_name, exam_result) VALUES (1,'Billie', 55);
INSERT into student_exams(exam_id, student_name, exam_result) VALUES (1,'Henry', 83);
INSERT into student_exams(exam_id, student_name, exam_result) VALUES (1,'Alex', 87);
INSERT into student_exams(exam_id, student_name, exam_result) VALUES (1,'Loser', -1);

SELECT * from student_exams;

CREATE TABLE grading_system
(
    grading_id    NUMBER(10) PRIMARY KEY,
    grading_score CHAR(1),
    result_min    NUMBER(3),
    result_max    NUMBER(3),
    CHECK (result_min < result_max)
);

INSERT INTO grading_system VALUES (1, 'A', 90, 100);
INSERT INTO grading_system VALUES (2, 'B', 80, 89);
INSERT INTO grading_system VALUES (3, 'C', 70, 79);
INSERT INTO grading_system VALUES (4, 'D', 60, 69);
INSERT INTO grading_system VALUES (5, 'E', 50, 59);
INSERT INTO grading_system VALUES (6, 'F', 0, 49);

select * FROM grading_system;

SELECT student_name, exam_result, grading_score
FROM student_exams s
         INNER JOIN grading_system g ON s.exam_result BETWEEN g.result_min and g.result_max;

SELECT student_name, exam_result, grading_score
FROM student_exams s
         RIGHT JOIN grading_system g ON s.exam_result BETWEEN g.result_min and g.result_max
ORDER BY grading_score;

SELECT student_name, exam_result, grading_score
FROM (student_exams s
         FULL OUTER JOIN grading_system g ON s.exam_result BETWEEN g.result_min and g.result_max)
        LEFT JOIN alpha on
ORDER BY grading_score;

SELECT student_name, exam_result, grading_score
FROM student_exams s
         FULL OUTER JOIN grading_system g ON s.exam_result >= g.result_min and s.exam_result <= g.result_max
ORDER BY grading_score;
------------------------------


SELECT * from alpha;

INSERT INTO alpha VALUES (4,'CCC');

COMMIT;

Savepoint

ROLLBACK;