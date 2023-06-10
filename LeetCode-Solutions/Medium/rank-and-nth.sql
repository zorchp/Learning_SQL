show databases;

create database Medium;

use Medium;

-- 176
Create table
    If Not Exists Employee
(
    id     int,
    salary int
);

Truncate table Employee;
insert into Employee (id, salary)
values ('1', '100');
insert into Employee (id, salary)
values ('2', '200');
insert into Employee (id, salary)
values ('3', '300');
-- 编写一个 SQL 查询，获取并返回 Employee 表中第二高的薪水 。如果不存在第二高的薪水，查询应该返回 null 。
-- 关键是对 null 的处理

SELECT ifnull((SELECT DISTINCT salary
               FROM Employee
               ORDER BY salary DESC
               LIMIT 1 OFFSET 1), null)
           AS "SecondHighestSalary";

-- 直接找最大值的最大值, 但是不具有普适性
SELECT MAX(salary) as 'SecondHighestSalary'
FROM Employee
WHERE salary < (SELECT MAX(salary)
                FROM Employee);


-- 简化版:
select (select distinct salary
        from Employee
        order by salary desc
        limit 1 offset 1) as 'SecondHighestSalary';


-- 177
CREATE FUNCTION getNthHighestSalary(N INT) RETURNS INT
    DETERMINISTIC
BEGIN
    SET N := N - 1;
    RETURN (
        # Write your MySQL query statement below.
        SELECT DISTINCT salary
        FROM Employee
        ORDER BY salary DESC
        LIMIT 1 OFFSET N);
END;
# SELECT getNthHighestSalary(2);
-- 通解
CREATE FUNCTION getNthHighestSalary(N INT) RETURNS INT
BEGIN
    RETURN (SELECT DISTINCT e.salary
            FROM Employee e
            WHERE (SELECT COUNT(DISTINCT salary)
                   FROM Employee
                   WHERE salary > e.salary) = N - 1);
END;

-- 最优解法, 找最小, 以及个数(用于判断 null)
CREATE FUNCTION getNthHighestSalary(N INT) RETURNS INT
BEGIN
    RETURN (SELECT IF(cnt < N, null, mini)
            FROM (SELECT MIN(salary) mini, COUNT(*) cnt
                  FROM (SELECT DISTINCT salary
                        FROM Employee
                        ORDER BY salary DESC
                        LIMIT N) a) b);
END;


-- 178
Create table If Not Exists Scores
(
    id    int,
    score DECIMAL(3, 2)
);
Truncate table Scores;
insert into Scores (id, score)
values ('1', '3.5');
insert into Scores (id, score)
values ('2', '3.65');
insert into Scores (id, score)
values ('3', '4.0');
insert into Scores (id, score)
values ('4', '3.85');
insert into Scores (id, score)
values ('5', '4.0');
insert into Scores (id, score)
values ('6', '3.65');

-- 不连续排名
SELECT score, `rank`
FROM (SELECT score,
             @curRank := IF(@prevRank = score, @curRank, @incRank) AS `rank`,
             @incRank := @incRank + 1,
             @prevRank := score
      FROM Scores p,
           (SELECT @curRank := 0, @prevRank := NULL, @incRank := 1) r
      ORDER BY score DESC) s;

SELECT a.score,
       (SELECT COUNT(DISTINCT b.score)
        FROM Scores b
        WHERE b.score >= a.score) AS 'rank'
FROM Scores a
ORDER BY score DESC;
