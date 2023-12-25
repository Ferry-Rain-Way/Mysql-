
#进阶7：子查询
/*
含义：
出现在其他语句中的select语句，称为子查询或内查询
外部的查询语句，称为主查询或外查询

分类：
按子查询出现的位置：
	select后面：
		仅仅支持标量子查询
	
	from后面：
		支持表子查询
	where或having后面：★
		标量子查询（单行） √
		列子查询  （多行） √
		行子查询
		
	exists后面（相关子查询）
		表子查询
按结果集的行列数不同：
	标量子查询（结果集只有一行一列）
	列子查询（结果集只有一列多行）
	行子查询（结果集一行多列或多行多列）
	表子查询（结果集“一般”为多行多列）
*/

`--
列子查询，固定一列
行子查询，固定一行

标量子查询 ，固定只有一个结果
表子查询   无所谓
`--

#一、where或having后面
/*
1、标量子查询（单行子查询）
2、列子查询（多行子查询）

3、行子查询（多列多行）

特点：
①子查询放在小括号内
②子查询一般放在条件的右侧
③标量子查询，一般搭配着单行操作符使用
> < >= <= = <>

列子查询，一般搭配着多行操作符使用
in、any/some、all

④子查询的执行优先于主查询执行，主查询的条件用到了子查询的结果

*/


#1.标量子查询★

#案例1：谁的工资比 Abel 高?

#①查询Abel的工资

SELECT 
	salary
FROM
	employees
WHERE
	last_name  = "Abel";

#②查询员工的信息，满足 salary>①结果
SELECT 
  last_name,
  salary 
FROM
  employees 
WHERE salary > 
  (SELECT 
    salary 
  FROM
    employees 
  WHERE last_name = "Abel" -- 子查询的部分不用加分号
  ) ;

#案例2：返回job_id与141号员工相同，salary比143号员工多的员工 姓名，job_id 和工资

SELECT
	last_name AS 员工姓名,
	job_id,
	salary
FROM
	employees
WHERE
	job_id = (
	  SELECT job_id 
	  FROM employees 
	  WHERE employee_id = "141"
	)
	&&
	salary > (
	  SELECT salary
	  FROM employees 


	  WHERE employee_id = "143"
	);


#案例3：返回公司工资最少的员工的last_name,job_id和salary

SELECT
	last_name AS 员工姓名,
	job_id,
	salary
FROM
	employees
WHERE
	salary =  (
	  SELECT MIN(salary)
	  FROM employees 
	);



#案例4：查询最低工资大于50号部门最低工资的部门id和其最低工资

SELECT
	department_id ,
	MIN(salary)
FROM
	employees
GROUP BY
	department_id
HAVING 
	MIN(salary)> -- 计算每个部门的最低工资
	(
	   SELECT MIN(salary) -- 计算 50 号 部门的最低工资
	   FROM   employees
	   WHERE  department_id = "50"
	)
	



#非法使用标量子查询
--  单行操作符后的 子查询结果为空 或为多行




#2.列子查询（多行子查询）★
#案例1：返回location_id是1400或1700的部门中的所有员工姓名


# _1使用内连接
SELECT
	last_name,
	location_id
FROM
	`departments` AS de
	INNER JOIN `employees` AS em
		ON de.department_id = em.department_id
WHERE
	location_id IN (1400,1700);
	

# _2
SELECT
	last_name
FROM
	employees
WHERE
	department_id IN 
	(
	   SELECT department_id
	   FROM   departments
	   WHERE
		location_id IN(1400,1700)
	);

#案例2：返回其它工种中比job_id为‘IT_PROG’工种任一工资低的           员工的员工号、姓名、job_id 以及salary
SELECT
	`employee_id`,
	`last_name`,
	`job_id`,
	`salary`
FROM
	`employees`
WHERE
	salary < SOME 
	(
	SELECT	DISTINCT salary
	FROM 	`employees`
	WHERE	`job_id` = "IT_PROG"
	)
	&& job_id <>"IT_PROG";



#或
SELECT
	`employee_id`,
	`last_name`,
	`job_id`,
	`salary`
FROM
	`employees`
WHERE
	salary <  
	(
	SELECT	MAX(salary)
	FROM 	`employees`
	WHERE	`job_id` = "IT_PROG"
	)
	AND job_id <>"IT_PROG";


#案例3：返回其它部门中比job_id为‘IT_PROG’部门所有工资都低的员工   的员工号、姓名、job_id 以及salary
SELECT
	`employee_id`,
	`last_name`,
	`job_id`,
	`salary`
FROM
	`employees`
WHERE
	salary < ALL
	(
	SELECT	salary
	FROM 	`employees`
	WHERE	`job_id` = "IT_PROG"
	)
	AND job_id <>"IT_PROG";


#或

SELECT
	`employee_id`,
	`last_name`,
	`job_id`,
	`salary`
FROM
	`employees`
WHERE
	salary <
	(
	SELECT	MIN(salary)
	FROM 	`employees`
	WHERE	`job_id` = "IT_PROG"
	)
	AND job_id <>"IT_PROG";


#3、行子查询（结果集一行多列或多行多列）

#案例：查询员工编号最小并且工资最高的员工信息
SELECT *
FROM
	employees
WHERE
	employee_id = (
	  SELECT MIN(employee_id)
	  FROM   employees
	  WHERE
		salary = (
		SELECT MAX(salary)
		FROM  employees
		-- where employee_id <> "100"
		-- 可执行，结果正确，说明 where可以嵌套
		)
	)

-- 等效于
SELECT 
	*
FROM
	employees
WHERE
	employee_id = (
	  SELECT MIN(employee_id)
	  FROM   employees
	) 
	AND
	salary = (
	SELECT MAX(salary)
	FROM  employees
	)                                                                                                                                               

-- 等效于
SELECT	
	*
FROM
	employees
WHERE
	(employee_id,salary) = (
	SELECT MIN(employee_id),MAX(salary)
	FROM   employees
	)


 

#二、select后面
/*
仅仅支持标量子查询



*/

#案例：查询每个部门的员工个数
SELECT
	de.*,
	(SELECT COUNT(*)
	 FROM employees AS em
	 WHERE de.department_id= em.department_id) AS 个数
FROM 	departments AS de;
	


 
 
 #案例2：查询员工号=102的部门名
 SELECT
	(
	 SELECT department_name
	 FROM   departments AS de,
		employees   AS em
	 WHERE  de.`department_id` = em.department_id
	 	&&em.employee_id = "102"
	 
	 ) AS `102员工号`;

	
/*
对 select 后 （） 
我的理解
-- 在输出某一字段的全部内容时增加了筛选

select 
	输出的所有字段,
	(
	 select 通过该字段进行筛选
	 from   筛选字段来源的表
	 where  筛选条件 ) as  别名
	 
from   输出所有字段来源的表
*/

#三、from后面
/*
将子查询结果充当一张表，要求必须起别名
*/

#案例：查询每个部门的平均工资的工资等级
SELECT
	agdep.*,
	g.`grade_level`
FROM
	`job_grades` g,
	(
	SELECT	  department_id,AVG(salary) AS ag 
	FROM  	  employees
	GROUP BY  department_id
	) AS agdep -- 一定要起别名
 WHERE	
	agdep.ag BETWEEN lowest_sal AND highest_sal;




















#四、exists后面（相关子查询）

/*
语法：
exists(完整的查询语句)
结果：
1或0



*/


#案例1：查询有员工的部门名
SELECT	
	department_name,
	em.department_id
FROM
	employees AS em
	INNER JOIN `departments` AS de
		ON de.department_id = em.department_id
GROUP BY
	department_name
HAVING 
	COUNT(*) IS  NOT NULL;
	

	
#in
SELECT 
	department_name,
	department_id
	
FROM
	departments AS de
WHERE
	department_id IN (
	SELECT department_id
	FROM   employees AS em
	WHERE  de.`department_id` = em.`department_id`
	);

#exists
SELECT 
	department_name,
	department_id
	
FROM
	departments AS de
WHERE
	EXISTS (
	SELECT *
	FROM   employees AS em
	WHERE  de.`department_id` = em.`department_id`
	);
	

-- ----------------------------------------------------------

# 01 查询和Zlotkey相同部门的员工姓名和工资
SELECT
	last_name,
	salary,
	department_id
FROM
	employees
WHERE
	department_id = (
	SELECT department_id
	FROM   employees
	WHERE  last_name = "Zlotkey"
	);

# 02 查询工资比公司平均工资高的员工的员工号，姓名和工资。
SELECT
	employee_id,
	last_name,
	salary
FROM
	employees
WHERE
	salary > (
	SELECT AVG(salary)
	FROM   employees
	);

# 03 查询各部门中工资比本部门平均工资高的员工的员工号, 姓名和工资
-- ---------------------- ★
SELECT 
	-- employee_id,
	-- last_name,
	-- salary
	departavg.*,em.*
FROM
	employees AS em,
	(
	SELECT AVG(salary) AS ag,department_id
	FROM   employees AS em
	GROUP BY department_id) AS departavg
	
WHERE
	em.department_id  = departavg.department_id
	&& em.`salary` > departavg.ag;
-- --------------------------------------------------------------------
# 04 查询和姓名中包含字母u的员工在相同部门的员工的员工号和姓名
解法1
SELECT 
	employee_id,
	last_name
FROM
	employees AS em
		INNER JOIN
	(
	SELECT 	DISTINCT department_id
	FROM    employees
	WHERE   last_name LIKE "%u%") AS U_name
		ON em.department_id = U_name.department_id


-- ---------
解法2 老师的解法
SELECT 
	employee_id,
	last_name
FROM
	employees
WHERE
	department_id IN (
	-- 字母u的员工的部门
	SELECT 	DISTINCT department_id
	FROM    employees
	WHERE   last_name LIKE "%u%");
		

-- ------------------------------------------------------
# 05 查询在部门location_id为1700的部门工作的员工的员工号
SELECT
	employee_id
FROM
	employees
WHERE
	department_id IN (
	-- location_id为1700的部门
	  SELECT DISTINCT department_id
	  FROM   departments
	  WHERE  location_id = "1700"
	);

-- ------------------------------------------------------
# 6. 查询管理者是King的员工姓名和工资
SELECT  
	last_name,
	salary
FROM
	employees
WHERE
	manager_id IN ( -- 1. "=  ANY" 2."SOME" 3."IN"
	-- 管理者是King
	SELECT	employee_id
	FROM 	employees
	WHERE	last_name = "K_ing"
	);


-- ------------------------------------------------------
# 7.查询工资最高的员工的姓名，
-- 要求first_name和last_name显示为一列，列名为 姓.名
SELECT 
	CONCAT(first_name,last_name) AS `姓.名`
FROM
	employees
WHERE
	salary = (
	  -- 工资最高
	  SELECT MAX(salary)
	  FROM   employees
	)




-- ---------------------------------------------
/*
分页查询

limit	 offter 		size
	起始索引		条目个数
      
      
use myemployees;
select 
	*
 from
	employees
limit 0,5;
索引从0 开始

只有一个数n ：
	就表示索引从 第一个 开始的 n个内容

两个数就表示 offter 		size
	从offter+1 开始的 size 个内容


查询第 a - b 的内容
limit a-1 , b-a+1;



查询第 11 - 25 的内容
limit 10 ,15;(11-1,25-11+1=)



select 查询列表
from 表
limit (page-1)*size,size;

size=10
page  
1	0
2  	10
3	20




*/
/*
isnull(expr)


if(expr==NULL)
	return 1;
else
	return 0;
*/




SELECT employees.*
FROM   employees
WHERE  `commission_pct`  IS NOT NULL
			-- ISNULL(`commission_pct` )<>1
			-- ISNULL(`commission_pct` )=0
			-- `commission_pct` IS NOT NULL 
			
ORDER BY salary DESC
LIMIT 10;

