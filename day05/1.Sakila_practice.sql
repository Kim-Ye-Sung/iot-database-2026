/* Sakila DB 연습 */

-- 1. 한번도 대여되지 않은 영화를 조회하시오
SELECT f.film_id  , f.title, r.rental_id, i.inventory_id 
  FROM film f
  LEFT OUTER JOIN inventory i
    ON f.film_id = i.film_id
  LEFT OUTER JOIN rental r
    ON i.inventory_id = r.inventory_id
 WHERE r.rental_id  IS NULL; 

-- 총 대여횟수
SELECT COUNT(*) FROM rental;

-- 영화는 존재한다.
SELECT * FROM film
 WHERE title = 'ACADEMY DINOSAUR';

-- 가게에 영화자체가 없다. 대여를 할 수 없는 상태
SELECT * FROM inventory
 WHERE film_id IN(
1,
14,
33,
36,
38,
41,
87,
108,
128,
144,
148,
171,
192,
195,
198,
217,
221,
318,
325,
332,
359,
386,
404,
419,
495,
497,
607,
642,
669,
671,
701,
712,
713,
742,
801,
802,
860,
874,
909,
943,
950,
954,
955
 );

-- 2. 가장 많이 대여된 영화를 조회하시오.
SELECT f.title, COUNT(r.rental_id ) AS "RentalCount"
  FROM film f
  JOIN inventory i
    ON f.film_id = i.film_id
  JOIN rental r
    ON i.inventory_id = r.inventory_id
 GROUP BY f.title
 ORDER BY RentalCount DESC;
    
-- 위의 코드와 완전 동일한 쿼리. 그럼에도 불구하고 내부조인형태로 제대로 쓰는 이유는
-- 나중에 뭔가 잘못되서 외부조인으로 수정할때 편하기때문이다. 저기서 LEFT나 RIGHT만 써주면 외부조인이 되기때문.
-- 그러나 아래와 같은 코드는 다시 JOIN부터 분리해서 시작해야하기때문에 수정이 힘들다.
-- MySQL 조인은 내부조인을 외부조인으로 변경하는데 시간이 많이 필요
SELECT f.film_id  , f.title, r.rental_id, i.inventory_id 
  FROM film f, inventory i, rental r
 WHERE f.film_id  = i.film_id 
   AND i.inventory_id  = r.inventory_id;

-- 3. 직원별 총 매출을 조회하시오
SELECT s.staff_id , s.first_name , s.last_name , ROUND(SUM(p.amount ),1) AS "rental_amt"
  FROM staff s
  JOIN payment p
    ON s.staff_id = p.staff_id
 GROUP BY s.staff_id, s.first_name, s.last_name
 ORDER BY rental_amt DESC;

-- 4. TOM MIRANDA 배우가 출연한 영화목록을 조회하시오
SELECT f.film_id , f.title, f.release_year 
     , f.language_id 
     , (SELECT name FROM `language` l WHERE language_id = f.language_id) AS "영화언어"
  FROM film f
  JOIN film_actor fa
  	ON f.film_id = fa.film_id 
  JOIN actor a
    ON fa.actor_id  = a.actor_id
 WHERE a.first_name = 'TOM'
   AND a.last_name  = 'MIRANDA';

-- 
SELECT * FROM film WHERE language_id =1;


-- 5. 새 고객 Gildong Hong을 추가하세요
SELECT * FROM customer
 ORDER BY customer_id DESC;

-- customer_id는 Auto Increment로 직접 추가할 필요없음
INSERT INTO customer(store_id, first_name, last_name, email, address_id, active, create_date)
VALUES (2, 'Gildong', 'Hong', 'gildong@naver.com', 5, 1, now());

-- 6. Gildong Hong의 이메일 주소를 수정하세요
UPDATE customer
   SET email = 'gildong.hong@gmail.com'
 WHERE customer_id = 601;

-- 7. Gildong Hong 비활성단계로 수정하세요
UPDATE customer
   SET active = 0
 WHERE customer_id = 601;

-- 삭제
DELETE FROM customer
 WHERE customer_id = ;