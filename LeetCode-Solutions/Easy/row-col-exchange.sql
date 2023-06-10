show databases;

create database Easy;

use Easy;

-- 1795: 行显示变成列显示
Create table If Not Exists Products
(
    product_id int,
    store1     int,
    store2     int,
    store3     int
);
Truncate table Products;
insert into Products (product_id, store1, store2, store3)
values ('0', '95', '100', '105');
insert into Products (product_id, store1, store2, store3)
values ('1', '70', null, '80');

-- 需要考虑表查询结果的合并
SELECT p.product_id, 'store1' store, p.store1 price
FROM Products p
WHERE p.store1 IS NOT NULL
UNION
SELECT p.product_id, 'store2' store, p.store2 price
FROM Products p
WHERE p.store2 IS NOT NULL
UNION
SELECT p.product_id, 'store3' store, p.store3 price
FROM Products p
WHERE p.store3 IS NOT NULL;


-- 1179: 列转行
Create table If Not Exists Department
(
    id      int,
    revenue int,
    month   varchar(5)
);
Truncate table Department;
insert into Department (id, revenue, month)
values ('1', '8000', 'Jan');
insert into Department (id, revenue, month)
values ('2', '9000', 'Jan');
insert into Department (id, revenue, month)
values ('3', '10000', 'Feb');
insert into Department (id, revenue, month)
values ('1', '7000', 'Feb');
insert into Department (id, revenue, month)
values ('1', '6000', 'Mar');

SELECT id,
       SUM(CASE month WHEN 'Jan' THEN revenue END) AS Jan_Revenue,
       SUM(CASE month WHEN 'Feb' THEN revenue END) AS Feb_Revenue,
       SUM(CASE month WHEN 'Mar' THEN revenue END) AS Mar_Revenue,
       SUM(CASE month WHEN 'Apr' THEN revenue END) AS Apr_Revenue,
       SUM(CASE month WHEN 'May' THEN revenue END) AS May_Revenue,
       SUM(CASE month WHEN 'Jun' THEN revenue END) AS Jun_Revenue,
       SUM(CASE month WHEN 'Jul' THEN revenue END) AS Jul_Revenue,
       SUM(CASE month WHEN 'Aug' THEN revenue END) AS Aug_Revenue,
       SUM(CASE month WHEN 'Sep' THEN revenue END) AS Sep_Revenue,
       SUM(CASE month WHEN 'Oct' THEN revenue END) AS Oct_Revenue,
       SUM(CASE month WHEN 'Nov' THEN revenue END) AS Nov_Revenue,
       SUM(CASE month WHEN 'Dec' THEN revenue END) AS Dec_Revenue
FROM Department
GROUP BY id;
