# DML - Data Manipulation Language, 数据操纵语言, 用于对数据库中的数据进行增删改查操作

use itcast;

# 插入
INSERT INTO employee(id, workno, name, gender, age, idcard, entrydate) VALUES (1, '1', 'ITCast', '男', 10, '123456789', '2000-01-01');
INSERT INTO employee(id, workno, name, gender, age, idcard, entrydate) VALUES (2, '2', 'ITCast2', '男', 20, '123456789', '2200-01-01');
INSERT INTO employee VALUES (3, '3', 'ITCast3', '男', 30, '123456789', '2300-01-01');
INSERT INTO employee VALUES (4, '4', 'ITCast4', '男', 40, '123456789', '2400-01-01'),(5, '5', 'ITCast5', '男', 50, '123456789', '2500-01-01');  -- 多条插入

# 修改
UPDATE employee SET name = 'ITCast-mdf' WHERE id = 1;  -- 筛选行 id 字段为 1 的数据, 将当前数据 name 字段值修改为 ITCast-mdf
UPDATE employee SET name = 'ITCast-mdf', gender = '女' WHERE id = 2;  -- 筛选行 id 字段为 2 的数据, 将当前数据 name 字段值修改为 ITCast-mdf, gender 修改为女
UPDATE employee SET entrydate = '2023-01-01';  -- 将所有数据中 entrydate 字段值修改为 2023-01-01

# 删除
DELETE FROM employee WHERE id = 1;  -- 筛选行 id 字段为 1 的数据并删除
DELETE FROM employee;  -- 删除所有数据

SELECT * FROM employee;