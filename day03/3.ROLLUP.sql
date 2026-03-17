-- GROUP BY
-- 주문정보에서 각 고객별 총판매액을 조회하시오
SELECT custid, SUM(o.saleprice) AS "TotalPrice"
  FROM Orders o
 GROUP BY o.custid
HAVING TotalPrice > 20000;

-- ROLLUP을 모르면 아래와 같이 쿼리길이가 두배이상 늘어남
SELECT o.custid, SUM(o.saleprice) AS "TotalPrice"
  FROM Orders o
 GROUP BY o.custid
HAVING TotalPrice > 20000
 UNION
SELECT NULL, SUM(t.TotalPrice)
  FROM (SELECT custid, SUM(o.saleprice) AS "TotalPrice"
          FROM Orders o
         GROUP BY o.custid
        HAVING TotalPrice > 20000) t;

-- 필터링 ROLLUP을 하려면 서브쿼리 사용
SELECT t.custid, SUM(t.TotalPrice) "TotalPrice"
  FROM (SELECT o.custid, SUM(o.saleprice) AS "TotalPrice"
          FROM Orders o
         GROUP BY o.custid
        HAVING SUM(o.saleprice) >20000) t
         GROUP BY t.custid WITH ROLLUP;

SELECT o.custid, SUM(o.saleprice) AS "TotalPrice"
     , GROUPING(o.custid)
  FROM Orders o
 GROUP BY o.custid WITH ROLLUP;