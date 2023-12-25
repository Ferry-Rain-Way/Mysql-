USE myemployees ;

SELECT NOW() AS 当前时间 ;

SELECT CURDATE() AS `curdate`;

SELECT CURTIME()AS `curtime`;


SELECT MONTH('2014-07-09');
SELECT MONTH('2014.07.09');
SELECT MONTH('20140709');

SELECT YEAR(NOW());


SELECT MONTHNAME(NOW()) AS `月份英文名`;

-- SELECT str_to_date('9-13-1999','%m-%d-%Y');
SELECT STR_TO_DATE('10.0.25','%m.%d.%y');


/*
4位的年份 Y 大写		2021	%Y
2···年份 y 小写[21世纪]	21	%y

月份：01/01/03/·····/11/12		%m
      1/2/3/......../11/12		%c

日：01/02/03/........			%d
    24小时制				%H
    12小时制				%h

分钟：00/01/02·······59			%i

秒种：00/01/02·······59			%s

*/
USE myemployees;

SELECT
	*
FROM
	employees

WHERE
	STR_TO_DATE('1992.4 3','%Y.%c %d')=`hiredate`

ORDER BY salary DESC;-- ASC


SELECT
	  DATE_FORMAT(`hiredate`,'%Y年%m月%d日') AS DATE

FROM
	employees

WHERE
	hiredate = '2014-03-05 ';

	-- date = '%2014年03月05日';//error 没有DATE表，
	-- 该表是虚拟的，不存在的



IF(expr1,expr2,expr3);
-- if(expr1,expr2,expr3);
-- 参照三目运算符看,等效于
-- expr1 ? expr2 : expr3 ;
SELECT
  salary,
  `commission_pct`,
  -- if(commission_pct is null,'呜呜','嘿嘿')
   IF(ISNULL(commission_pct),'呜呜','嘿嘿')
FROM
	employees;



/*--------------------------------------
case 带判断字段/表达式
	when	常量  then	值/语句
	when	常量  then	值/语句
	when	常量  then	值/语句

else
	其余情况下值/语句
end;
---------------------------------------
 select
	salary,department_id,
	 case department_id
		 when 30 then	salary*1.1
		 when 40 then	salary*1.2
		 when 50 then	salary*1.3

		 else salary
	 end

	-- end as 新工资

from
	employees;


/*--------------------------------------
case
	when 条件1	then



 */

# Exercise_1
SELECT NOW();




# Exercise_2
SELECT
	`employee_id`,
	`last_name`,
	`salary`,
	`salary`*(1+0.2) AS `new salary`
FROM
	`employees`;


# Exercise_3
SELECT
	last_name ,
	LENGTH(last_name),
	SUBSTR(last_name,1,1) AS 首字符
FROM
	employees
ORDER BY 首字符 ASC;
-- ORDER BY last_name ASC;



# Exercise_4

SELECT
	last_name,
	job_id AS job,
	CASE job_id
		WHEN "AD_PRES" THEN 'A'
		WHEN "ST_MAN"  THEN 'B'
		WHEN "IT_PROG" THEN 'c'
		WHEN "SA_REP"  THEN 'D'
		WHEN "ST_CLERK"THEN 'E'

		ELSE 	"其他"
	END AS grade

FROM
	employees
WHERE
	last_name="K_ing" && job_id="AD_PRES";
 # where这里不能使用起的别名




# 字符型
# select avg(last_name) from employees; --无意义0
# select sum(last_name) from employees; --无意义0

SELECT COUNT(last_name) FROM employees; -- true
SELECT MAX(last_name) FROM employees;	-- true
SELECT MIN(last_name) FROM employees;	-- true

#AVG 忽略null
SELECT AVG(IFNULL(`commission_pct`,0)) FROM employees;-- 0.072897
SELECT AVG(`commission_pct`) FROM employees; -- 0.222857



SELECT COUNT(2) FROM employees;


SELECT
  COUNT(*)
FROM
  employees ;

SELECT
  COUNT(*),
  employee_id
FROM
  employees ;

-- employee_id 无意义 受到count函数的限制，只显示随机的一行

# Exercise_1
SELECT
	MAX(salary),MIN(salary),AVG(salary),SUM(salary)
FROM
	employees;

# Exercise_2

SELECT
	MAX(`hiredate`),
	MIN(`hiredate`),

	DATEDIFF(MAX(`hiredate`),MIN(`hiredate`)) AS 相差天数
FROM
	employees;



SELECT
  COUNT(`employee_id`)
FROM
  employees
WHERE `department_id` = 90 ;

SELECT DATEDIFF('2021-12-27','2001-11-5');

SELECT DATEDIFF('2022-2-27',NOW();

# 分组查询
SELECT
  MAX(salary),
  job_id
FROM
  employees
GROUP BY job_id ;




SELECT
  `location_id`,
  COUNT(*) -- count(distinct `department_id`)
FROM
  departments
GROUP BY `location_id` ;




SELECT
	`department_id` AS 部门编号,
	`email`		AS 邮箱,
	AVG(`salary`) 	AS 平均工资
FROM
	`employees`
WHERE
	email LIKE '%a%'
GROUP BY `department_id`;




SELECT
  `manager_id` AS 领导,
  MAX(salary)
FROM
  employees
WHERE `commission_pct` IS NOT NULL
GROUP BY `manager_id` ;




SELECT
	`department_id`,
	COUNT(*)
FROM
	`employees`

GROUP BY
	`department_id`
HAVING
	COUNT(*)>2;
/*
根据分组之后的结果
    -- 产生的一个虚拟的不存在的表
	再次查询
分组之后，不在使用where，改成having

*/


SELECT
	`job_id`,
	MAX(salary)
FROM
	`employees`
WHERE
	  `commission_pct` IS NOT NULL
GROUP BY
	`job_id`
HAVING
	MAX(`salary`)>12000 ;


SELECT
	`manager_id` AS 领导编号,
	MIN(salary)  AS 最低工资,
	`employee_id`AS 员工编号
FROM
	`employees`
WHERE
	manager_id>102
GROUP BY
	领导编号
HAVING
	最低工资>5000&& MIN(employee_id)>168;


/*------------------
我的总结：

select
	分组依据[如：job_id字段/分组函数]
	其他待输出表头信息
from
	原始表
where
	由原始表可进行的筛选
group by
	分组依据1,[分组依据2][顺序可调换]
having
	对分组后的“虚拟表”进行的筛选，
	即：分组后才能做的判断

	-- 有分组函数的判断 [AVG(salary)>12000]
	-- 例如：每组的最小值，最大值等



注解：
-- ①能用where筛选就优先使用where筛选
-- ②where 可以省略，根据需求写


------------------*/
/*--
目前学到的

order by
group by
having
可以使用别名

where 不能用别名
*/
SELECT
  COUNT(*) AS empNum,
  LENGTH(last_name) AS nameLength
FROM
  employees
GROUP BY nameLength
HAVING empNum > 5 ;


SELECT
  department_id,
  job_id,
  AVG(salary)
FROM
  employees
GROUP BY department_id, job_id
HAVING AVG(salary) > 10000
ORDER BY AVG(salary) ASC ;

/*-- 顺序可以颠倒表示
  -- 表示员工的department_id,ob_id都相同时分到一组
*/

# Exercise_1
SELECT
	job_id,
	MAX(salary) AS 最大值,
	MIN(salary) AS 最小值,
	AVG(salary) AS 平均值,
	SUM(salary) AS   总和
FROM
	employees
GROUP BY job_id
ORDER BY job_id ASC;


# Exercise_2
SELECT
  salary,
  MAX(salary) AS 最大值,
  MIN(salary) AS 最小值,
  MAX(salary) - MIN(salary) AS DIFFERNCE
FROM
  employees ;


# Exercise_3
SELECT
  `manager_id`,
  MAX(salary) AS 最大值,
  MIN(salary) AS 最小值
FROM
  employees
WHERE manager_id -- 或 `manager_id`is not null /!(manager_id IS NULL)
GROUP BY `manager_id`
HAVING MIN(salary) > 6000 ;



# Exercise_4
SELECT
  `department_id`,
  COUNT(*),
  AVG(salary)
FROM
  employees
GROUP BY `department_id`
ORDER BY AVG(salary) DESC ;






# Exercise_5

SELECT
	job_id,
	COUNT(DISTINCT job_id)
FROM
	`employees`
GROUP BY
	job_id;



