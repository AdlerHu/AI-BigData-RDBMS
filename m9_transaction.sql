# Explicit Transaction ( 外顯式交易)
# 第一次select可以看的到601,602, 如果這時別人也在看department表看不到這兩筆,rollback後這兩筆就沒有進去資料庫
START TRANSACTION;
INSERT INTO department VALUES (601, 'RD', 1001);
INSERT INTO department VALUES (602, 'IT', NULL);
SELECT * FROM department;
ROLLBACK;
SELECT * FROM department;

# commit 代表交易完成,所有人都看的到這兩筆
START TRANSACTION;
INSERT INTO department VALUES (601, 'RD', 1001);
INSERT INTO department VALUES (602, 'IT', NULL);
SELECT * FROM department;
COMMIT;
SELECT * FROM department;

# Implicit(隱含式交易) 
SET autoCommit = 0;
INSERT INTO department VALUES (603, 'RD', 1001);
INSERT INTO department VALUES (604, 'IT', NULL);
SELECT * FROM department;
ROLLBACK;
SELECT * FROM department;

INSERT INTO department VALUES (603, 'RD', 1001);
INSERT INTO department VALUES (604, 'IT', NULL);
SELECT * FROM department;
COMMIT;
SELECT * FROM department;
SET autocommit = 1;

# rollback to A 代表回到savepoint A ,所以只有savepoint A之前的指令會進資料庫
BEGIN;
SELECT	empno, ename, salary
FROM	employee
WHERE	empno IN (1001, 1002, 1003);
UPDATE	employee SET salary = 60000 WHERE empno = 1001;
SAVEPOINT A;
UPDATE	employee SET salary = 40000 WHERE empno = 1002;
SAVEPOINT B;
UPDATE	employee SET salary = 60000 WHERE empno = 1003;
ROLLBACK TO A;
COMMIT;
SELECT	empno, ename, salary
FROM	employee
WHERE	empno IN (1001, 1002, 1003);

BEGIN;
SELECT	salary
FROM	employee
WHERE	empno = 1001;

UPDATE 	employee
SET		salary = 60001
WHERE	empno = 1001;

COMMIT;

SELECT	salary
FROM	employee
WHERE	empno = 1001;



