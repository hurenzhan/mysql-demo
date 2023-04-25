# 字符串函数
-- CONCAT(str1,str2,...)：连接字符串
-- LOWER(str)：转换为小写
-- UPPER(str)：转换为大写
-- LPAD(str,len,padstr)：左填充
-- RPAD(str,len,padstr)：右填充
-- TRIM(str)：去除两边空格
-- SUBSTRING(str,pos,len)：截取字符串

UPDATE emp SET workno = LPAD(workno, 5, '0'); -- 工号左填充 0

# 数值函数
-- CEIL(num)：向上取整
-- FLOOR(num)：向下取整
-- MOD(num1,num2)：返回num1除以num2的余数
-- RAND()：返回一个 0-1 之间的随机数
-- ROUND(num,digits)：求参数 num 的四舍五入值，保留 digits 位小数

SELECT LPAD(ROUND(RAND() * 1000000, 0), 6, 0); -- 生成 6 位随机数

# 日期函数
-- CURDATE()：返回当前日期
-- CURTIME()：返回当前时间
-- NOW()：返回当前日期和时间
-- YEAR(date)：返回年份
-- MONTH(date)：返回月份
-- DAY(date)：返回天
-- DATE_ADD(date,interval expr unit)：日期加上一个时间间隔 (expr 为时间间隔数值，unit 为时间间隔单位)
-- DATEDIFF(date1,date2)：返回两个日期之间的天数

SELECT name, DATEDIFF(CURDATE(), entrydate) AS 'entryDays' FROM emp ORDER BY entryDays DESC;

# 流程控制函数
-- IF(value, r, l)：如果 value 为真，则返回 r，否则返回 l
-- IFNULL(value1, value2)：如果 value1 不为 NULL，则返回 value1，否则返回 value2
-- CASE WHEN value THEN res ELSE default END：如果 value 为真，则返回 res，否则返回 default
-- CASE expr WHEN value THEN res ELSE default END：如果 expr 等于 value，则返回 res，否则返回 default

SELECT name, workaddress, CASE workaddress WHEN '北京' THEN '一线城市' WHEN '上海' THEN '一线城市' ELSE '二线城市' END AS cityType FROM emp; -- 统计员工所在城市类型，如果是北京或上海为一线城市，其他则二线城市
SELECT id, name,
(CASE WHEN math >= 85 THEN '优秀' WHEN math >=60 THEN '及格' ELSE '不及格' END ) AS '数学',
(CASE WHEN english >= 85 THEN '优秀' WHEN english >=60 THEN '及格' ELSE '不及格'END ) AS '英语',
(CASE WHEN chinese >= 85 THEN '优秀' WHEN chinese >=60 THEN '及格' ELSE '不及格'END ) AS '语文'
FROM score;

SELECT * FROM emp;
SELECT * FROM score;