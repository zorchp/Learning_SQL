show databases;

create database Medium;

use Medium;


-- 184
DROP TABLE Employee;
Create table If Not Exists Employee
(
    id           int,
    name         varchar(255),
    salary       int,
    departmentId int
);
Create table If Not Exists Department
(
    id   int,
    name varchar(255)
);
Truncate table Employee;
insert into Employee (id, name, salary, departmentId)
values ('1', 'Joe', '70000', '1');
insert into Employee (id, name, salary, departmentId)
values ('2', 'Jim', '90000', '1');
insert into Employee (id, name, salary, departmentId)
values ('3', 'Henry', '80000', '2');
insert into Employee (id, name, salary, departmentId)
values ('4', 'Sam', '60000', '2');
insert into Employee (id, name, salary, departmentId)
values ('5', 'Max', '90000', '1');
Truncate table Department;
insert into Department (id, name)
values ('1', 'IT');
insert into Department (id, name)
values ('2', 'Sales');

SELECT d.name AS 'Department', e.name AS 'Employee', e.salary AS 'Salary'
FROM Employee e
         JOIN Department d ON e.departmentId = d.id
WHERE (e.departmentId, e.salary) IN (SELECT e.departmentId, MAX(e.salary)
                                     FROM Employee e
                                     GROUP BY e.departmentId);


-- 550
Create table If Not Exists Activity
(
    player_id    int,
    device_id    int,
    event_date   date,
    games_played int
);
Truncate table Activity;
insert into Activity (player_id, device_id, event_date, games_played)
values ('1', '2', '2016-03-01', '5');
insert into Activity (player_id, device_id, event_date, games_played)
values ('1', '2', '2016-03-02', '6');
insert into Activity (player_id, device_id, event_date, games_played)
values ('2', '3', '2017-06-25', '1');
insert into Activity (player_id, device_id, event_date, games_played)
values ('3', '1', '2016-03-02', '0');
insert into Activity (player_id, device_id, event_date, games_played)
values ('3', '4', '2018-07-03', '5');

-- 首次登录
SELECT a.player_id pid, MIN(event_date) first
FROM Activity a
GROUP BY a.player_id;

-- 再次登录的用户数量
SELECT ROUND(COUNT(a.player_id) /
             (SELECT COUNT(DISTINCT player_id)
              FROM Activity), 2) AS 'fraction'
FROM Activity a
         JOIN (SELECT a.player_id     pid,
                      MIN(event_date) first
               FROM Activity a
               GROUP BY a.player_id) tmp ON tmp.pid = a.player_id
WHERE DATEDIFF(event_date, first) = 1;


-- using AVG
SELECT ROUND(AVG(a.player_id IS NOT NULL), 2) AS 'fraction'
FROM (SELECT player_id, MIN(event_date) AS login
      FROM Activity
      GROUP BY player_id) tmp
         LEFT JOIN Activity a
                   ON tmp.player_id = a.player_id
                       AND DATEDIFF(a.event_date, tmp.login) = 1;


-- 570
DROP TABLE Employee;
Create table If Not Exists Employee
(
    id         int,
    name       varchar(255),
    department varchar(255),
    managerId  int
);
Truncate table Employee;
insert into Employee (id, name, department, managerId)
values ('101', 'John', 'A', null);
insert into Employee (id, name, department, managerId)
values ('102', 'Dan', 'A', '101');
insert into Employee (id, name, department, managerId)
values ('103', 'James', 'A', '101');
insert into Employee (id, name, department, managerId)
values ('104', 'Amy', 'A', '101');
insert into Employee (id, name, department, managerId)
values ('105', 'Anne', 'A', '101');
insert into Employee (id, name, department, managerId)
values ('106', 'Ron', 'B', '101');

SELECT e.managerId
FROM Employee e
GROUP BY e.managerId
HAVING COUNT(e.managerId) >= 5;

SELECT e.name
FROM (SELECT e.managerId
      FROM Employee e
      GROUP BY e.managerId
      HAVING COUNT(e.managerId) >= 5) tmp
   , Employee e
WHERE e.id = tmp.managerId;


-- 585
Create Table If Not Exists Insurance
(
    pid      int,
    tiv_2015 float,
    tiv_2016 float,
    lat      float,
    lon      float
);
Truncate table Insurance;
insert into Insurance (pid, tiv_2015, tiv_2016, lat, lon)
values ('1', '10', '5', '10', '10');
insert into Insurance (pid, tiv_2015, tiv_2016, lat, lon)
values ('2', '20', '20', '20', '20');
insert into Insurance (pid, tiv_2015, tiv_2016, lat, lon)
values ('3', '10', '30', '20', '20');
insert into Insurance (pid, tiv_2015, tiv_2016, lat, lon)
values ('4', '10', '40', '40', '40');
