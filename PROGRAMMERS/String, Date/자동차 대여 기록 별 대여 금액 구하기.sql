--  자동차 종류가 '트럭'인 자동차의 대여 기록에 대해서 
-- 대여 기록 별로 대여 금액(컬럼명: FEE)을 구하여 대여 기록 ID와 대여 금액 리스트를 출력
-- 대여 금액을 기준으로 내림차순, 대여 기록 ID를 기준으로 내림차순 정렬
WITH A AS (
SELECT HISTORY_ID, C.CAR_ID,DAILY_FEE, (END_DATE-START_DATE+1) AS DAY ,
    CASE 
    WHEN TO_CHAR(END_DATE - START_DATE +1) >= 90 then '90일 이상'
    WHEN TO_CHAR(END_DATE - START_DATE +1) >= 30 then '30일 이상'
    WHEN TO_CHAR(END_DATE - START_DATE +1) >= 7 then '7일 이상'
    ELSE '0'
    END AS DUE
FROM CAR_RENTAL_COMPANY_RENTAL_HISTORY H, CAR_RENTAL_COMPANY_CAR C
WHERE H.CAR_ID = C.CAR_ID
AND CAR_TYPE = '트럭'),
B AS (
SELECT CAR_ID, DURATION_TYPE, DISCOUNT_RATE
FROM CAR_RENTAL_COMPANY_CAR CAR, CAR_RENTAL_COMPANY_DISCOUNT_PLAN DISCOUNT
WHERE CAR.CAR_TYPE = DISCOUNT.CAR_TYPE AND
DISCOUNT.CAR_TYPE = '트럭'
)

SELECT HISTORY_ID, DAY*(DAILY_FEE*(100-NVL(DISCOUNT_RATE,0))/100) as FEE
FROM A 
LEFT OUTER JOIN B
ON A.CAR_ID = B.CAR_ID AND A.DUE = B.DURATION_TYPE
ORDER BY FEE DESC, HISTORY_ID DESC
