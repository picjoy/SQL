-- 완료된 중고 거래의 총금액이 70만 원 이상인 사람의 회원 ID, 닉네임, 총거래금액
WITH A AS (
SELECT WRITER_ID, SUM(PRICE) TOTAL_SALES
FROM USED_GOODS_BOARD 
WHERE STATUS = 'DONE'
GROUP BY WRITER_ID
)

SELECT UG.USER_ID, NICKNAME, TOTAL_SALES
FROM USED_GOODS_USER UG, A
WHERE UG.USER_ID = A.WRITER_ID
AND TOTAL_SALES >= 700000
ORDER BY TOTAL_SALES;
