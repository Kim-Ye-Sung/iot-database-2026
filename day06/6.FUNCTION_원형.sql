-- 함수 원형 fnc_interest
CREATE DEFINER FUNCTION fnc_interest(
	price INTEGER
) RETURNS int
BEGIN
	-- 변수 선언
	DECLARE myInterest INTEGER;
	-- 가격이 30000원 이상이면 10%, 그 미만은 5%의 이윤 남김

	IF price >= 30000 THEN
		SET myInterest = price * 0.1;
	ELSE
		SET myInterest = price *0.05;
	END IF;
	
	RETURN myInterest;
END


-- 함수 원형 fnc_balanceGrade
CREATE FUNCTION madangdb.fnc_balanceGrade(
	balance INTEGER
)
RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN
	DECLARE grade VARCHAR(20);

	IF balance >= 50000 then
		SET grade = 'VIP';
	ELSEIF balance >= 20000 then
		SET grade = 'GOLD';
	ELSE
		SET grade = 'SILVER';
	END IF;
	
	RETURN grade;
END