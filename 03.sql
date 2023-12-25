USE girls;
SELECT * FROM beauty;
SELECT * FROM boys;

SELECT 
  `name`,
  boyName 
FROM
   beauty,
   boys
WHERE 
	beauty.`boyfriend_id` = boys.`id`;-- 连接条件
	
	
USE myemployees;
SELECT 
	`last_name`,`department_name`
FROM
	`employees`,`departments`
WHERE
	`employees`.`department_id`  = `departments`.`department_id`;
	
	
/*
# AS 用作表名 是替换
  原先的表明不可以在使用


use `myemployees`;

select 
	e.job_id, -- 相同字段，使用替换名时，此处也要用替换后的名字
	last_name,
	job_title
from
	employees as e,
	jobs as j
where
	e.job_id = j.job_id;

*/


SELECT
	`last_name`,
	`department_name`
FROM
	`employees` 	AS e,
	`departments` 	AS j
WHERE
	e.`department_id` = j.`department_id`
	&& e.`commission_pct` IS NOT NULL;



SELECT
	`department_name`,
	`city`
	
FROM
	`departments`,
	`locations`
WHERE
	`departments`.`location_id`= `locations`.`location_id`
	 &&`city` LIKE '_o%';


SELECT * FROM `locations`;

SELECT
	*
FROM
	`departments`
WHERE
	-- city = "Seattle";
	location_id = "1700";


# Exercise_1
-- ---------------------
SELECT 
	location_id,
	COUNT(*)
FROM
	`departments`
GROUP BY `location_id`;
-- ---------------------
SELECT
	city,
	department_id,
	COUNT(*)
FROM
	departments AS de,
	locations   AS lo
WHERE
	de.`location_id` = lo.`location_id`
GROUP BY 
	city;
	
-- ---------------------	





# Exercise_2
-- ---------------------

SELECT
	department_name,
	de.manager_id,
	MIN(salary)
FROM
	`departments` AS de,
	`employees`   AS em
WHERE
	de.`department_id` = em.`department_id`
	&& `commission_pct` IS NOT NULL
GROUP BY
	`department_name`,de.`department_id`;
	-- 保证每个部门的的经理是唯一的


-- ---------------------	


	


# Exercise_3
-- ---------------------
SELECT
	`job_title`,
	COUNT(*)
FROM
	`jobs`,
	`employees`
WHERE
	jobs.`job_id` = employees.`job_id`
	
GROUP BY `job_title`
ORDER BY COUNT(*) DESC;
	
-- ---------------------




# Exercise_4
-- ---------------------
SELECT
	`last_name`,
	 d.`department_name`,
	`city`
FROM
	`employees` e ,
	`departments` d,
	`locations` l
WHERE
	e.`department_id` = d.`department_id`
	&& d.`location_id`= l.`location_id`;
	




SELECT
	city,
	last_name,
	job_id,
	de.department_id,
	department_name
FROM
	employees 	 em,
	departments 	 de,
	locations	 lo

WHERE
	em.`department_id` = de.`department_id`
	&&de.`location_id` = lo.`location_id`
	&&city = "Toronto";

-- ----------------------------------------------
SELECT
	department_name,
	job_title,
	MIN(salary)
FROM
	`departments` 	AS de,
	`jobs` 		AS jo,
	`employees` 	AS em
WHERE
	em.`department_id` = de.`department_id`
	&&em.`job_id`= jo.`job_id`
GROUP BY
	department_name,job_title;
	

-- ----------------------------------------------
SELECT
	`country_id`,
	COUNT(*)
FROM
	`locations`	AS lo,
	`departments`	AS de
WHERE
	`lo`.`location_id` = de.`location_id`
GROUP BY
	`country_id`
HAVING
	COUNT(*)>2;
	

-- ----------------------------------------------
/*
select
	别名怎么写都行
from
	着重号/直接写 
	【不能用单引号或双引号】

-- 两处的 AS 都可以省略
-- 我都统一使用
	AS em
	AS `#特殊`
	AS `string`

*/
SELECT
	 em.`last_name`   AS 'employees',
	 em.`employee_id` AS "#Emp",
	 mg.`last_name`	  AS "manager",
	 mg.`employee_id`    "#mgr"
	
FROM
	`employees`  `#em`,
	`employees`  `mg`
WHERE
	em.`manager_id` = mg.`employee_id`
	&&em.last_name = "Kochhar";


/*CREATE TABLE job_grades
(grade_level VARCHAR(3),
 lowest_sal  int,
 highest_sal int);

INSERT INTO job_grades
VALUES ('A', 1000, 2999);

INSERT INTO job_grades
VALUES ('B', 3000, 5999);

INSERT INTO job_grades
VALUES('C', 6000, 9999);

INSERT INTO job_grades
VALUES('D', 10000, 14999);

INSERT INTO job_grades
VALUES('E', 15000, 24999);

INSERT INTO job_grades
VALUES('F', 25000, 40000);*/

#  非等值连接
SELECT * FROM `job_grades`;



SELECT 
  salary,
  grade_level 
FROM
  employees AS e,
  job_grades AS g 
WHERE salary BETWEEN g.lowest_sal AND g.highest_sal ;



# 自连接
SELECT 
	e.`last_name`	AS员工名,
	e.`employee_id`	AS员工编号,
	e.`manager_id`	AS员工领导,
	m.`last_name`	AS领导名,
	m.`employee_id` AS领导ID
	
FROM
	employees e,employees m
WHERE
	e.`manager_id` = m.`employee_id`;
	
	


-- ------------------------------
`--
# sql 199 语法

以下 inner处表示连接类型


select 
  查询列表 
from
  表 1 
  inner join 表2 
    on 连接条件 
  inner join 表3 
    on 连接条件 
  inner join 表4 
    on 连接条件
    
     
where 筛选条件 
group by ```` 
having `````` 
order by ```` 


连接类型：
内连接：inner  
外连接：左外连接 left  [outer] 
	右 - - - right [outer ] 
	全 - - - full  [outer ] 

`--
-- -------------------------------------------	
SELECT
	last_name,
	` department_name `
	
FROM 	` employees ` 	AS em INNER JOIN 
	` departments `	AS de
ON
	em.department_id = de.department_id;
-- -------------------------------------------	
	
SELECT
	last_name,
	job_title
FROM
	` employees ` AS em INNER JOIN
	` jobs `	    AS jo
ON
	em.` job_id ` = jo.` job_id `
WHERE
	last_name LIKE '%e%';
	
-- -------------------------------------------
SELECT
	` city `,
	 COUNT(*) 	AS 部门个数
FROM
	` locations ` 	AS lo  INNER JOIN
	` departments `	AS de
ON
	lo.` location_id ` = de.` location_id `
GROUP BY
	` city `
HAVING
	COUNT(*)>3;
	
-- -------------------------------------------	
SELECT 
	department_name,
	COUNT(*) AS 员工个数 
FROM
	departments AS de 
		INNER JOIN 
	employees AS em 
		ON de.` department_id ` = em.` department_id ` 
		
GROUP BY department_name 
HAVING COUNT(*) > 3 
ORDER BY COUNT(*) DESC ;

	
	
-- ---------------四表连接--------------------	
SELECT 
	last_name,
	department_name,
	job_title,
	` city `
FROM
	employees AS em 
		INNER JOIN 
	departments AS de 
		ON em.` department_id ` = de.` department_id `
		INNER JOIN 
	jobs AS j 
		ON j.job_id = em.job_id 
		INNER JOIN 
	locations AS lo
		ON lo.` location_id ` = de.` location_id `;

-- -----------------------------------------------
		
即：将		
departments AS de 
	ON em.` department_id ` = de.` department_id `
看作一个整体，


INNER JOIN 看作 ','
	
	
-- ---------------三表连接sql 199-----------------
SELECT
	last_name,
	department_name,
	job_title
FROM
	employees  ` em `
	INNER JOIN departments  ` de `
		ON em.` department_id ` = de.` department_id `
	INNER JOIN jobs  ` jo `
		ON jo.job_id = em.job_id
		
ORDER BY
	department_name DESC;
	
	
-- -----------等效于sql 192-------------------
SELECT
	last_name,
	department_name,
	job_title
FROM
	employees  ` em `,
	departments  ` de `,
	jobs jo
WHERE
	em.` department_id ` = de.` department_id `
	&& jo.job_id = em.job_id
ORDER BY
	department_name DESC;


-- ---------------------------------------------
SELECT
	last_name,
	` grade_level `
FROM
	` employees ` AS em
	INNER JOIN` job_grades ` AS jg
WHERE
	salary BETWEEN jg.` lowest_sal ` AND jg.` highest_sal `;


-- ---------------------------------------------

SELECT
	em.last_name  AS `员工姓名`,
	mgr.last_name AS `经理姓名`,
	em.manager_id AS `上级领导`,
	mgr.employee_id AS `领导编号`
FROM
	`employees` AS em
	INNER JOIN `employees` AS mgr
		ON em.`manager_id` = mgr.`employee_id`
WHERE
	em.`last_name` LIKE '%e%';
	



-- ----------------------外连接-----------------------

-- -------------自己写的---------------------------
/*

利用笛卡尔积 写的

*/
USE girls;
SELECT * FROM beauty;

SELECT
	`name`AS `女生名`,
	`boyfriend_id` AS `男朋友`,
	`boyName` AS `NULL?`,
	COUNT(*) AS  c
		
	
FROM
	`beauty` AS bt
		INNER JOIN 
	`boys`   AS `by`
WHERE
	bt.`boyfriend_id` != `by`.`id`
	
GROUP BY
	`boyfriend_id`
HAVING 
	COUNT(*)>3


-- ------------------------------------------------


SELECT
	`name`AS `女生名`,
	`boyfriend_id` AS `男朋友`,
	`boyName` AS `NULL?`,
	COUNT(*) AS  c
		
	
FROM
	`beauty` AS bt
		CROSS JOIN -- 交叉连接 -- 笛卡尔乘积
	`boys`   AS `by`
WHERE
	bt.`boyfriend_id` != `by`.`id`
	
GROUP BY
	`boyfriend_id`
HAVING 
	COUNT(*)>3



-- ------------------------------------------------



SELECT *FROM boys;
SELECT *FROM beauty;


SELECT
	b.*,
	bo.*/*boys 中的全部*/
FROM
	boys AS bo
	LEFT OUTER JOIN beauty AS b
		ON b.`boyfriend_id` = bo.id
WHERE
	b.id IS  NULL;


/*
手中拿着主表 去和 另一个表比较

去除主表中两者相同的部分，



is null 
主表剩余的填充null 


【填充的null表头是一个表中的字段】


*/


USE myemployees;

SELECT	
	d.*,
	e.employee_id,
	e.`department_id`AS 副,
	 d.`department_id` AS 主
FROM
	departments AS d
	LEFT OUTER JOIN employees AS e
		ON e.`department_id` = d.`department_id`
WHERE
	e.`department_id` IS NULL;
	
	

-- -----------------------------------------------------------
SELECT 
  d.*,
  e.employee_id,
  d.`department_id` 
FROM
  departments AS d 
  LEFT OUTER JOIN employees AS e 
    ON e.`department_id` = d.`department_id` 
WHERE e.`employee_id` <=> NULL ;
			-- is null
			

SELECT 
  d.*,
  e.employee_id,
  d.`department_id` 
FROM
  employees AS e
  RIGHT OUTER JOIN  departments AS d 
    ON e.`department_id` = d.`department_id` 
WHERE e.`employee_id`  IS  NULL ;
			-- is null



-- -----------------------------------------------
USE girls;
SELECT 
	be.`id`,
	be.`name`,
	`by`.*
FROM
	`beauty` AS be
	LEFT JOIN `boys` AS `by`
		ON `by`.`id` = be.`boyfriend_id`
WHERE
	be.`id`>3;
	


USE myemployees;
SELECT
	de.`location_id` AS 副,
	lo.`location_id` AS 主,
	city
	
FROM
	`departments` AS de
	 RIGHT  JOIN `locations` AS lo
		ON lo.`location_id` = de.`location_id`
		
		
WHERE
	de.`department_id` IS NULL;

/*
通过连接条件看那个范围大，从而
确谁是主表
*/

-- ----------------------------------------

SELECT 
	de.`department_name` AS 主,
	em.`employee_id`  AS 副,
	department_name AS 部门名,
	em.*
FROM
	`departments` AS de
	 LEFT OUTER JOIN `employees`   AS em
		ON de.department_id = em.`department_id`
	-- 有些员工没有 部门编号，
	-- 故推测departments为主表
WHERE
	-- department_name = "SAL" || department_name = "IT";
	department_name IN ("SAL","IT");	
	

-- --------------------------------------------
department_name  = "IT"
的部门有三个，
所以有的"IT" 部门有员工，有的IT部门没有员工
所以有的"IT" 部门匹配的上有的匹配不上

可以看三个"IT" 部门的department_id 
SELECT * FROM  departments
WHERE department_name = "IT";

-- ------------------------------------------------



   