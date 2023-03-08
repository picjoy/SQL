SELECT f.FLAVOR as flavor
FROM FIRST_HALF f, ICECREAM_INFO info
where f.FLAVOR = info.FLAVOR
and TOTAL_ORDER > 3000
and info.INGREDIENT_TYPE = 'fruit_based'
order by TOTAL_ORDER desc
