use t1;
drop table if exists AccoInfo;
CREATE TABLE `AccoInfo`
(
    `id`      varchar(10) NOT NULL,
    `name`    varchar(10) NOT NULL,
    `balance` int         NOT NULL,
    PRIMARY KEY (`id`)
);

insert into AccoInfo(id, name, balance)
values ('1001', 'hundsun', 100),
       ('1002', 'hundsun', 100);

drop table if exists AccoCurrent_202211;
CREATE TABLE `AccoCurrent_202211`
(
    `id`     varchar(10) NOT NULL,
    `amount` int         NOT NULL,
    `time`   varchar(11) NOT NULL
);

insert into AccoCurrent_202211
values ('1001', 100, '20221101'),
       ('1001', 200, '20221102'),
       ('1002', 100, '20221101'),
       ('1002', 200, '20221102');

drop table if exists AccoCurrent_202212;
CREATE TABLE `AccoCurrent_202212`
(
    `id`     varchar(10) NOT NULL,
    `amount` int         NOT NULL,
    `time`   varchar(11) NOT NULL
);

insert into AccoCurrent_202212
values ('1001', 100, '20221201'),
       ('1001', 200, '20221202'),
       ('1002', 100, '20221201'),
       ('1002', 200, '20221202');

select aa.a + bb.b as `sum(amount)`
from (select sum(amount) as a
      from AccoInfo as info
               join AccoCurrent_202212 as a12 on a12.id = info.id
      group by a12.id
      having a12.id = 1001) aa,
     (select sum(amount) as b
      from AccoInfo as info
               join AccoCurrent_202211 as a11 on a11.id = info.id
      group by a11.id
      having a11.id = 1001) bb;

