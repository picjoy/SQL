SELECT 
    TO_CHAR(SALES_DATE , 'YYYY')AS YEAR, 
    TO_NUMBER(TO_CHAR(SALES_DATE, 'MM'))AS MONTH,
    -- 2021년에 가입한 전체 회원들 중 상품을 구매한 회원수 
    -- (동일한 날짜, 회원 ID, 상품 ID 조합에 대해서는 하나의 판매 데이터만 존재)
    COUNT(DISTINCT ONLINE_SALE.USER_ID) AS PUCHASED_USERS,
    -- 소수점 두번째자리에서 반올림: 2021년에 가입한 회원 중 상품을 구매한 회원수/2021년에 가입한 전체 회원 수
    ROUND(COUNT(DISTINCT ONLINE_SALE.USER_ID)/(
        SELECT COUNT(DISTINCT USER_ID) 
        FROM USER_INFO  
        WHERE TO_CHAR(JOINED,'YYYY') = '2021'),1)  AS PUCHASED_RATIO
FROM ONLINE_SALE 
LEFT JOIN USER_INFO 
    ON ONLINE_SALE.USER_ID = USER_INFO.USER_ID
-- 2021년에 가입한 회원
WHERE 
    TO_CHAR(USER_INFO.JOINED,'YYYY') = '2021'
-- 년, 월 별로 출력
GROUP BY 
    TO_CHAR(SALES_DATE , 'YYYY'),TO_NUMBER(TO_CHAR(SALES_DATE, 'MM'))
-- 년을 기준으로 오름차순 정렬/ 같다면 월을 기준으로 오름차순 정렬
ORDER BY 
    YEAR, MONTH;
