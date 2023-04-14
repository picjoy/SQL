-- 동물의 생물 종, 이름, 성별 및 중성화 여부를 아이디 순으로 조회
-- 이름이 없는 동물의 이름은 "No name"으로 표시해 주세요.
SELECT ANIMAL_TYPE, NVL(NAME,'No name') NAME, SEX_UPON_INTAKE
FROM ANIMAL_INS
ORDER BY ANIMAL_ID;
