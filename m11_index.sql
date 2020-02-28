SHOW INDEX
FROM employee;

CREATE INDEX ename_idx
ON employee (ename);

DROP INDEX ename_idx
ON employee;