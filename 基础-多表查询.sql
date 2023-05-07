# 一对多(多对一)
-- 例如：一个班级有多个学生，一个学生只能属于一个班级
-- 实现：多的一方建立外键，指向一的一方的主键

# 多对多
-- 例如：一个学生可以选择多个课程，一个课程可以被多个学生选择
-- 实现：需要借助第三张中间表，至少包含两个外键，分别指向两张表的主键

# 一对一
-- 例如：用户与用户详情的关系，一个用户只能有一个详情，一个详情只能属于一个用户。主要用于单表拆分，将基础字段与扩展字段分开存储
-- 实现：在任意一方建立外键，指向另一方的主键，并且设置外键唯一约束(这样才能限制一对一的关系)

# 多表查询
-- 指从多张表中查询数据
-- 分类：
    -- 连接查询：
        -- 内连接查询：查询结果为两张表的交集
        -- 外连接查询：
            -- 左外连接：查询左表的全部数据，以及两张表的交集部分数据
            -- 右外连接：查询右表的全部数据，以及两张表的交集部分数据
        -- 自连接查询：当前表与自身进行连接查询，自连接必须使用表别名
    -- 子查询：将查询结果作为另一条SQL语句的条件

# 联合查询 union all, union
-- union all：将多条 SQL 查询结果合并成一条结果，不去重
-- union：将多条 SQL 查询结果合并成一条结果，去重
-- 要求：两条 SQL 语句的查询结果的列数必须一致，列的字段类型必须保持一致

# 子查询 SQL 语句中嵌套 SELECT 语句，称为子查询，又称子查询
-- 子查询外部语句可以是 SELECT、INSERT、UPDATE、DELETE 任意一个
-- 分类：
    -- 标量子查询：子查询返回的结果是一个标量值(单行单列)
    -- 列子查询：子查询返回的结果是一列值(单列多行)
    -- 行子查询：子查询返回的结果是一行值(多列单行)
    -- 表子查询：子查询返回的结果是一张表(多列多行)

USE itheima;

# 多对多表结构
-- _______________________________________________________________________________________
-- 学生表
create table student
(
    id   int auto_increment primary key comment '主键ID',
    name varchar(10) comment '姓名',
    no   varchar(10) comment '学号'
) comment '学生表';
insert into student
values (null, '黛绮丝', '2000100101'),
       (null, '谢逊',
        '2000100102'),
       (null, '殷天正', '2000100103'),
       (null, '韦一笑', '2000100104');

-- 课程表
create table course
(
    id   int auto_increment primary key comment '主键ID',
    name varchar(10) comment '课程名称'
) comment '课程表';
insert into course
values (null, 'Java'),
       (null, 'PHP'),
       (null, 'MySQL'),
       (null, 'Hadoop');

-- 学生课程中间表
create table student_course
(
    id        int auto_increment comment '主键' primary key,
    studentid int not null comment '学生ID',
    courseid  int not null comment '课程ID',
    constraint fk_courseid foreign key (courseid) references course (id),
    constraint fk_studentid foreign key (studentid) references student (id)
) comment '学生课程中间表';
insert into student_course
values (null, 1, 1),
       (null, 1, 2),
       (null, 1, 3),
       (null, 2, 2),
       (null, 2, 3),
       (null, 3, 4);

SELECT * FROM student_course;
SELECT * FROM student;
SELECT * FROM course;
-- _______________________________________________________________________________________

# 一对一表结构
-- _______________________________________________________________________________________
-- 用户表
create table tb_user
(
    id     int auto_increment primary key comment '主键ID',
    name   varchar(10) comment '姓名',
    age    int comment '年龄',
    gender char(1) comment '1: 男 , 2: 女',
    phone  char(11) comment '手机号'
) comment '用户基本信息表';
insert into tb_user(id, name, age, gender, phone)
values (null, '黄渤', 45, '1', '18800001111'),
       (null, '冰冰', 35, '2', '18800002222'),
       (null, '码云', 55, '1', '18800008888'),
       (null, '李彦宏', 50, '1', '18800009999');

-- 用户详情表
create table tb_user_edu
(
    id            int auto_increment primary key comment '主键ID',
    degree        varchar(20) comment '学历',
    major         varchar(50) comment '专业',
    primaryschool varchar(50) comment '小学',
    middleschool  varchar(50) comment '中学',
    university    varchar(50) comment '大学',
    userid        int unique comment '用户ID',
    constraint fk_userid foreign key (userid) references tb_user (id)
) comment '用户教育信息表';
insert into tb_user_edu(id, degree, major, primaryschool, middleschool,
                        university, userid)
values (null, '本科', '舞蹈', '静安区第一小学', '静安区第一中学', '北京舞蹈学院', 1),
       (null, '硕士', '表演', '朝阳区第一小学', '朝阳区第一中学', '北京电影学院', 2),
       (null, '本科', '英语', '杭州市第一小学', '杭州市第一中学', '杭州师范大学', 3),
       (null, '本科', '应用数学', '阳泉第一小学', '阳泉区第一中学', '清华大学', 4);

SELECT * FROM tb_user;
SELECT * FROM tb_user_edu;
-- _______________________________________________________________________________________

# 多表查询数据准备
-- _______________________________________________________________________________________
-- 创建部门表
create table dept
(
    id   int auto_increment comment 'ID' primary key,
    name varchar(50) not null comment '部门名称'
) comment '部门表';
INSERT INTO dept (id, name)
VALUES (1, '研发部'),
       (2, '市场部'),
       (3, '财务部'),
       (4,
        '销售部'),
       (5, '总经办'),
       (6, '人事部');

-- 创建员工表
create table emp
(
    id        int auto_increment comment 'ID' primary key,
    name      varchar(50) not null comment '姓名',
    age       int comment '年龄',
    job       varchar(20) comment '职位',
    salary    int comment '薪资',
    entrydate date comment '入职时间',
    managerid int comment '直属领导ID',
    dept_id   int comment '部门ID'
) comment '员工表';
INSERT INTO emp (id, name, age, job, salary, entrydate, managerid, dept_id)
VALUES (1, '金庸', 66, '总裁', 20000, '2000-01-01', null, 5),
       (2, '张无忌', 20, '项目经理', 12500, '2005-12-05', 1, 1),
       (3, '杨逍', 33, '开发', 8400, '2000-11-03', 2, 1),
       (4, '韦一笑', 48, '开发', 11000, '2002-02-05', 2, 1),
       (5, '常遇春', 43, '开发', 10500, '2004-09-07', 3, 1),
       (6, '小昭', 19, '程序员鼓励师', 6600, '2004-10-12', 2, 1),
       (7, '灭绝', 60, '财务总监', 8500, '2002-09-12', 1, 3),
       (8, '周芷若', 19, '会计', 48000, '2006-06-02', 7, 3),
       (9, '丁敏君', 23, '出纳', 5250, '2009-05-13', 7, 3),
       (10, '赵敏', 20, '市场部总监', 12500, '2004-10-12', 1, 2),
       (11, '鹿杖客', 56, '职员', 3750, '2006-10-03', 10, 2),
       (12, '鹤笔翁', 19, '职员', 3750, '2007-05-09', 10, 2),
       (13, '方东白', 19, '职员', 5500, '2009-02-12', 10, 2),
       (14, '张三丰', 88, '销售总监', 14000, '2004-10-12', 1, 4),
       (15, '俞莲舟', 38, '销售', 4600, '2004-10-12', 14, 4),
       (16, '宋远桥', 40, '销售', 4600, '2004-10-12', 14, 4),
       (17, '陈友谅', 42, null, 2000, '2011-10-12', 1, null);

-- 添加外键约束
alter table emp
    add constraint fk_emp_dept_id foreign key (dept_id) references
        dept (id);

-- 多表查询
SELECT * FROM emp, dept; -- 笛卡尔积
-- 内连接
SELECT * FROM emp, dept WHERE emp.dept_id = dept.id; -- 隐式内连接
SELECT e.name, d.name FROM emp e, dept d WHERE e.dept_id = d.id; -- 隐式内连接，查询每一个员工的姓名和关联的部门名称
SELECT e.name, d.name FROM emp e INNER JOIN dept d ON e.dept_id = d.id; -- 显式内连接，查询每一个员工的姓名和关联的部门名称，不匹配的行不显示
-- 外连接
SELECT e.*, d.name FROM emp e LEFT OUTER JOIN dept d ON e.dept_id = d.id; -- 左外连接，查询每一个员工的所有信息和关联的部门名称，不匹配的行显示 null
SELECT d.*, e.* FROM emp e RIGHT OUTER JOIN dept d ON e.dept_id = d.id; -- 右外连接，查询每一个部门的所有信息和关联的员工信息，不匹配的行显示 null
SELECT d.*, e.* FROM dept d LEFT OUTER JOIN emp e on d.id = e.dept_id; -- 使用左外连接查询每一个部门的所有信息和关联的员工信息，不匹配的行显示 null(与上面的查询结果一致)
-- 自连接
SELECT e1.name, e2.name FROM emp e1, emp e2 WHERE e1.managerid = e2.id; -- 查询每一个员工的姓名和直属领导的姓名
SELECT e1.name, e2.name FROM emp e1 LEFT JOIN emp e2 ON e1.managerid = e2.id; -- 查询每一个员工的姓名和直属领导的姓名，不匹配的行显示 null
-- 联合查询
SELECT * FROM emp WHERE salary < 5000 UNION ALL SELECT * FROM emp WHERE age > 50; -- 查询薪资小于 5000 的员工和年龄大于 50 的员工
SELECT * FROM emp WHERE salary < 5000 UNION SELECT * FROM emp WHERE age > 50; -- 查询薪资小于 5000 的员工和年龄大于 50 的员工，去除重复行
-- 标量子查询 (单行单列，主要用的操作符有 =, >, <, >=, <=, !=, <>）
SELECT * FROM emp WHERE dept_id = (SELECT id FROM dept WHERE name = '销售部'); -- 查询销售部的所有员工
SELECT * FROM emp WHERE entrydate > (SELECT entrydate FROM emp WHERE name = '方东白'); -- 查询入职时间晚于方东白的所有员工
-- 列子查询 (单列多行，主要用的操作符有 IN, NOT IN, ANY, SOME, ALL)
SELECT * FROM emp WHERE dept_id IN (SELECT id FROM dept WHERE name = '销售部' OR name = '市场部'); -- 查询销售部和市场部的所有员工
SELECT * FROM emp WHERE salary > ALL(SELECT salary FROM emp WHERE dept_id = (SELECT id FROM dept WHERE name = '财务部')); -- 查询薪资高于财务部所有员工的员工
SELECT * FROM emp WHERE salary > SOME(SELECT salary FROM emp WHERE dept_id = (SELECT id FROM dept WHERE name = '研发部')); -- 查询薪资高于研发部任意一个员工的员工
-- 行子查询 (多列单行，主要用的操作符有 =, <>, IN, NOT IN)
SELECT * FROM emp WHERE (salary, managerid) = (SELECT salary, managerid FROM emp WHERE name = '张无忌'); -- 查询与张无忌薪资和直属领导相同的员工
-- 表子查询 (多列多行，即把查询结果作为临时表，主要用的操作符有 IN)
SELECT * FROM emp WHERE (job, salary) IN(SELECT job, salary FROM emp WHERE name = '鹿杖客' or name = '宋远桥'); -- 查询与鹿杖客或宋远桥职位和薪资相同的员工
SELECT e.*, d.* FROM (SELECT * FROM emp WHERE entrydate > '2006-01-01') e LEFT OUTER JOIN dept d ON e.dept_id = d.id; -- 查询入职时间晚于 2006-01-01 的员工和关联的部门名称
SELECT e.*, d.* FROM emp e LEFT OUTER JOIN dept d ON e.dept_id = d.id WHERE entrydate > '2006-01-01'; -- 与上面的查询结果一致

SELECT * FROM emp;
SELECT * FROM dept;
-- _______________________________________________________________________________________

# 多表查询练习01
-- _______________________________________________________________________________________
-- 创建薪资表
create table salgrade(
    grade int, -- 等级
    losal int, -- 最低薪资
    hisal int -- 最高薪资
) comment '薪资等级表';
insert into salgrade values (1,0,3000),(2,3001,5000),(3,5001,8000),(4,8001,10000),(5,10001,15000),(6,15001,20000),(7,20001,25000),(8,25001,30000);

# 1. 查询员工的姓名、年龄、职位、部门信息(隐示内连接)
-- 表：emp, dept
-- 连接条件：emp.dept_id = dept.id
SELECT e.name, e.age, e.job, d.name FROM emp e, dept d WHERE e.dept_id = d.id;

# 2. 查询年龄小于 30 岁的员工的姓名、年龄、职位、部门信息(显示内连接)
-- 表：emp, dept
-- 连接条件：emp.dept_id = dept.id
SELECT e.name, e.age, e.job, d.name FROM emp e INNER JOIN dept d ON e.dept_id = d.id WHERE e.age < 30;

# 3. 查询拥有员工的部门 ID、部门名称(隐示内连接)
-- 表：emp, dept
-- 连接条件：emp.dept_id = dept.id
-- DISTINCT 关键字：去除重复行
SELECT DISTINCT d.id, d.name FROM emp e, dept d WHERE e.dept_id = d.id;

# 4. 查询所有年龄大于 40 岁的员工，及其归属的部门名称；如果没有归属部门的员工也要显示出来(显示内连接)
-- 表：emp, dept
-- 连接条件：emp.dept_id = dept.id
-- 左外连接会完全包含左表的所有行数据，即使右表没有匹配行
SELECT e.*, d.name FROM emp e LEFT OUTER JOIN dept d ON e.dept_id = d.id WHERE e.age > 40;

# 5. 查询所有员工的工资等级信息(隐示内连接)
-- 表：emp, salgrade
-- 连接条件：emp.salary BETWEEN salgrade.losal AND salgrade.hisal
SELECT e.*, s.grade FROM emp e, salgrade s WHERE e.salary BETWEEN s.losal AND s.hisal;

# 6. 查询 "研发部" 所有员工的信息、工资等级(隐示内连接)
-- 表：emp, dept, salgrade
-- 连接条件：emp.dept_id = dept.id AND emp.salary BETWEEN salgrade.losal AND salgrade.hisal
-- 查询条件：dept.name = '研发部'
SELECT e.*, s.grade
FROM emp e,
     dept d,
     salgrade s
WHERE (e.dept_id = d.id)
  AND (e.salary BETWEEN s.losal AND s.hisal)
  AND d.name = '研发部';

# 7. 查询 "研发部" 的员工的平均工资(隐示内连接)
-- 表：emp, dept
-- 连接条件：emp.dept_id = dept.id
-- 查询条件：dept.name = '研发部'
SELECT AVG(e.salary) FROM emp e, dept d WHERE e.dept_id = d.id AND d.name = '研发部';

# 8. 查询工资比 "灭绝" 高的员工的信息
-- 表：emp
-- a. 标量子查询(返回单行单列的查询结果) "灭绝" 的工资：SELECT salary FROM emp WHERE name = '灭绝';
-- b. 查询工资比 "灭绝" 高的员工的信息：SELECT * FROM emp WHERE salary > "灭绝" 的薪资;
SELECT * FROM emp WHERE salary > (SELECT salary FROM emp WHERE name = '灭绝');

# 9. 查询比平均工资高的员工的信息
-- 表：emp
-- a. 标量子查询(返回单行单列的查询结果) 平均工资：SELECT AVG(salary) FROM emp;
-- b. 查询比平均工资高的员工的信息：SELECT * FROM emp WHERE salary > 平均工资;
SELECT * FROM emp WHERE salary > (SELECT AVG(salary) FROM emp);

# 10. 查询比本部门平均工资低的员工的信息
-- 表：emp
-- a. 标量子查询(返回单行单列的查询结果) 本部门平均工资：SELECT AVG(salary) FROM emp WHERE dept_id = 1;
-- b. 查询比本部门平均工资低的员工的信息：SELECT * FROM emp WHERE salary < 本部门平均工资;
SELECT * FROM emp e2 WHERE e2.salary < (SELECT AVG(e1.salary) FROM emp e1 WHERE e1.dept_id = e2.dept_id);
SELECT *, (SELECT AVG(e1.salary) FROM emp e1 WHERE e1.dept_id = e2.dept_id) 平均 FROM emp e2 WHERE e2.salary < (SELECT AVG(e1.salary) FROM emp e1 WHERE e1.dept_id = e2.dept_id); -- 添加平均薪资列验证

# 11. 查询所有部门信息，并统计部门的员工人数(子查询)
-- 表：emp, dept
-- 连接条件：emp.dept_id = dept.id
SELECT d.*, COUNT(e.id) FROM emp e, dept d WHERE e.dept_id = d.id GROUP BY d.id;
SELECT d.name, (SELECT COUNT(*) FROM emp e WHERE e.dept_id = d.id) AS 人数 FROM dept d;

# 12. 查询所有学校的选课情况，展示出学生名称、学号、课程名称
-- 表：student, course, student_course
-- 连接条件：student.id = student_course.studentid AND course.id = student_course.courseid
SELECT s.name, s.no, c.name FROM student s, course c, student_course sc WHERE s.id = sc.studentid AND c.id = sc.courseid;


SELECT * FROM emp;
SELECT * FROM dept;
SELECT * FROM salgrade;
SELECT * FROM student;
SELECT * FROM course;
SELECT * FROM student_course;
-- _______________________________________________________________________________________