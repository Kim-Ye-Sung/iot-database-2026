-- 문제 
-- 1번
SELECT bookname
  FROM Book
 WHERE bookid =1;

-- 2번
SELECT bookname
  FROM Book
 WHERE price >= 20000;

-- 3번
SELECT SUM(saleprice) "총 구매액"
  FROM Orders
 WHERE custid = 1;

-- 4번
SELECT COUNT(*) "구매한 도서 갯수"
  FROM Orders
 WHERE custid = 1;


-- 마당서점 도서 총 개수
SELECT COUNT(*)
  FROM Book;

-- 마당서점 도서를 출고하는 출판사의 총개수
SELECT COUNT(DISTINCT publisher)
  FROM Book;

-- 모든 고객의 이름, 주소


--  2024년 7월 4일 ~ 7월 7일 사이 주문받은 도서 주문번호
-- Data형은 문자열이 아니지만 날짜를 검색할때 문자열로 비교검색 가능
SELECT *
  FROM Orders
 WHERE orderdate BETWEEN '2024-07-04'
   AND '2024-07-07';

-- 아래와 같이 문자열을 날짜로 변경해도 가능
SELECT *
  FROM Orders
 WHERE orderdate BETWEEN str_to_date('2024-07-04', '%Y-%m-%d') AND str_to_date('2024-07-07', '%Y-%m-%d');

-- 2024년 7월 4일 ~ 2024년 7월 7일 사이에 주문받은 도서를 제외한 도서의 주문번호
SELECT *
  FROM Orders
 WHERE orderdate NOT BETWEEN '2024-07-04'
   AND '2024-07-07';

-- 성이 '김'씨인 고객의 이름과 주소
SELECT *
  FROM Customer
 WHERE name LIKE '김%';

-- 성이 '김'씨이고 이름이 '아'로 끝나는 고객의 이름과 주소
SELECT name, address
  FROM Customer
 WHERE name LIKE '김_아';