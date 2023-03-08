
SELECT * FROM departments;

-- 중복 제외하기 : DISTINCT
SELECT DISTINCT location_id
FROM departments;

-- 연결 연산자 || : 컬럼이나 문자열을 연결할 때 사용
SELECT department_id || department_name
FROM departments;

SELECT 'Department of ' || department_name AS 부서이름
FROM departments;


