show databases;

create database Medium;

use Medium;


-- 180
Create table If Not Exists Logs
(
    id  int,
    num int
);
Truncate table Logs;
insert into Logs (id, num)
values ('1', '1');
insert into Logs (id, num)
values ('2', '1');
insert into Logs (id, num)
values ('3', '1');
insert into Logs (id, num)
values ('4', '2');
insert into Logs (id, num)
values ('5', '1');
insert into Logs (id, num)
values ('6', '2');
insert into Logs (id, num)
values ('7', '2');


SELECT DISTINCT l1.num ConsecutiveNums
FROM Logs l1
         CROSS JOIN Logs l2
         CROSS JOIN Logs l3
WHERE l1.num = l2.num
  AND l2.num = l3.num
  AND l1.id = l2.id - 1
  AND l2.id = l3.id - 1;


-- 泛化版本
SELECT DISTINCT Num ConsecutiveNums
FROM (SELECT Id,
             Num,
             ROW_NUMBER() OVER (ORDER BY Id) -
             ROW_NUMBER() OVER (PARTITION BY Num ORDER BY Id) AS tmp
      FROM Logs) Sub
GROUP BY Num, tmp
HAVING COUNT(1) >= 3;
