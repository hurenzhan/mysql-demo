# 事务概述
-- 事务是一个不可分割的工作单位，会把所有操作作为一个"整体"一起向系统"提交"或"撤销"操作请求，即要么全部成功，要么同时失败
-- mysql 默认自动提交事务，当执行一条 DML 语句后，就会自动隐式提交事务

# 查看 / 设置事务提交方式
-- 查看：SELECT @@autocommit;
-- 设置：SET autocommit = 0; 全局关闭自动提交事务

# 事务操作
-- 开启事务：START TRANSACTION 或 BEGIN; 局部开启事务
-- 提交事务：COMMIT;
-- 回滚事务：ROLLBACK;

# 事务四大特性(ACID)
-- 原子性(Atomicity)：事务是一个不可分割的工作单位，事务中的操作要么全部成功，要么全部失败
-- 一致性(Consistency)：事务执行前后，数据保持一致
-- 隔离性(Isolation)：多个事务之间互不干扰，一个事务不应该影响其它事务
-- 持久性(Durability)：事务一旦提交，对数据的修改是永久性的

# 并发事务带来的问题
-- 脏读：一个事务读取到了另一个事务未提交的数据。例如：事务 A 读取到了事务 B 修改但未提交的数据
-- 不可重复读：一个事务读取到了另一个事务已经提交的数据，导致前后读取的数据不一致。例如：事务 A 首先读取了原数据，而后又读到了事务 B 已经修改提交的数据
-- 幻读：一个事务读取到了另一个事务已经提交的数据，导致前后读取的数据不一致。例如：事务 A 首先未读到数据，而后又读到了事务 B 已经修改提交的数据

# 事务隔离级别
-- 事务隔离级别：事务并发时，可能会出现脏读、不可重复读、幻读的问题，为了解决这些问题，提出了事务隔离级别的概念
-- READ UNCOMMITTED(读未提交)：会出现"脏读、不可重复读、幻读"的问题。性能最好，但是不安全，一般不使用
-- READ COMMITTED(读已提交)：会出现"不可重复读、幻读"的问题。
-- REPEATABLE READ(可重复读)：会出现"幻读"的问题。默认级别
-- SERIALIZABLE(串行化)：事务串行执行，不会出现并发问题。性能最差，但是最安全

# 查看 / 设置事务隔离级别
-- 查看：SELECT @@TRANSACTION_ISOLATION;
-- 设置：SET [SESSION | GLOBAL] TRANSACTION ISOLATION LEVEL [READ UNCOMMITTED | READ COMMITTED | REPEATABLE READ | SERIALIZABLE];

USE itheima;

# 数据准备
-- _______________________________________________________________________________________
create table account
(
    id    int primary key AUTO_INCREMENT comment 'ID',
    name  varchar(10) comment '姓名',
    money double(10, 2) comment '余额'
) comment '账户表';
insert into account(name, money)
VALUES ('张三', 2000),
       ('李四', 2000);

-- _______________________________________________________________________________________

# 查看事务提交方式
SELECT @@autocommit; -- autocommit 是系统变量，用来表示事务提交方式，0 表示关闭自动提交事务，1 表示开启自动提交事务
SET autocommit = 0; -- 关闭自动提交事务

# 查看事务隔离级别
SELECT @@TRANSACTION_ISOLATION; -- TRANSACTION_ISOLATION 是系统变量，用来表示事务隔离级别
# SET SESSION TRANSACTION ISOLATION LEVEL REPEATABLE READ ; -- 设置事务隔离级别为 REPEATABLE READ

# 转账操作(张三给李四转1000)
-- 恢复数据
UPDATE account SET money = 2000 WHERE id IN (1, 2);

-- 1. 查询张三的余额
SELECT * FROM account WHERE name = '张三';

-- 2. 将张三的余额 -1000
UPDATE account SET money = money - 1000 WHERE name = '张三';

-- 3. 将李四的余额 +1000
UPDATE account SET money = money + 1000 WHERE name = '李四';

-- 4. 提交事务
COMMIT;

-- 5. 回滚事务
ROLLBACK;

# 转账操作(张三给李四转1000) 方式二
START TRANSACTION; -- 开启事务

-- 1. 查询张三的余额
SELECT * FROM account WHERE name = '张三';

-- 2. 将张三的余额 -1000
UPDATE account SET money = money - 1000 WHERE name = '张三';

执行错误语句 ...

-- 3. 将李四的余额 +1000
UPDATE account SET money = money + 1000 WHERE name = '李四';

-- 4. 提交事务
COMMIT;

-- 5. 回滚事务
ROLLBACK;


SELECT * FROM account;