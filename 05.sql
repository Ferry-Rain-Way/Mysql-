-- ----------------------------------------------------
# 1. 查询工资最低的员工信息: last_name, salary
	-- 工资最低的
	-- 员工信息: last_name, salary
	
SELECT
	last_name, 
	salary
FROM
	employees
WHERE
	salary = (
	SELECT MIN(salary)
	FROM   employees
	);
	


# 2. 查询平均工资最低的部门信息
	-- 平均工资最低
	-- 部门信息

前两种是我写的
使用 排序加LIMIT 1
这种写法在平均最低工资的部门不唯一时，
只能够查到一个部门的信息，但不唯一的概率极低

老师的第二种方法也是这种
--  -----------------------------------------------------

SELECT
	de.*
FROM
	`departments` AS de
	 RIGHT OUTER JOIN -- 或INNER OUTER JOIN
	(SELECT 	department_id
	 FROM   	employees
	 GROUP BY 	department_id
	 ORDER BY 	AVG(salary)  ASC
	 LIMIT 1
	 ) AS `avg`
		ON de.`department_id` = `avg`.department_id
-- -----------------------------------------------------------

SELECT
	de.*
FROM
	`departments` AS de
WHERE
	department_id = (
	 SELECT  department_id
	 FROM   employees
	 GROUP BY department_id
	 ORDER BY AVG(salary)  ASC
	 LIMIT 1
	);
	
老师写的：// 查询平均工资最低的部门信息
SELECT d.*
FROM departments d
WHERE d.`department_id`=(
	SELECT department_id
	FROM employees
	GROUP BY department_id
	HAVING AVG(salary)=(
		SELECT MIN(ag)
		FROM (
			SELECT AVG(salary) ag,department_id
			FROM employees
			GROUP BY department_id
		) ag_dep

	)

);








# 3. 查询平均工资最低的部门信息和该部门的平均工资
	
SELECT
	de.*,`avg_salary`
FROM
	`departments` AS de,
	(SELECT department_id,AVG(salary) AS `avg_salary`
	 FROM   employees
	 GROUP BY department_id
	 ORDER BY AVG(salary)  ASC
	 LIMIT 1
	 ) AS `avg`
WHERE
	de.`department_id` = `avg`.department_id


# 4. 查询平均工资最高的 job 信息
SELECT
	`jobs`.*
FROM
	`jobs`
WHERE
	 `job_id` = (
	 SELECT    `job_id`
	 FROM      `employees`
	 GROUP BY  `job_id`
	 ORDER BY   AVG(salary)  DESC
	 LIMIT 1
	);
	



# 5. 查询平均工资高于公司平均工资的部门有哪些?

+-----------------------------------------------------------+
错误代码块：SELECT * FROM employees
"-- ---------
SELECT                                                      
	departments.* /* departments.*  / department_name */
from 							    
	`departments`
	
-- ---------"
WHERE
	`department_id` IN (
	/*SELECT    DISTINCT  department_id
	FROM     `employees`
	GROUP BY  department_id
	HAVING    AVG(salary) >(
		    SELECT AVG(salary)
		    FROM   employees)*/
	);	
	

分析：使用注释掉的代码足以将题目要求的部门筛选
      出来，共计8个，其中有一个department_id = NULL
      当再次使用departments中的department_id进行
      核对时，由于department_id是departments
      中的主键，始终中不为空的，所以NULL的那个就会被
      过滤掉，为7个，导致结果的错误
+-----------------------------------------------------------+
正确的答案：
SELECT    DISTINCT  department_id
FROM     `employees`
GROUP BY  department_id
HAVING    AVG(salary) >(
	    SELECT AVG(salary)
	    FROM   employees)
	


#6. 查询出公司中所有 manager 的详细信息.
SELECT
	employees.*
FROM
	`employees`
WHERE
	`employee_id` IN ( -- =  ANY/SOME
	SELECT	DISTINCT `manager_id`
	FROM    `employees` -- 19个
	);
-- 最终结果 18个，有一个为null被过滤了

#7. 各个部门中 最高工资中最低的那个部门的 最低工资是多少


1.找每个部门的最高工资
2.从1中找到最低的
3.看他所在部门的最低工资

SELECT   salary,department_id
FROM 	 employees
WHERE    department_id = (
	  SELECT   department_id
	  FROM     employees
	  GROUP BY department_id
	  ORDER BY MAX(salary) ASC
	  LIMIT	 0,1
	  )
GROUP BY department_id

-- ----------------------	
SELECT   MIN(salary)
FROM 	 employees
WHERE    department_id = (
	  SELECT   department_id
	  FROM     employees
	  GROUP BY department_id
	  ORDER BY MAX(salary) ASC
	  LIMIT	 0,1
	  )



	









#8. 查询平均工资最高的部门的 manager 的详细信息: last_name, department_id, email, salary
SELECT 
	last_name,
	department_id,
	email,
	salary 
FROM
	`employees`
WHERE   
	`employee_id`IN (
	  SELECT  DISTINCT `manager_id`
	  FROM    `employees`
	  WHERE   `department_id` = (
			SELECT     department_id
			FROM       employees
			GROUP BY   department_id 
			ORDER BY   AVG(salary) DESC
			LIMIT 0,1)
		 
	);

我是从employees表中找的 类似于自连接
拿到manager_id 后从employees表中再找
-- -----------------------------------------
老师的
拿到
manager_id 后从departments表中再找
SELECT 
	last_name, d.department_id, email, salary 
FROM
	employees e 
	INNER JOIN departments d 
		ON d.manager_id = e.employee_id 
WHERE d.department_id = 
	(SELECT 
	    department_id 
	FROM
	    employees 
	GROUP BY department_id 
	ORDER BY AVG(salary) DESC 
	LIMIT 1) ;	

	
SELECT DATEDIFF("2022-02-27",NOW())


SELECT employees.`department_id`
FROM employees;

	
	
-- ---------------------------------------------
DML 增删改
/*

insert into
	表（）
value

*/

SELECT * FROM `beauty`;


INSERT INTO 
	beauty(`id`,`name`,`sex`,`borndate`,`phone`,`photo`,`boyfriend_id`)
VALUE(0,'薇尔莉特','女','2003-11-5','18952288876',NULL,5);
	


UPDATE beauty
SET boyfriend_id = '5'
WHERE	NAME = '薇尔莉特';




INSERT INTO 
	boys(`id`,`boyName`,`userCP`)
	VALUE(5,'少佐',10000);







UPDATE beauty
SET NAME = '周迅'
WHERE NAME LIKE '苍%'

	
UPDATE 	beauty	
SET 	phone = '114'
WHERE	boyfriend_id = (
	SELECT id
	FROM   boys
	WHERE  `boyName` = "张无忌"
	)
	
-- -------------------------------



UPDATE	
	boys AS bo
	INNER JOIN beauty AS b	
		ON bo.id = b.boyfriend_id
SET	b.phone = '115'
WHERE   bo.boyName = '张无忌'
	
	
	
UPDATE	
	boys AS bo
	RIGHT JOIN beauty AS b	
		ON bo.id = b.boyfriend_id	
SET     b.`boyfriend_id` = 2
WHERE   bo.id IS NULL;

	
	

	
	
DELETE FROM
	beauty
WHERE
	id IN (16,17,15)

	
TRUNCATE TABLE beauty;
	

	-- 此处没有s
	-- create datebase




CREATE DATABASE `ヴァイオレット・エヴァーガーデン`;

DROP  DATABASES IF EXISTS books;


+-------------------------------+
-- 建库
CREATE DATABASE IF NOT EXISTS books;
-- 建表



+-------------------------------+

	
	

	
	

	
	
	
	
	