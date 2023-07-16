show databases;
use test1;


CREATE TABLE A
(
    id            int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
    name          varchar(50)      NOT NULL DEFAULT '',
    user_id       int(11) unsigned NOT NULL,
    user_group_id int(11) unsigned NOT NULL,
    primary key (id),            # 主键索引
    key idx_ugid (user_group_id) # 普通索引, 索引名称为 idx_ugid
)
    ENGINE = InnoDB
    DEFAULT CHARSET = utf8;

# 普通索引：使用 KEY 关键字创建的索引，支持对字段进行查询。
# 唯一索引：使用 UNIQUE KEY 关键字创建的索引，确保字段值唯一。
# 主键索引：使用 PRIMARY KEY 关键字创建的唯一索引，用于标识表中的唯一记录。
# 全文索引：创建全文索引，用于全文搜索。
# 外键索引：在连接多个表时使用，确保引用外部表的数据的正确性。


# all: 全表扫描, 即不走索引
# index: 按索引顺序全表扫描
# range:有范围的索引扫描，相对于index的全索引扫描，它有范围限制，因此要优于index
# ref: 使用索引, 查找条件列使用了索引而且不为主键和unique
# all > index > range > ref > eq_ref > const

explain
SELECT *
FROM A
WHERE user_group_id NOT IN (1, 2, 3); # range, 使用了范围的索引

explain
SELECT *
FROM A
WHERE user_id != 3; # all, 不是 KEY 列, 未用到索引

explain
SELECT *
FROM A
WHERE name LIKE '%xxx'; #all, 索引失效的经典情况, 左匹配通配符

explain
SELECT *
FROM A
WHERE user_group_id = 123; #ref, 使用了索引

SELECT '10' > 9; # 1, 说明字符串转换成了数字进行比较