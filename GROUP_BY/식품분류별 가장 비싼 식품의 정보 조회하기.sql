-- # NO.1
SELECT category, price AS max_price, product_name
FROM food_product
WHERE (category,price) IN (
    SELECT category, MAX(price) AS max_price
    FROM food_product
    WHERE category IN ('과자', '국', '김치', '식용유')
    GROUP BY category
)
ORDER BY price DESC;

--# NO.2
SELECT
    A.* , B.PRODUCT_NAME 
FROM (
    SELECT 
        CATEGORY AS CATEGORY , MAX(PRICE) AS MAX_PRICE   
    FROM FOOD_PRODUCT 
    WHERE CATEGORY IN ('과자', '국' , '김치' , '식용유')
    GROUP BY 
         CATEGORY ) A 
    JOIN (
        SELECT CATEGORY, PRODUCT_NAME , PRICE 
        FROM FOOD_PRODUCT) B 
      ON 
        A.MAX_PRICE = B.PRICE 
      AND  
        A.CATEGORY = B.CATEGORY
ORDER BY MAX_PRICE DESC;
