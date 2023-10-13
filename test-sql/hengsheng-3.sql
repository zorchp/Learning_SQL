create database t3;
use t3;

CREATE TABLE `cust_info`
(
    `NO`      varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci   DEFAULT NULL COMMENT '客户号',
    `NAME`    varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '姓名',
    `ID`      varchar(18) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci  DEFAULT NULL COMMENT '身份证号',
    `BIRTH`   int                                                           DEFAULT NULL COMMENT '出生年月',
    `COUNTRY` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci  DEFAULT NULL COMMENT '国籍'
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci;

INSERT INTO cust_info (`NO`, NAME, ID, BIRTH, COUNTRY)
VALUES ('001', '张三', '330111XXXXX1', 19900101, '中国');
INSERT INTO cust_info (`NO`, NAME, ID, BIRTH, COUNTRY)
VALUES ('002', '李四', '330111XXXXX2', 20000201, '中国');
INSERT INTO cust_info (`NO`, NAME, ID, BIRTH, COUNTRY)
VALUES ('003', '王五', '330111XXXXX3', 20000301, '中国');
INSERT INTO cust_info (`NO`, NAME, ID, BIRTH, COUNTRY)
VALUES ('004', '赵六', '330111XXXXX4', 19930401, '美国');

CREATE TABLE `cust_assets`
(
    `NO`      varchar(100)   DEFAULT NULL COMMENT '客户号',
    `DEPOSIT` decimal(10, 2) DEFAULT NULL COMMENT '存款金额',
    `CREDIT`  decimal(10, 2) DEFAULT NULL COMMENT '信用卡金额'
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci;

INSERT INTO cust_assets (`NO`, DEPOSIT, CREDIT)
VALUES ('001', 10001.0, -100.0);
INSERT INTO cust_assets (`NO`, DEPOSIT, CREDIT)
VALUES ('002', 1000.0, -2000.0);
INSERT INTO cust_assets (`NO`, DEPOSIT, CREDIT)
VALUES ('003', 0.0, -5000.0);


select a.NO as `客户号`, a.NAME as `姓名`
from cust_info as a
         left join cust_assets b on a.NO = b.NO
where b.DEPOSIT IS NULL;