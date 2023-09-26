show databases;

use test1;

Create table If Not Exists person
(
    id   int not null auto_increment,
    name varchar(5),
    PRIMARY KEY (id)
);
Truncate table person;
insert into person (name)
values ('Dong');
insert into person (name)
values ('Ming');

# select * from person;


Create table If Not Exists task
(
    id        int not null auto_increment,
    person_id int,
    content   varchar(15),
    PRIMARY KEY (id)
);
Truncate table task;
insert into task (person_id, content)
values (2, 't1 works well');
insert into task (person_id, content)
values (2, 't2 works well');


select p.id, p.name, t.content
FROM person as p
         left join task as t on p.id = t.person_id
order by p.id desc;