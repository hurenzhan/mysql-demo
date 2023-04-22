# DQL - Data Query Language 数据查询语言

# 基本查询
-- SELECT - 字段列表
-- FROM - 表名列表

# 条件查询
-- 比较运算符 (>, <, >=, <=, =, !=, <>, BETWEEN ...AND..., IN, LIKE, IS NULL)
-- 逻辑运算符 (AND, OR, NOT) 优先级: NOT > AND > OR
-- WHERE - 条件列表

# 聚合函数 (对查询结果进行计算, 只作用于表中的某一列. 所有 NULL 值都会被忽略)
-- COUNT - 统计数量
-- SUM - 求和
-- AVG - 求平均值
-- MAX - 求最大值
-- MIN - 求最小值

# 分组查询
-- GROUP BY - 分组字段列表
-- HAVING - 分组后条件列表 (与 WHERE 的区别: WHERE 作用于原始数据, HAVING 作用于分组后的数据)

-- where 与 having 区别
    -- 执行时机不同: where 是分组之前进行过滤, 不满足 where 条件, 不参与分组; 而 having 是分组之后对结果进行过滤.
    -- 判断条件不同: where 不能对聚合函数进行判断, 而having可以.
    -- 执行顺序不同: where 在 group by 之前执行，having 在 group by 之后执行。 (where > 聚合函数 > having)
    -- 分组之后, 查询的字段一般为聚合函数和分组字段, 查询其他字段无意义. 例如: SELECT name, gender, COUNT(*) FROM emp GROUP BY gender 中, 以性别 gender 分组了男女两组, 但所有男女的姓名 name 字段值都不同, 无法统计.

# 排序查询
-- ORDER BY - 排序字段列表

# 分页查询
-- LIMIT - 分页参数


use itcast;

# 基本查询
SELECT * FROM emp; -- 查询所有字段 (开发中尽量不要写，1.性能低 2.不直观)
SELECT name, workno, age FROM emp;  -- 查询指定 name, workno, age 字段 (SELECT 选择字段列表)
SELECT workaddress as '工作地址' FROM emp;  -- 查询指定 workaddress 字段并起别名为工作地址 (as 起别名)
SELECT DISTINCT workaddress FROM emp;  -- 查询指定 workaddress 过滤重复值 (DISTINCT 去重)

# 条件查询
SELECT * FROM emp WHERE age = 88; -- 查询 age 等于 88 的数据 (WHERE 条件列表)
SELECT * FROM emp WHERE age != 88; -- 查询 age 不等于 88 的数据 (!= 与 <> 作用一样)
SELECT * FROM emp WHERE age < 20; -- 查询 age 小于 20 的数据
SELECT * FROM emp WHERE age <= 20; -- 查询 age 小于等于 20 的数据
SELECT * FROM emp WHERE idcard IS NULL; -- 查询 idcard 没有值的数据
SELECT * FROM emp WHERE idcard IS NOT NULL; -- 查询 idcard 有值的数据
SELECT * FROM emp WHERE age >= 15 && age <= 20; -- 查询 age 大于等于 15 小于等于 20 的数据 (&& 与 AND 作用一样) (与 age BETWEEN 15 AND 20 作用一样)
SELECT * FROM emp WHERE gender = '女' && age < 25; -- 查询 gender 为女且 age 小于 25 的数据
SELECT * FROM emp WHERE age = 18 || age = 20 || age = 40; -- 查询 age 为 18 或 20 或 30 的数据 (|| 与 OR 作用一样) (与 age IN(18, 20, 40) 作用一样)
SELECT * FROM emp WHERE name LIKE '__'; -- 查询 name 为两个字符的数据 (LIKE 模糊查询 _ 代表一个字符 % 代表任意字符)
SELECT * FROM emp WHERE idcard LIKE '%X'; -- 查询 idcard 以 X 结尾的数据

# 聚合函数
SELECT COUNT(*) FROM emp; -- 查询 emp 表中的数据总数
SELECT COUNT(idcard) FROM emp; -- 查询 emp 表中的 idcard 值不为 NULL 的总数
SELECT AVG(age) FROM emp; -- 查询 emp 表中的 age 平均值
SELECT MAX(age) FROM emp; -- 查询 emp 表中的 age 最大值
SELECT MIN(age) FROM emp; -- 查询 emp 表中的 age 最小值
SELECT SUM(age) FROM emp WHERE workaddress = '西安'; -- 查询 emp 表中 workaddress 为西安的 age 总和

# 分组查询
SELECT gender, COUNT(*) FROM emp GROUP BY gender; -- 根据 gender 分组并统计每组的总数
SELECT gender, AVG(age) FROM emp GROUP BY gender; -- 根据 gender 分组并统计每组 age 的平均值
SELECT workaddress, COUNT(*) as address_count FROM emp WHERE age < 45 GROUP BY workaddress HAVING address_count > 3; -- 根据 workaddress 分组并统计每组 age 小于 45 的总数, 筛选出总数大于 3 的数据 (HAVING 分组后条件列表)


SELECT * FROM emp;



