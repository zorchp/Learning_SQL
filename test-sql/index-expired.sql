show databases;
create database db1;

use db1;

CREATE TABLE TableName
(
    id     INT PRIMARY KEY,
    name   VARCHAR(255),
    addr   VARCHAR(255),
    gender VARCHAR(10)
);

INSERT INTO TableName (id, name, addr, gender)
VALUES (1, 'John', '123 Main Street', 'Male'),
       (2, 'Tom', '234', 'FeMale'),
       (3, 'Paul', '345', 'Male');

# explain
describe
select *
from TableName
where name like '%ohn';
# ALL

# show processlist;

describe
select *
from TableName
where length(gender) = 6; # ALL


describe
select *
from TableName
where id - 1 = 2; # ALL

describe
select *
from TableName
where id = 1 + 2; # const PRIMARY


describe
select *
from TableName
# where id like '2'; # ALL
# where name = 2; # ALL, 本质还是用了函数
where CAST(name AS signed int) = 2;

select '10' > 9; # 说明转换为数字比较了, 而不是转换为字符串

# or 的第二个设为索引, 就会走联合索引了, 不是全表
CREATE INDEX name ON TableName (name);

describe
select *
from TableName
where id <2 or name ='Tom'; # ALL