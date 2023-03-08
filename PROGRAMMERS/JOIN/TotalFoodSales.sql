SELECT PRODUCT_ID, PRODUCT_NAME, TOTAL_SALES
FROM(
SELECT P.PRODUCT_ID
    , P.PRODUCT_NAME
    , SUM(P.PRICE * O.AMOUNT) TOTAL_SALES
    FROM FOOD_PRODUCT P, FOOD_ORDER O
    WHERE P.PRODUCT_ID = O.PRODUCT_ID
    AND O.PRODUCE_DATE LIKE '2022-05%'
    GROUP BY P.PRODUCT_ID, P.PRODUCT_NAME
) A
ORDER BY TOTAL_SALES DESC, PRODUCT_ID