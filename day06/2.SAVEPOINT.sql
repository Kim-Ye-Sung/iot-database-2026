-- 1. kim -> Lee 송금 중 문제 발생
START TRANSACTION;

-- kim에서 출금
UPDATE accounts
   SET balance = balance - 1000
 WHERE id = 1;

SAVEPOINT sp_transfer;

-- Lee에게 입금
UPDATE accounts 
   SET balance = balance +2000
 WHERE id = 2;

SELECT * FROM accounts;

ROLLBACK TO SAVEPOINT sp_transfer;

ROLLBACK;

COMMIT;

-- 현재 MySQL DB엔진 종류 확인
-- InnoDB(최신 버전엔진), MyISAM(구버전 5.5이하)
-- MyISAM 트랜잭션 처리가 필요X
SHOW TABLE STATUS LIKE 'accounts';

-- 현재 실행중인 트랜잭션 조회 쿼리(root만 가능)
SELECT * FROM information_schema.INNODB_TRX it;