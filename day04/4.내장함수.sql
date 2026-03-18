/* 내장함수 */

-- 1.수학함수

-- 절대값
SELECT ABS(-78), ABS(+78)
  FROM DUAL;  -- 테이블을 사용하지 않을때 사용하는 키워드
  
-- 반올림
-- 두번째 인자 양수 소수점, 음수 정수부분
SELECT ROUND(3.141592, 3);

-- 고객별 평균 주문금액을 백원단위로 반올림하시오
SELECT o.custid "고객번호"
     , ROUND(SUM(saleprice)/COUNT(*), -2) AS "평균금액"
  FROM Orders o
 GROUP BY o.custid;

SELECT CEIL(3.14), FLOOR(3.67), POWER(2,10), LOG(10);

-- 나머지 함수
SELECT MOD(10,3);

-- 2. 문자 함수
-- 결합함수 파라미터 갯수 제한이 없음!
SELECT CONCAT ('성','','유고', '만쉐이!');

-- 소문자, 대문자 변환
SELECT LOWER('HELLO'), UPPER('hello');

-- 자릿수채우기
SELECT LPAD('Hello', 10, '*'),
	   RPAD('Hello',10,'@');  -- 주민번호 생년월일 - 성별이후 여섯자리*
	   
-- 문자열 대체
SELECT replace('Hello World', 'Hello', 'Bye');

-- 문자열 자르기
SELECT SUBSTR('Hello World',7,5);

-- 문자열 공백 없애기(중간 공백 제외)
SELECT concat('|', TRIM('          Hello World          '), '|') "TRIM",
       concat('|', LTRIM('          Hello World          '), '|')"LTRIM",
       concat('|', RTRIM('          Hello World          '), '|') "RTRIM";

-- 구분자로 지정하여 문자열 합치기
SELECT CONCAT_WS('-', '2026', '03', '18'),
       CONCAT_WS(' ', 'Hello', 'World');

-- 알파벳을 아스키코드 변환
SELECT ascii('A');

-- 문자열 길이 리턴
-- 한글 1글자 UTF-8에서 3byte, 글자길이와 저장되는 바이트 길이는 다름
SELECT LENGTH('안녕하세요'),
	   CHAR_LENGTH('안녕하세요');

-- 3. 날짜시간함수

-- 날짜문자열을 날짜형식으로 변환
SELECT STR_TO_DATE('2026-03-18', '%Y-%m-%d');

-- 날짜문자열을 날짜포맷에 맞춰서 변경
SELECT DATE_FORMAT('2026-03-18', '%Y-%m-%d'),
       DATE_FORMAT('2026-03-18', '%m-%d-%Y'),
	   DATE_FORMAT(NOW(), '%m.%d.%Y');

-- 날짜 더하기/빼기
SELECT ADDDATE(NOW(), INTERVAL -10 DAY),
	   DATE(NOW()), TIME(NOW());

-- 날짜 간 날짜 차이수
SELECT DATEDIFF('2026-03-19','2026-03-08');

-- 현재 일시
SELECT SYSDATE(), NOW();

-- 날짜함수 포맷
/*
 * %Y : 네자리 년도 2026
 * %y : 두자리 년도 26
 * %m : 월
 * %M : 월이름 (January ~ December)
 * %b : 월약자 이름 (Jan ~ Dec)
 * %d : 일
 * %W : 요일 (Wednesday)
 * %w : 요일숫자 (0 일요일 ~ 6 토요일)
 * %a : 요일약자 (Sun, Mon, Wed)
 * %h : 12시간 hour
 * %H : 24시간 Hour
 * %i : 분
 * %s : 초
 */

SELECT DATE_FORMAT(NOW(), '%Y-%M-%D %w'),
       DATE_FORMAT(NOW(), '%H:%i:%s');