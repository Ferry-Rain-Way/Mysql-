

+库管理----------------BEGIN----------------------------+
# 建库
 CREATE DATABASE IF NOT EXISTS books;
	-- 

# 修改库的字符集
 ALTER DATABASE books  CHARACTER SET gbk;


# 删除库
 DROP DATABASE books;


+-------------------END----------------------------------+



+表管理


++1.建表----------------BEGIN--------------------+
# 1.建表
	## 建表1
	CREATE TABLE book (
		id 	 INT,		-- 图书编号
		bName	 VARCHAR(20), 	-- 图书名
		price    DOUBLE,	-- 价格
		authorId  INT,		-- 作者编号
		publishDate DATETIME	-- 出版日期
	);

	## 建表2
	CREATE TABLE IF NOT EXISTS author(
		id INT,
		au_name VARCHAR(20),
		nation VARCHAR(10)
	);

++-------------------END-------------------------+




++2.表的修改------------BEGIN--------------------+
# 2.表的修改

##_1 更改列名 【change】
-- alter table 表名 change column   原列名  更改后列名 更改后类型
ALTER TABLE `author` CHANGE COLUMN `au_name`  author_Name VARCHAR(20);


##_2 更改列的类型或约束【modif】
-- alter table 表名 modify column  原列名  更改类型/约束
   ALTER TABLE `book` MODIFY COLUMN  `id` DOUBLE;

##_3 添加新的列【add】
-- alter table 表名 add column  列名  列类型
   ALTER TABLE `book` ADD COLUMN  annual DOUBLE;
   
##_4 删除列【drop】
-- alter table 表名 drop column  列名  
   ALTER TABLE `book` DROP COLUMN  annual;

##_5 修改表名【rename to】
-- alter table  原表名 rename to 新表名
   ALTER TABLE  books  RENAME TO book_author;


++-------------------END----------------------+



++3.表的删除------------BEGIN--------------------+
# drop
DROP TABLE book_author;

通常先删在创
DROP TABLE IF EXISTS 旧表名;
CREATE TABLE 表名(

)

+------------------------END---------------------+


++4.表的复制------------BEGIN--------------------+
/*
表的复制是通过在创建的过程中对
需要复制的表进行筛选的过程

1.like
CREATE TABLE cpoy LIKE author;


2.
CREATE TABLE copy2 
SELECT * 
FROM  author
where ```;

*/
INSERT INTO author VA`books`LUES
(1,'村上春树','日本'),
(2,'莫言','中国'),
(3,'冯唐','中国'),
(4,'金庸','中国');

SELECT * FROM Author;
SELECT * FROM copy2;
#1.仅仅复制表的结构

CREATE TABLE copy LIKE author;

#2.复制表的结构+数据
CREATE TABLE copy2 
SELECT * FROM author;

#只复制部分数据
CREATE TABLE copy3
SELECT id,au_name
FROM author 
WHERE nation='中国';


#仅仅复制某些字段

CREATE TABLE copy4 
SELECT id,au_name
FROM author
WHERE 0;
	
+------------------------END---------------------+




+库与表的练习------------BEGIN--------------------+
1.
CREATE TABLE dept1 (
	id 	INT(7),
	`name` 	VARCHAR(25)
);

2.
USE `myemployees`;
CREATE TABLE dept2
SELECT * FROM `departments`;


`跨库的操作`
CREATE TABLE dept2
SELECT * FROM myemployees.`departments`;

3.
CREATE TABLE emp5 (
	id 		INT(7),
	First_name 	VARCHAR(25),
	Last_name	VARCHAR(25),
	Dept_id		INT(7)
);

4.
ALTER TABLE `emp5` MODIFY COLUMN `Last_name` VARCHAR(50);


5.
CREATE TABLE empl`employees2`oyees2 LIKE `myemployees`.employees;

6.
DROP TABLE IF EXISTS emp5;`test`

7.
ALTER TABLE `employees2` RENAME TO emp5;


8.
ALTER TABLE emp5 ADD COLUMN test_column INT;
ALTER TABLE dept1 ADD COLUMN test_column INT;


9.

ALTER TABLE emp5 DROP dept_id;
DESC emp5;
ALTER TABLE emp5 DROP test_column;
+------------------------END---------------------++



+------------------BEGIN---------------------------+
`
分类

tiny--  1
small-- 2
medium-- 3
int  4
big--  8


注意：
1 以上为清除看到重点，int 用 -- 代替
	如 tiny-- 1 代表tinyint，占用1个字节

2 int 也可写作 integer

3 从上向下，做占用字节逐渐增大
`
+------------------------END---------------------+



+------------------BEGIN---------------------------+

# 01 无符/有符
-- -------------------------
CREATE TABLE test_int1 (
	t1 INT
);

DESC test_int1;

INSERT INTO test_int1
SET t1 = -1;

SELECT * FROM test_int1; 
-- 插入成功，说明 int 默认为有符号的
-- -------------------------


DROP TABLE  IF EXISTS test_int; -- 删除

CREATE TABLE test_int2 (
	t1 INT ,
	t2 INT UNSIGNED
);


INSERT INTO test_int2 
SET t1 = -1,
    t2 = -2; -- 受到警告 且查看结果为 0
	     -- 插入失败 ,说明 无符类型设置成功


SELECT * FROM test_int2; 
DESC test_int2 ;
+------------------------END---------------------+




+------------------BEGIN---------------------------+

# 02 超出范围,默认添加临界值
INSERT INTO test_int2
SET t2= 1000000000000000000000;

/*
Warning Code : 1264
Out of range value for column 't2' at row 1
例如：以上警告会插入数值：4294967295
*/

INSERT INTO test_int2
SET t2 = 4294967295 + 1; -- 依旧警告 -- 插入临界值

INSERT INTO test_int2
SET t2 = 4294967295 -1; -- 成功


+------------------------END---------------------+



+------------------BEGIN---------------------------+

# 03
CREATE TABLE test_int3(
	t1 INT (4) ZEROFILL -- 下按时的最大长度
			    -- 必须搭配 zerofill 使用
);

DESC test_int3;

INSERT INTO test_int3
SET t1 = 23;

SELECT * FROM test_int3; 

+-------------------END----------------------------+


+------------------BEGIN---------------------------+
小数：
      1.浮点型
	FLOAT(M,D)
	DOUBLE(M,D)

      2.定点型
	DEC(M,D)
	DECIMAL(M,D)
	
	
-- -----------------------------------------
M:整数部位+小数部位的总长度
D:小数点部位长度
M与D均可省略


CREATE TABLE tab_float (
	f1 FLOAT(6,2),
	f2 DOUBLE(6,2),
	f3 DECIMAL(6,2)
	
);

SELECT * FROM tab_float;

1.正确
INSERT INTO tab_float 
SET 	f1 = 1234.56,-- OK 
	f2 = 1234.56,-- OK 
	f3 = 1234.56 -- OK 

	

2.小数部位过长，结果四舍五入
INSERT INTO tab_float 
SET 	f1 = 1234.567,-- ok 结果四舍五入，不报错
	f2 = 1234.567,-- ok 结果四舍五入，不报错
	f3 = 1234.567 -- Warning 可执行，结果四舍五入，定点数


3.总位数正确，但整数位位数偏大
INSERT INTO tab_float 
SET 	f1 = 15234.6,-- Warning
	f2 = 15234.6,-- Warning
	f3 = 15234.6 -- Warning
	
直接插入小于M长度的最大值
(M,D) = (5,2)
插入：(M-D).D
999.99


(M,D) = (6,2)
插入：(M-D).D
999.99


(M,D) = (4,3)
插入：(M-D).D
9.999


4.(M,D)省略
CREATE TABLE tab_float2 (
	f1 FLOAT ,
	f2 DOUBLE,
	f3 DECIMAL
);

INSERT INTO tab_float2 
SET 	f1 = 15234.6,
	f2 = 15234.6,
	f3 = 15234.6 -- Warning

定点数默认为(10,0)
说以小数点后有值就会超出范围
-- ---------------------------------------------


+------------------------END---------------------+






+------------------BEGIN---------------------------+
字符型
`
较短的：
char	    长度不变  
varchar	    长度可变

较长的文本
text
blob
`
CHAR(M)		M默认为1,可以省略
VARCHAR(M)	不可省略


M:最多的字符数
"中国"两个字符

'中'3个字节


-- enum 枚举
CREATE TABLE tab_char (
	c1 ENUM('a','b','c')
);

INSERT INTO tab_char VALUE('a');
INSERT INTO tab_char VALUE('b');
INSERT INTO tab_char VALUE('c');
INSERT INTO tab_char VALUE('m');-- 列表范围外 -- 警告
INSERT INTO tab_char VALUE('A');-- 大写 OK

SELECT * FROM tab_char;



-- set类型
类似集合

CREATE TABLE tab_set(

	s1 SET('a','b','c','d')

);
INSERT INTO tab_set VALUES('a');
INSERT INTO tab_set VALUES('A,B');
INSERT INTO tab_set VALUES('a,c,d');


+------------------------END---------------------+


+------------------BEGIN-------------------------+
CREATE TABLE major(
	major_id INT PRIMARY KEY,
	major_name VARCHAR(20) UNIQUE
);
INSERT INTO major
VALUE 	(01,'计算机科学与技术'),
	(02,'电信'),
	(03,'信息管理'),
	(04,'自动化');

SELECT * FROM major;


-- 列级：默认、非空、主键、唯一【外键无效果，check无效果】
-- 表级：除了非空、默认，其他的都支持
CREATE TABLE students(
	-- 列级约束写法
	student_Number VARCHAR(20) PRIMARY KEY,
	
	-- #外键# 表级约束写法
	stu_majorid INT ,
	CONSTRAINT fk_students_major FOREIGN KEY(stu_majorid)REFERENCES major(major_id)
);


+------------------END---------------------------+



CREATE TABLE `Table_test`(

	id INT UNIQUE AUTO_INCREMENT,
	`name` VARCHAR(20)

);
UPDATE 
  table_test 
SET
  `name` = '章鱼' 
WHERE id = '1' ;

INSERT INTO Table_test 
VALUE(NULL,'张飞'),
     (NULL,'赵敏');
SELECT * FROM Table_test ;