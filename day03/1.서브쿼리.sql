-- 서브쿼리 종류

/* WHERE절 서브쿼리 */

-- 서브쿼리를 사용해서 출판사 이름이 '미디어'로 끝나는 출판사에서
-- 출판한 책을 조회하시오
SELECT * 
  FROM Book
 WHERE publisher IN (SELECT DISTINCT  publisher
  					  FROM Book b 
 		             WHERE publisher LIKE '%미디어');

-- 도서를 구매한 적이 있는 고객의 이름을 조회하시오
SELECT c.name
  FROM Customer c
 WHERE c.custid IN( SELECT DISTINCT custid
  					  FROM Orders);

-- 대한미디어에서 출판한 도서를 구매한 고객의 정보를 보이시오
-- 고객테이블 컬럼만 사용가능
SELECT *
  FROM Customer c
 WHERE c.custid IN (SELECT custid 
                      FROM Orders o 
                     WHERE bookid IN (SELECT  bookid
                                        FROM Book
				                       WHERE publisher = '대한미디어'));

-- 조인으로 변경가능. 모든 테이블 컬럼을 사용가능
SELECT *
  FROM Customer c, Orders o, Book b
 WHERE c.custid = o.custid 
   AND b.bookid = o.bookid 
   AND b.publisher = '대한미디어';

-- 도서 전체 평균값보다 저렴한 책들을 조회하시오
SELECT *
  FROM Book b 
 WHERE price <=(SELECT AVG(price) 
                  FROM Book);

-- 출판사별 가장 비싼 도서를 조회하세요
-- 서브쿼리로 두 컬럼을 비교가능
SELECT *
  FROM Book
 WHERE (publisher, price) IN (SELECT publisher, MAX(price)
                                FROM Book
                               GROUP BY publisher);

-- ANY, SOME 결과 중 메인쿼리의 조건이 하나라도 참이면 출력 = OR
-- 출판사별 가장 비싼 책들과 가격이 하나라도 일치하는 책정보를 조회하라
SELECT *
  FROM Book
 WHERE price = ANY (SELECT MAX(price)
                      FROM Book
                     GROUP BY publisher);

-- 출판사별 가장 비싼 책들과 가격이 하나라도 더 비싼 책정보를 조회하라
SELECT *
  FROM Book
 WHERE price < ANY (SELECT MAX(price)
                      FROM Book
                     GROUP BY publisher);

-- ALL = AND
-- 출판사별 가장 비싼 책들과 가격이 모두 조건에 일치하는 책정보를 조회하라
SELECT *
  FROM Book
 WHERE price >= ALL (SELECT MAX(price)
                      FROM Book
                     GROUP BY publisher);

-- EXISTS
-- 서브쿼리 결과가 아무것도 없으면 메인쿼리는 조회안됨
-- 서브쿼리 결과가 뭐라도 있으면 메인쿼리 조회가능
SELECT *
  FROM Book b 
 WHERE EXISTS (SELECT MAX(price)
                 FROM Book
                GROUP BY publisher
               HAVING MAX(price) >= 30000);

-- 상관서브쿼리(Correlated subquery). 
-- 메인쿼리의 컬럼이 서브쿼리의 조건에 포함될 때 
-- 서브쿼리만 따로 실행 불가능
-- 출판사별 출판사 평균 도서가격보다 비싼 도서를 조회하세요

-- 참조쿼리
(SELECT AVG(b2.price)
   FROM Book b2
  GROUP BY b2.publisher);

-- 상관서브쿼리는 안쪽 서브쿼리만 따로 실행불가. 코드 이해가 쉽지 않음
-- 많이 안쓰는걸 권장
SELECT *
  FROM Book b1
 WHERE b1.price > (SELECT AVG(b2.price)
 					 FROM Book b2
 					WHERE b2.publisher = b1.publisher);

/* FROM절 서브쿼리 */

-- 서브쿼리로 만들어진 가상테이블을 진짜 테이블처럼 FROM절에 사용하는 것
-- 구매 고객별 합계 중에서 총 금액이 3만5천 이상인 구매건의 고객번호와 금액을 조회하세요
SELECT t.custid, t.TotalPrice
  FROM (SELECT custid, SUM(saleprice) "TotalPrice"
          FROM Orders
         GROUP BY custid) t
 WHERE t.TotalPrice  > 32000
 ORDER BY t.TotalPrice DESC;

-- FROM절 서브쿼리는 일반 테이블 Customer과 조인 가능
SELECT t.custid, t.TotalPrice, c.name
  FROM (SELECT custid, SUM(saleprice) "TotalPrice"
          FROM Orders
         GROUP BY custid) t
 INNER JOIN Customer c
    ON t.custid = c.custid
 WHERE t.TotalPrice  > 32000
 ORDER BY t.TotalPrice DESC;

-- 구매를 3번 이상한 고객만 조회하시오
SELECT *
  FROM (SELECT custid, COUNT(*) AS "Order_Cnt"
  		  FROM Orders
 		 GROUP BY custid) t
 WHERE t.Order_cnt >=3;

/* SELECT절 서브쿼리 */
-- JOIN을 사용하지 않고, 주문번호 5이하인 주문건들의 고객명과 책 이름을 같이 조회하시오.
-- 조인으로 했을때 쿼리
SELECT o.orderid
     , o.custid 
     , c.name
     , o.bookid
     , b.bookname
     , o.saleprice 
     , o.orderdate 
  FROM Orders o, Customer c, Book b
 WHERE o.custid = c.custid
   AND o.bookid = b.bookid 
   AND o.orderid <=5;

-- SELECT 서브쿼리는 한행 한컬럼만 리턴되어야 함!
SELECT o.orderid
     , o.custid 
     , (SELECT name FROM Customer WHERE custid = o.custid) '고객명'
     , o.bookid
     , (SELECT bookname FROM Book WHERE bookid = o.bookid) "도서명"
     , o.saleprice 
     , o.orderdate 
  FROM Orders o
 WHERE o.orderid <=5;