-- 세션2번
UPDATE accounts 
   SET balance = balance -500
 WHERE id = 2;

 SELECT @@autocommit;

 SET autocommit = 0;


 -- 다른 세션에서 다른 데이터를 수정
 UPDATE accounts
    SET balance = balance -1500
  WHERE id= 3;

SELECT * FROM accounts; 

COMMIT;

ROLLBACK;


-- Non-Repeatable Read
-- 격리수준 하강
SET SESSION TRANSACTION ISOLATION LEVEL READ COMMITTED;

SET SESSION TRANSACTION ISOLATION LEVEL REPEATABLE READ;


Update accounts 
   SET balance = 30000
 WHERE id = 1;

 COMMIT;


-- Phantom Read 세션 2
INSERT INTO employees (name, salary)
VALUES ('Dred', 6500);



-- DeadLock
-- AutoCommit 해제
SELECT @@autocommit;
SET autocommit = 0;

SELECT * FROM accounts;

SELECT * FROM employees;

-- 6번 id 급여를 8000원으로 변경

UPDATE employees
   SET salary = 8000
 WHERE id = 6;

 ROLLBACK;

 
 -- 다른 세션의 5번 ID 급여를 100 증가
 UPDATE employees
    SET salary = salary +100
  WHERE id = 5;


  UPDATE  acoounts
     SET balance = 7000
   WHERE id = 2;

   -- 테이블락
SELECT * FROM accounts;

UPDATE accounts
   SET balance = 9000
 WHERE id = 3;

 ROLLBACK;