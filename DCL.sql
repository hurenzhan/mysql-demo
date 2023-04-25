# DCL - Data Control Language，数据控制语言，用于定义数据库的访问权限和安全级别，如 GRANT 和 REVOKE 等。

# 通配符
-- % 代表任意多个字符

# 常用权限
-- ALL, ALL PRIVILEGES：所有权限
-- CREATE：创建数据库、表、索引、用户等
-- DROP：删除数据库、表、索引等
-- DELETE：删除数据
-- INSERT：插入数据
-- SELECT：查询数据
-- UPDATE：更新数据
-- ALTER：修改表结构

USE mysql;

# 用户管理
-- 多个权限之间用逗号隔开
-- 授权时, 数据库和表名可以使用 * 通配符, 代表所有数据库或所有表
CREATE USER 'itcast'@'localhost' IDENTIFIED BY '123456'; -- 创建用户 itcast, 只能够在当前主机 localhost 访问, 密码为 123456

CREATE USER 'aren'@'%' IDENTIFIED BY '123456'; -- 创建用户 aren, 可以在任意主机访问, 密码为 123456

ALTER USER 'aren'@'%' IDENTIFIED WITH mysql_native_password BY '123456'; -- 修改用户 aren 的密码为 123456

DROP USER 'itcast'@'localhost'; -- 删除用户 itcast

# 权限控制
SHOW GRANTS FOR 'aren'@'%'; -- 查看用户 aren 的权限

GRANT ALL ON itcast.* TO 'aren'@'%'; -- 给用户 aren 分配 itcast 库的所有权限

REVOKE ALL ON itcast.* FROM 'aren'@'%'; -- 撤销用户 aren 的 itcast 库的所有权限

SELECT * FROM user;