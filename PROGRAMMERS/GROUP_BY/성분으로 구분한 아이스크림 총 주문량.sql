SELECT ingredient_type, SUM(TOTAL_ORDER) FROM ICECREAM_INFO ICE, FIRST_HALF HA
WHERE ICE.FLAVOR = HA.FLAVOR
GROUP BY ingredient_type;
