
USE myemployees;
+------------------BEGIN-------------------+
视图的创建
CREATE VIEW myv_2 AS
SELECT em.* -- em. 不可省略
FROM   employees AS em
       JOIN `departments` AS de
	   ON em.`department_id`= de.`department_id`;





视图的修改
1.
CREATE OR REPLACE  VIEW myv_2 AS
SELECT * FROM employees;
	
2.
ALTER VIEW myv_2 AS
SELECT * FROM departments;




视图的查看
SELECT * FROM myv_2;
DESC myv_2 ;-- 查看结构
SHOW CREATE VIEW myv_2;

视图的删除

DROP VIEW `myv_1`,`myv_2`;

视图的更新
-- 不是更改SQL逻辑，
-- 而是更改数据
-- 同时也对原始表进行了更新
+------------------END---------------------+




+------------------BEGIN-------------------+
系统变量：
	全局变量
	会话变量：针对客户端一次连接

自定义变量：
	用户变量
	局部变量


1.`
说明：变量由系统定义，不是用户定义，属于服务器层面
注意：
	全局变量需要添加global关键字，
	会话变量需要添加session关键字，
	如果不写，默认会话级别

使用步骤：
1、查看所有系统变量
show global|【session】variables;
2、查看满足条件的部分系统变量
show global|【session】 variables like '%char%';
3、查看指定的系统变量的值
select @@global|【session】系统变量名;
4、为某个系统变量赋值
方式一：
set global|【session】系统变量名=值;
方式二：
set @@global|【session】系统变量名=值;`


+------------------END---------------------+

1.
SHOW GLOBAL VARIABLES;
SHOW SESSION VARIABLES;

CREATE TABLE students (
	student_Name VARCHAR(20),
	id INT

);

SELECT * FROM `students`;


DELIMITER $
CREATE PROCEDURE Save()
BEGIN
	INSERT INTO `students`
	VALUE('A11',11),
	('A22',22),
	('A33',33),
	('A44',44),
	('A55',55);

END $



CALL Save();

SELECT * FROM students;




用户登录demo
1.创建 用户/密码表
CREATE TABLE admin(
	username VARCHAR(20),
	`password` VARCHAR(20)
);

2.注册：创建用户
INSERT INTO admin(username,`password`) 
	VALUES	('john1','0000'),
		('lily','0000'),
		('rose','0000'),
		('jack','0000'),
		('tom','0000');


-- select *from admin;

3.制作存储过程【检测过程】
DELIMITER $
CREATE PROCEDURE Admin_test2(IN username VARCHAR(20),IN PASSWORD VARCHAR(20))
BEGIN
	DECLARE result INT DEFAULT 0;#声明并初始化
	
	SELECT COUNT(*) INTO result#赋值
	FROM admin
	WHERE admin.username = username
	AND admin.password = `password`;
	
	SELECT IF(result>0,'登录成功','登录失败') AS 登录;#使用
END $

4.调用

CALL Admin_test2('john','0000');






DELIMITER $
CREATE FUNCTION function_test(departName VARCHAR(20)) 
RETURNS DOUBLE
BEGIN
	DECLARE sal DOUBLE ;
	SELECT AVG(salary) INTO sal
	FROM   `departments` AS de 
		INNER JOIN `employees` AS em
			ON de.department_id = em.department_id
	
	WHERE department_name = departName;

	RETURN sal;
END $

SELECT function_test('IT');



CREATE FUNCTION add_Function(f1 FLOAT ,f2 FLOAT)
RETURNS FLOAT
	RETURN f1 + f2;



SELECT add_Function(12.1,21.3);




DELIMITER $
CREATE PROCEDURE achievement2(IN achieve INT)
BEGIN
	 CASE 
		 WHEN achieve>90&&achieve<=100 THEN SELECT 'A';
		 WHEN achieve>80&&achieve<=90  THEN SELECT'B';
		 WHEN achieve>60&&achieve<=80  THEN SELECT'C';

		 ELSE 'D';
	END CASE;
END$













