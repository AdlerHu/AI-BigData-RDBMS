# Edit -> Format -> UPCASE Keyword 關鍵字大寫
# Decimal(4) 表示4位數的整數
# VARCHAR(30) 表示可以放30個字,不是byte

CREATE TABLE employee(
	empno		DECIMAL(4)	PRIMARY KEY,
    ename		VARCHAR(30)	NOT NULL,
	hiredate	DATE		NOT NULL,
	salary		INT			NOT NULL,
    deptno		DECIMAL(3)	NOT NULL,
	title		VARCHAR(20)	NOT NULL
);


CREATE TABLE `db01`.`department` (
  `deptno` DECIMAL(3) NOT NULL,
  `dname` VARCHAR(30) NOT NULL,
  `mgrno` DECIMAL(4) NULL,
  PRIMARY KEY (`deptno`));

SHOW TABLE STATUS IN db01;
SHOW TABLES;

-- table structer
DESC employee;  

DESC t;
CREATE TABLE t(a INT, b DOUBLE, c CHAR(10));

# ADD 關鍵字用來加入欄位
ALTER TABLE t ADD d VARCHAR(30);
ALTER TABLE t ADD e VARCHAR(30) FIRST;
ALTER TABLE t ADD f VARCHAR(30) AFTER d;

# MODIFY 關鍵字用來修改資料型態
ALTER TABLE t MODIFY e INT;

# CHANGE 關鍵字用來修改名稱或定義
ALTER TABLE t CHANGE d D VARCHAR(30);

# DROP 關鍵字用來刪除
ALTER TABLE t DROP c;

ALTER TABLE t RENAME t1;
DROP TABLE t1;

CREATE TABLE employee1 LIKE employee;
DESC employee1;
DROP TABLE employee1;