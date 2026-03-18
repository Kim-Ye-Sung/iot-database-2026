-- 행번호 변수 사용
SET @seq := 0;

SELECT (@seq:=@seq+1) "순번"
     , custid
     , name
     , phone
  FROM Customer
 WHERE @seq < 3
 ORDER BY custid DESC;