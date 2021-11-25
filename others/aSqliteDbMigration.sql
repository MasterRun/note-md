-- SQLite
CREATE TABLE COMPANY(
    ID INT PRIMARY KEY NOT NULL,
    NAME TEXT NOT NULL,
    AGE INT NOT NULL,
    ADDRESS CHAR(50),
    SALARY REAL
);
--插入数据
INSERT INTO COMPANY (ID, NAME, AGE, ADDRESS, SALARY)
VALUES (1, 'Paul', 32, 'California', 20000.00);
INSERT INTO COMPANY (ID, NAME, AGE, ADDRESS, SALARY)
VALUES (2, 'Allen', 25, 'Texas', 15000.00);
INSERT INTO COMPANY (ID, NAME, AGE, ADDRESS, SALARY)
VALUES (3, 'Teddy', 23, 'Norway', 20000.00);
INSERT INTO COMPANY (ID, NAME, AGE, ADDRESS, SALARY)
VALUES (4, 'Mark', 25, 'Rich-Mond ', 65000.00);
INSERT INTO COMPANY (ID, NAME, AGE, ADDRESS, SALARY)
VALUES (5, 'David', 27, 'Texas', 85000.00);
INSERT INTO COMPANY (ID, NAME, AGE, ADDRESS, SALARY)
VALUES (6, 'Kim', 22, 'South-Hall', 45000.00);
--查询所有数据
select *
from COMPANY;
-- 删除表
drop table if exists COMPANY_COPY;
drop table if exists COMPANY;
--建表
CREATE TABLE company_copy(
    uuid text PRIMARY KEY NOT NULL,
    ID INT NOT NULL DEFAULT 0,
    NAME TEXT NOT NULL default '',
    AGE INT NOT NULL default 0,
    ADDRESS CHAR(50) DEFAULT '',
    SALARY REAL default 0
);
--select创建新表
CREATE TABLE company_copy AS
SELECT hex(randomblob(16)) uuid,
    '' newC,
    COMPANY.*
from COMPANY;
-- 插入表数据
insert into company_copy(uuid, id, name, age, address, salary)
select hex(randomblob(16)),
    *
from COMPANY;
--查询新表数据
select *
from COMPANY_COPY;
--原表添加uuid
ALTER TABLE company
ADD column uuid TEXT NOT NULL default '';
--删除列 uuid
alter table COMPANY drop COLUMN uuid;
-- uuid插入原表
select *
from COMPANY_COPY;
-- 更新原表的uuid字段
update company as c
set uuid = (
        select uuid
        from COMPANY_COPY cc
        where c.id = cc.id
    );