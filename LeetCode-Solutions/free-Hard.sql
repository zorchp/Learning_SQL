SHOW DATABASES;
create database Hard;

use Hard;


-- 185
DROP TABLE IF EXISTS Employee;
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
values ('1', 'Joe', '85000', '1');
insert into Employee (id, name, salary, departmentId)
values ('2', 'Henry', '80000', '2');
insert into Employee (id, name, salary, departmentId)
values ('3', 'Sam', '60000', '2');
insert into Employee (id, name, salary, departmentId)
values ('4', 'Max', '90000', '1');
insert into Employee (id, name, salary, departmentId)
values ('5', 'Janet', '69000', '1');
insert into Employee (id, name, salary, departmentId)
values ('6', 'Randy', '85000', '1');
insert into Employee (id, name, salary, departmentId)
values ('7', 'Will', '70000', '1');
Truncate table Department;
insert into Department (id, name)
values ('1', 'IT');
insert into Department (id, name)
values ('2', 'Sales');

SELECT d.name AS 'Department',
       e.name AS 'Employee',
       e.salary AS 'Salary'
FROM Employee e
         JOIN Department d on d.id = e.departmentId

# GROUP BY d.id
HAVING ROW_NUMBER() over (ORDER BY e.salary DESC)
;

