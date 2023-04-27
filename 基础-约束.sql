# 约束概述
-- 约束是用来限制表中数据的完整性
-- 目的：保证数据的正确性、有效性和相容性

# 分类
-- 1.主键约束：primary key 一张表只能有一个主键，主键不能重复，主键不能为null
-- 2.外键约束：foreign key 用来让两张表产生关联
-- 3.非空约束：not null 非空约束不能为null
-- 4.唯一约束：unique 保证该字段的所有数据都是唯一的、不重复的
-- 5.默认约束：default 保存数据时，如果没有给该字段赋值，则使用默认值
-- 6.检查约束：check 用来限制某个字段的取值范围


# CREATE TABLE tb_user
# (
#     id     int AUTO_INCREMENT PRIMARY KEY COMMENT 'ID唯一标识',
#     name   varchar(10) NOT NULL UNIQUE COMMENT '姓名',
#     age    int check (age > 0 && age <= 120) COMMENT '年龄',
#     status char(1) default '1' COMMENT '状态',
#     gender char(1) COMMENT '性别'
# );

# 基础约束
USE itcast;

insert into tb_user(name,age,status,gender) values ('Tom1',19,'1','男'),('Tom2',25,'0','男'); -- 主键约束与自动增长
insert into tb_user(name,age,status,gender) values ('Tom3',19,'1','男');
insert into tb_user(name,age,status,gender) values (null,19,'1','男'); -- 非空约束
insert into tb_user(name,age,status,gender) values ('Tom3',19,'1','男'); -- 唯一约束，已经有了 Tom3
insert into tb_user(name,age,status,gender) values ('Tom4',80,'1','男');
insert into tb_user(name,age,status,gender) values ('Tom5',-1,'1','男'); -- 检查约束，age > 0 && age <= 120
insert into tb_user(name,age,status,gender) values ('Tom5',121,'1','男'); -- 检查约束，age > 0 && age <= 120
insert into tb_user(name,age,gender) values ('Tom5',120,'男'); -- 默认约束，status 默认为 1

# 外键约束
USE itrelationships;

-- 主表 部门表
create table dept
(
    id   int auto_increment comment 'ID' primary key,
    name varchar(50) not null comment '部门名称'
) comment '部门表';
INSERT INTO dept (id, name) VALUES (1, '研发部'),(2, '市场部'),(3, '财务部'),(4,'销售部'),(5, '总经办');

-- 子表 员工表
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

INSERT INTO emp (id, name, age, job,salary, entrydate, managerid, dept_id) VALUES
(1, '金庸', 66, '总裁',20000, '2000-01-01', null,5),
(2, '张无忌', 20,'项目经理',12500, '2005-12-05', 1,1),
(3, '杨逍', 33, '开发', 8400,'2000-11-03', 2,1),
(4, '韦一笑', 48, '开发',11000, '2002-02-05', 2,1),
(5, '常遇春', 43, '开发',10500, '2004-09-07', 3,1),
(6, '小昭', 19, '程序员鼓励师',6600, '2004-10-12', 2,1);

-- 建立外键约束
ALTER TABLE emp ADD CONSTRAINT fk_emp_dept_id FOREIGN KEY (dept_id) REFERENCES dept(id);

-- 删除外键约束
ALTER TABLE emp DROP FOREIGN KEY fk_emp_dept_id;

-- 删除/更新行为
-- 1.NO ACTION：当父表中的数据被删除或者更新时，不允许删除或更新子表中的数据
-- 2.RESTRICT：与 NO ACTION 一样
-- 3.CASCADE：当父表中的数据被删除或者更新时，子表中的数据也会被删除或更新
-- 4.SET NULL：当父表中的数据被删除或者更新时，子表中的数据会被设置为 null
-- 5.SET DEFAULT：当父表中的数据被删除或者更新时，子表中的数据会被设置为默认值
ALTER TABLE emp ADD CONSTRAINT fk_emp_dept_id FOREIGN KEY (dept_id) REFERENCES dept(id) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE emp ADD CONSTRAINT fk_emp_dept_id FOREIGN KEY (dept_id) REFERENCES dept(id) ON DELETE SET NULL ON UPDATE SET NULL;



SELECT * FROM tb_user;
SELECT * FROM dept;
SELECT * FROM emp;