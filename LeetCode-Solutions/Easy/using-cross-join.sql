show databases;

use Easy;


-- 1280: 使用叉积合并结果
Create table If Not Exists Students
(
    student_id   int,
    student_name varchar(20)
);
Create table If Not Exists Subjects
(
    subject_name varchar(20)
);
Create table If Not Exists Examinations
(
    student_id   int,
    subject_name varchar(20)
);
Truncate table Students;
insert into Students (student_id, student_name)
values ('1', 'Alice');
insert into Students (student_id, student_name)
values ('2', 'Bob');
insert into Students (student_id, student_name)
values ('13', 'John');
insert into Students (student_id, student_name)
values ('6', 'Alex');
Truncate table Subjects;
insert into Subjects (subject_name)
values ('Math');
insert into Subjects (subject_name)
values ('Physics');
insert into Subjects (subject_name)
values ('Programming');
Truncate table Examinations;
insert into Examinations (student_id, subject_name)
values ('1', 'Math');
insert into Examinations (student_id, subject_name)
values ('1', 'Physics');
insert into Examinations (student_id, subject_name)
values ('1', 'Programming');
insert into Examinations (student_id, subject_name)
values ('2', 'Programming');
insert into Examinations (student_id, subject_name)
values ('1', 'Physics');
insert into Examinations (student_id, subject_name)
values ('1', 'Math');
insert into Examinations (student_id, subject_name)
values ('13', 'Math');
insert into Examinations (student_id, subject_name)
values ('13', 'Programming');
insert into Examinations (student_id, subject_name)
values ('13', 'Physics');
insert into Examinations (student_id, subject_name)
values ('2', 'Math');
insert into Examinations (student_id, subject_name)
values ('1', 'Math');


-- 要求写一段 SQL 语句，查询出每个学生参加每一门科目测试的次数，结果按 student_id 和 subject_name 排序。

SELECT stu.student_id,
       stu.student_name,
       sub.subject_name,
       COUNT(e.subject_name) attended_exams
FROM Subjects sub
         CROSS JOIN Students stu
         LEFT JOIN Examinations e
                   ON stu.student_id = e.student_id
                       AND sub.subject_name = e.subject_name
GROUP BY stu.student_name, stu.student_id, sub.subject_name
ORDER BY stu.student_id, sub.subject_name;
