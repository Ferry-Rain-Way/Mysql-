# 1. 查询工资大于12000的员工姓名和工资
SELECT
	last_name,
	salary
FROM
	employees
WHERE
	salary > 12000;


# 2. 查询员工号为176的员工的姓名和部门号和年薪
SELECT
	last_name,
	department_id,
	salary*12*(1+IFNULL(commission_pct,0))AS 年薪

FROM
	employees
WHERE
	employee_id=176;

# 3. 选择工资不在5000到12000的员工的姓名和工资
USE `myemployees`;
SELECT
	last_name,
	salary
FROM
	employees
WHERE
	-- not (salary BETWEEN 5000 AND 12000);
	 (salary >=0 AND salary <5000) OR salary >12000;
	-- not(salary>=5000 and salary <=12000);



# 4. 选择在20或50号部门工作的员工姓名和部门号

SELECT
	CONCAT(last_name,first_name) AS 姓名,
	department_id AS 部门号
FROM
	employees
WHERE
	department_id=20 || department_id=50;


# 5. 选择公司中没有管理者的员工姓名及job_id
SELECT
	CONCAT(last_name,first_name),
	job_id

FROM
	employees
WHERE
	ISNULL(manager_id);
	-- ISNULL(manager_id)=1;
/*
ISNULL(A);
可理解为：
if(A==NULL)
	return 1;
else
	return 0;

*/

# 6. 选择公司中有奖金的员工姓名，工资和奖金级别

SELECT
	CONCAT(last_name,first_name),
	`salary`,
	`commission_pct`
FROM
	employees
WHERE
	-- not isnull(commission_pct);
	-- !ISNULL(commission_pct);
	ISNULL(commission_pct)=0;




# 7. 选择员工姓名的第三个字母是a的员工姓名
SELECT
	last_name
FROM
	employees
WHERE
	last_name LIKE '__a%';



# 8. 选择姓名中有字母a和e的员工姓名
SELECT
	last_name
FROM
	employees
WHERE
	last_name LIKE '%a%e%'||last_name LIKE '%e%a%';

# 9. 显示出表employees表中 first_name 以 'e'结尾的员工信息
SELECT
	first_name
FROM
	employees
WHERE
	first_name LIKE '%e';


# 10. 显示出表employees部门编号在80-100之间 的姓名、职位
SELECT
	last_name,
	job_id
FROM
	employees
WHERE
	department_id BETWEEN 80 AND 100 ;
	/**
	对于betweent di and
	*/


# 11. 显示出表employees的manager_id 是 100,101,110 的员工姓名、职位
SELECT
	last_name,
	job_id
FROM
	employees
WHERE
	manager_id IN (100,101,110);

