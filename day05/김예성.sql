-- 1번
SELECT o.custid
     , SUM(o.saleprice ) AS "total_price"
  FROM Orders o
 GROUP BY o.custid
 ORDER BY total_price DESC;

-- 2번
SELECT c.name "이름"
     , b.bookid "책 번호"
     , o.saleprice "판매가격" 
     , o.orderdate "주문일자"
  FROM Orders o
  JOIN Customer c
    ON o.custid = c.custid 
  JOIN Book b
    ON b.bookid = o.bookid
 ORDER BY o.orderdate DESC;

-- 3번
SELECT o.orderid "주문번호"
     , o.custid "고객번호"
     , o.bookid "책번호"
     , o.saleprice "판매가격"
  FROM Orders o
 WHERE o.saleprice > (SELECT AVG(o2.saleprice)
 						FROM Orders o2							
 )
 ORDER BY o.saleprice DESC;

-- 4번
SELECT c.name "이름", total_price "총 구매금액" 
  FROM (SELECT o.custid, SUM(o.saleprice) AS "total_price"
          FROM Orders o
         GROUP BY custid) t
  JOIN Customer c 
    ON t.custid  = c.custid
 WHERE total_price >= 50000
 ORDER BY total_price DESC;



-- 명건쌤이 알려준 정답
