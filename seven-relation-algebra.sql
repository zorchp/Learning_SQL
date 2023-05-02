show databases;
create database test2;
use test2;

Create table If Not Exists R
(
    a_id varchar(2),
    b_id int
);
Truncate table R;
insert into R (a_id, b_id)
values ('a1', 101);
insert into R (a_id, b_id)
values ('a2', 102);
insert into R (a_id, b_id)
values ('a2', 103);
insert into R (a_id, b_id)
values ('a3', 104);

select *
FROM R;
/*
a_id,b_id
a1,101
a2,102
a2,103
a3,104
*/

-- Select
SELECT *
FROM R
WHERE a_id = 'a2'
  AND b_id > 102;
/*
a_id,b_id
a2,103
*/

-- Projection
SELECT b_id - 100, a_id
FROM R
WHERE a_id = 'a2';
/*
b_id - 100,a_id
2,a2
3,a2
*/


DROP TABLE R;
Create table If Not Exists R
(
    a_id varchar(2),
    b_id int
);
Truncate table R;
insert into R (a_id, b_id)
values ('a1', 101);
insert into R (a_id, b_id)
values ('a2', 102);
insert into R (a_id, b_id)
values ('a3', 103);

Create table If Not Exists S
(
    a_id varchar(2),
    b_id int
);
Truncate table S;
insert into S (a_id, b_id)
values ('a3', 103);
insert into S (a_id, b_id)
values ('a4', 104);
insert into S (a_id, b_id)
values ('a5', 105);


    (SELECT * FROM R)
    UNION ALL
    (SELECT * FROM S);
/*
a_id,b_id
a1,101
a2,102
a3,103
a3,103
a4,104
a5,105
*/



#     (SELECT * FROM R)
#     INTERSECT (SELECT * FROM S);
-- MySQL do not support INTERSECT

SELECT *
FROM R
WHERE R.a_id IN (SELECT a_id FROM S);
/*
a_id,b_id
a3,103
*/

-- Difference

# (SELECT * FROM R) EXCEPT (SELECT * FROM S);

SELECT *
FROM R
WHERE a_id NOT IN (SELECT a_id FROM S);
/*
a_id,b_id
a1,101
a2,102
*/

-- 下面这种写法后面除法会用到
SELECT *
FROM R
WHERE NOT EXISTS (#
    SELECT a_id
    FROM S
    WHERE R.a_id = S.a_id);

/*
a_id,b_id
a1,101
a2,102
*/



-- Product

SELECT * FROM R, S;
/*
a_id,b_id,a_id,b_id
a3,103,a3,103
a2,102,a3,103
a1,101,a3,103
a3,103,a4,104
a2,102,a4,104
a1,101,a4,104
a3,103,a5,105
a2,102,a5,105
a1,101,a5,105
*/

SELECT * FROM R CROSS JOIN S;
/*
a_id,b_id,a_id,b_id
a3,103,a3,103
a2,102,a3,103
a1,101,a3,103
a3,103,a4,104
a2,102,a4,104
a1,101,a4,104
a3,103,a5,105
a2,102,a5,105
a1,101,a5,105
*/


-- Join
SELECT * FROM R NATURAL JOIN S;
/*
a_id,b_id
a3,103
*/

SELECT * FROM R JOIN S USING (a_id, b_id);
/*
a_id,b_id
a3,103
*/




-- test data
Create table If Not Exists Completed
(
    Student varchar(10),
    Task    varchar(10)
);
Truncate table Completed;
insert into Completed (Student, Task)
values ('Fred', 'Database1');
insert into Completed (Student, Task)
values ('Fred', 'Database2');
insert into Completed (Student, Task)
values ('Fred', 'Compiler1');
insert into Completed (Student, Task)
values ('Eugene', 'Database1');
insert into Completed (Student, Task)
values ('Eugene', 'Compiler1');
insert into Completed (Student, Task)
values ('Sara', 'Database1');
insert into Completed (Student, Task)
values ('Sara', 'Database2');

SELECT *
FROM Completed;
/*
Student,Task
Fred,Database1
Fred,Database2
Fred,Compiler1
Eugene,Database1
Eugene,Compiler1
Sara,Database1
Sara,Database2
*/

Create table If Not Exists DBProject
(
    Task varchar(10)
);
insert into DBProject (Task)
values ('Database1');
insert into DBProject (Task)
values ('Database2');

SELECT *
FROM DBProject;
/*
Task
Database1
Database2
*/

-- Division
-- 有点像: https://leetcode.cn/problems/students-and-examinations/
-- 如果“DB项目”包含数据库项目的所有任务，则这个除法的结果精确的包含已经完成了数据库项目的所有学生。



-- 方法 1, 存临时表: 笛卡尔积, 方便后续操作
/*
SELECT DISTINCT Student
FROM (SELECT Student
      FROM Completed,
           DBProject) AS tmp
WHERE NOT EXISTS(#
    SELECT *
    FROM Completed
    WHERE tmp.Student = Student
      AND tmp.Task = Task) # 由于这里笛卡尔积之后键有二义性, 所以不能直接使用
    );
*/
DROP TEMPORARY TABLE IF EXISTS tmp;
DROP TEMPORARY TABLE IF EXISTS tmp1;
CREATE TEMPORARY TABLE tmp1(#
    SELECT DISTINCT Student
    FROM Completed);
CREATE TEMPORARY TABLE tmp(#
    SELECT *
    FROM tmp1,
         DBProject);


SELECT Student
FROM tmp
WHERE NOT EXISTS(#
    SELECT *
    FROM Completed c
    WHERE tmp.Student = c.Student
      AND tmp.Task = c.Task);


SELECT DISTINCT Student
FROM Completed c
WHERE NOT EXISTS(#
    SELECT *
    FROM (SELECT *
          FROM tmp
          WHERE NOT EXISTS(#
              SELECT *
              FROM Completed c
              WHERE tmp.Student = Student
                AND tmp.Task = Task)) t # 这就是上一步的结果
    WHERE c.Student = t.Student);
/*
Student
Fred
Sara
*/


-- 方法 2, 不额外存笛卡尔积, 比较巧妙, 建议先理解一下方法 1
-- c ÷ d
SELECT DISTINCT c.Student
FROM Completed c
WHERE NOT EXISTS( #
    SELECT *
    FROM DBProject d
    WHERE NOT EXISTS( #
        SELECT *
        FROM Completed c1
        WHERE c.Student = c1.Student
          AND d.Task = c1.Task));
/*
Student
Fred
Sara
*/