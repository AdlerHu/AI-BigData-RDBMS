SELECT * FROM employee;
SELECT ename , salary FROM employee;

# DIV表示取商數,運算裡有null結果就會是null
SELECT 17/4 , 17 DIV 4 , 17%4 , 17+NULL;

# 想要取的別名如果有空白字元一定要用單引號
SELECT ename AS '員工姓名' , salary *12 AS '年薪' FROM employee;
SELECT ename AS 員工姓名 , salary *12 AS 年薪 FROM employee;
SELECT ename AS 'Employee Name' , salary *12 AS 'Annual Salary' FROM employee;

# 資料庫裡位置從1開始，不是習慣的0
SELECT SUBSTRING(ename,1,1) '姓氏' FROM employee;
SELECT SUBSTRING(ename,2) '名' FROM employee;
SELECT SUBSTRING('David Wang',1,5);
SELECT SUBSTRING('David Wang',7);
SELECT SUBSTRING('David Wang',-4);
SELECT SUBSTRING('David Wang',-4,2);

# length 返回的是byte數,char_length 返回的是字數
SELECT CONCAT(ename,'is a ', title) AS '員工' FROM employee;
SELECT LENGTH('我是一個student') AS 'length';
SELECT CHAR_LENGTH('我是一個student') AS 'length';

# sysdate() 返回現在時間 , now()返回現在時間,可是只會執行一次
SELECT SYSDATE();
SELECT NOW();
SELECT SYSDATE(),SLEEP(2),SYSDATE();
SELECT NOW(),SLEEP(2),NOW();
SELECT SYSDATE() + INTERVAL 5 DAY;
SELECT SYSDATE() - INTERVAL 6 MONTH;

# curdate() 返回現在日期, curtime()返回現在時間
SELECT CURDATE(),CURTIME();
SELECT ADDDATE(CURDATE(),5);
SELECT ADDDATE(CURDATE(),INTERVAL 5 DAY);
SELECT ADDDATE(CURDATE(),INTERVAL 5 YEAR);
SELECT SUBDATE(CURDATE(),5);
SELECT SUBDATE(CURDATE(),INTERVAL 5 DAY);
SELECT SUBDATE(CURDATE(),INTERVAL 5 YEAR);

# 使用函數擷取需要的年、月、日
SELECT empno,ename,hiredate,YEAR(hiredate) AS 'year', MONTH(hiredate) AS 'month', DAY(hiredate) AS 'day' FROM employee;


SELECT ename, hiredate , 
	DATEDIFF(NOW(),hiredate) /365 AS 'year',
	ROUND(DATEDIFF(NOW(),hiredate) /365) AS 'year',
    ROUND(DATEDIFF(NOW(),hiredate) /365 , 1) AS 'year' 
    FROM employee;
    
    
SELECT ename , hiredate, CONCAT((DATEDIFF(NOW(), hiredate) DIV 365) , '年' , ROUND(DATEDIFF(NOW(),hiredate) % 365 /30),'月') AS '年資'
    
    FROM employee;
	



