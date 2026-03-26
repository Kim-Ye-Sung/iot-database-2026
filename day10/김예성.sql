-- 1.   현재 대여 중인 도서를 조회하시오.
SELECT (SELECT member_name FROM members WHERE member_idx = r.member_idx ) AS "회원명"
	 , (SELECT book_name FROM books WHERE book_idx = r.book_idx ) AS "책제목"
	 , r.rentalDate AS "대여일"
  FROM rentals r
 WHERE r.returnDate IS NULL;

-- 2.  회원별 대여 횟수를 집계하시오.
SELECT r.member_idx AS "회원번호"
     , (SELECT member_name FROM members WHERE member_idx = r.member_idx ) AS "회원명"
     , COUNT(*) AS "대여횟수"
  FROM rentals r
 GROUP BY r.member_idx
 ORDER BY 대여횟수 DESC, 회원명 ASC;

-- 3.  장르별 도서수를 조회하시오.
SELECT d.div_code AS "장르코드"
     , d.div_name AS "장르명"
     , COUNT(b.div_code) AS "도서수" 
  FROM division d
  LEFT OUTER JOIN books b
    ON d.div_code = b.div_code
 GROUP BY d.div_code;

-- 4.  한번도 대여되지 않은 도서를 조회하시오
SELECT *
  FROM books b
  LEFT OUTER JOIN rentals r
    ON b.book_idx = r.book_idx
 WHERE r.rental_idx IS NULL;

-- 5. 평균 대여수보다 많이 대여한 회원을 조회하시오
SELECT r1.member_idx AS "회원번호"
 	 , (SELECT member_name FROM members WHERE member_idx = r1.member_idx ) AS "회원명"
	 , COUNT(*) AS "대여횟수"
  FROM rentals r1
 GROUP BY r1.member_idx
 HAVING 대여횟수 > (SELECT AVG(r2.총합)
  					FROM (SELECT member_idx, COUNT(*) AS "총합"
  		  					FROM rentals
 		 				   GROUP BY member_idx) r2);