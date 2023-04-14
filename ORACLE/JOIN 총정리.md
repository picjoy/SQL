### 오라클에서 조인을 할 때 오라클조인(Oracle Join)과 안시 조인(ANSI JOIN)을 사용할 수 있다. 
> 오라클 9i 까지는 오라클 조인만 사용할 수 있으며, 오라클 10g부터는 안시 조인을 추가로 사용할 수 있다. \
최근 구축되는 시스템은 대부분 안시 조인을 사용하지만, 과거에 구축되어 있는 시스템은 오라클 조인을 많이 사용하고 있기 때문에 오라클 조인 방식도 꼭 알고 있어야 한다고 한다.

![](https://velog.velcdn.com/images/piczo/post/a25211f0-df96-4388-9b0a-a81f1c4c3abb/image.png)
_▲ 안시 조인과 오라클 조인 비교 (INNER JOIN)_


> **조인 (INNER JOIN)**
**아우터 조인 (LEFT OUTER JOIN)**
아우터 조인 (RIGHT OUTER JOIN)
크로스 조인 (CROSS JOIN)
풀 아우터 조인 (FULL OUTER JOIN)
 
조인은 크게 위의 5가지 정도로 분류할 수 있다. 
조인 (INNER JOIN)과 아우터 조인 (LEFT OUTER JOIN)은 주로 많이 사용한다.

--- 

### 📚 조인 (INNER JOIN)
조인(INNER JOIN)은 **메인 테이블과 조인 테이블에 조인 칼럼(deptno)의 값이 동시에 존재해야 조회가 된다.**
* **안시 조인 (ANSI JOIN)**
```sql
SELECT a.empno
     , a.ename
     , a.deptno
     , b.dname
  FROM emp a
 INNER JOIN dept b
    ON a.deptno = b.deptno
 WHERE a.job = 'MANAGER'
 ```
 ![](https://velog.velcdn.com/images/piczo/post/6a2958fc-f27f-4537-9190-ce447b39b9bd/image.png)

EMP 테이블과 DEPT 테이블을 조인(내부 조인)하여 DEPT 테이블의 DNAME(부서명)을 조회한 쿼리이다.

![](https://velog.velcdn.com/images/piczo/post/d7aa14d6-9558-47f4-b166-47a5f670c42a/image.png)
위의 조인 구조를 보면 EMP 테이블의 "GENT"는 DEPT 테이블과 조인이 안되었기 때문에 데이터 조회에서 제외된다.

 

▼ 위의 ANSI JOIN을 Oracle Join으로 변경하면 아래와 같다.

 

* ** 오라클 조인 (Oracle Join)**
```sql
SELECT a.empno
     , a.ename
     , a.deptno
     , b.dname
  FROM emp a
     , dept b
 WHERE a.job = 'MANAGER'
   AND a.deptno = b.deptno
 ```
![](https://velog.velcdn.com/images/piczo/post/f497f8dd-a4e8-496e-a9f9-f21dccc496cf/image.png)

오라클 조인은 **조인 칼럼(deptno) 조건을 WHERE 절에 작성**하면 된다.

 ---

### 📚 아우터 조인
아우터 조인(OUTER JOIN)은 **조인 테이블의 값이 존재하지 않아도 메인 테이블의 데이터가 조회**된다. **조인 테이블의 값을 가져오지 못하면 NULL로 표시**된다.
#### LEFT OUTER JOIN
* **안시 조인 (ANSI JOIN)**
```sql
SELECT a.empno
     , a.ename
     , a.deptno
     , b.dname
  FROM emp a
  LEFT OUTER JOIN dept b
    ON a.deptno = b.deptno
 WHERE a.job = 'MANAGER'
``` 
![](https://velog.velcdn.com/images/piczo/post/ebedcd01-9318-43ff-aa97-5c4bfd86b8f6/image.png)
위의 예제는 EMP 테이블과 DEPT 테이블을 아우터 조인(외부 조인)하여 DEPT 테이블의 DNAME(부서명)을 조회한 쿼리이다. 

**(메인 테이블) LEFT OUTER JOIN (조인 테이블)** 왼쪽 테이블이 메인 테이블이 된다.
![](https://velog.velcdn.com/images/piczo/post/095ebe90-234c-4719-ab8e-4e74e0ec5779/image.png)

 
아우터 조인은 메인 테이블의 데이터가 모두 조회되고, 조인 테이블의 값을 참조하여 조인이 되었을 경우 해당 값(dname)을 표시하고 조인이 되지 않았을 경우 NULL로 표시한다. 조인(INNER JOIN)인 처럼 조인이 되지 않았다고 조회에서 제외하지 않는다.

 

▼ 위의 ANSI JOIN을 Oracle Join으로 변경하면 아래와 같다.

 

* **오라클 조인 (Oracle Join)**
```sql
SELECT a.empno
     , a.ename
     , a.deptno
     , b.dname
  FROM emp a
     , dept b
 WHERE a.job = 'MANAGER'
   AND a.deptno = b.deptno(+)
 ```
 ![](https://velog.velcdn.com/images/piczo/post/2566aacd-7afd-499d-bff9-f1b7ccb70875/image.png)

**조인 조건을 ON절에서 WHERE 절로 위치가 변경되었고 조인 칼럼에 (+)이 붙어있다**.

**조인 칼럼에 (+)를 붙이면 해당 칼럼의 테이블이 조인 테이블**이 된다.

 

📌 **아우터 조인의 핵심은 메인 테이블의 데이터는 무조건 조회가 되고 조인 테이블은 참조 용도로만 사용하는 것**

 


#### RIGHT OUTER JOIN
* **안시 조인 (ANSI JOIN)**
```sql
SELECT a.empno
     , a.ename
     , a.deptno AS emp_deptno
     , b.deptno
     , b.dname
  FROM emp a
 RIGHT OUTER JOIN dept b
    ON a.deptno = b.deptno
 WHERE (a.job = 'MANAGER'
     OR a.job IS NULL)
 ```
![](https://velog.velcdn.com/images/piczo/post/8e788cde-34b4-42c6-b2c7-9c0ed9e60159/image.png)
LEFT OUTER JOIN과 다른 점은 오른쪽(RIGHT) 테이블이 메인 테이블이 된다. 
**(조인 테이블) RIGHT OUTER JOIN (메인 테이블)**

특별한 경우가 아니면 RIGHT OUTER JOIN은 사용하지 않는 것이 차후 쿼리문을 분석할 때 가독성을 좋게 할 수 있다.![](https://velog.velcdn.com/images/piczo/post/d3fd5b2b-188a-4f0e-b539-0c89cec2158e/image.png)
DEPT 테이블이 메인 테이블이 되어서 EMP 테이블과 아우터 조인이 된다.

 

▼ 위의 ANSI JOIN을 Oracle Join으로 변경하면 아래와 같다.

 

* **오라클 조인 (Oracle Join)**
```sql
SELECT a.empno
     , a.ename
     , a.deptno
     , b.deptno
     , b.dname
  FROM emp a
     , dept b
 WHERE a.deptno(+) = b.deptno
   AND (a.job = 'MANAGER'
     OR a.job IS NULL)
 ```
![](https://velog.velcdn.com/images/piczo/post/6cd98cbd-fa2e-4d9d-a9fc-3887bd0a71c3/image.png)
오라클 조인에서는 RIGHT OUTER JOIN이라는 용어는 사용 안 하지만, 
조인 칼럼의 (+) 위치를 변경 함으로써 RIGHT OUTER JOIN과 비슷하게 만들 수 있다.

 

RIGHT OUTER JOIN은 개념을 이해하고 아우터 조인은 LEFT OUTER JOIN을 확실히 익혀 두도록!!

 ---

### 📚 크로스 조인 (CROSS JOIN)
크로스 조인은 **두 테이블의 모든 데이터를 서로 한 번씩 조인**을 한다고 생각하면 된다.

* **안시 조인 (ANSI JOIN)**
```sql
SELECT a.empno
     , a.ename
     , b.deptno
     , b.dname
  FROM emp a
 CROSS JOIN dept b
 WHERE a.job = 'MANAGER'
 ```
![](https://velog.velcdn.com/images/piczo/post/571edf6e-11f3-487a-927b-ba989e2db701/image.png)
CROSS JOIN 절에 테이블 작성하고 메인 테이블과 조인 칼럼을 연결하지 않는다.
![](https://velog.velcdn.com/images/piczo/post/60e7e81f-9fb8-48ce-8527-d96f568e38e6/image.png)
두 테이블의 데이터가 서로 한 번씩 조인이 되기 때문에, 
사원 테이블 (4행) * 부서 테이블(3행) = 총 12행이 조회된다.

크로스 조인은 아주 가끔씩 사용한다고 한다.
 

▼ 위의 ANSI JOIN을 Oracle Join으로 변경하면 아래와 같다.

* **오라클 조인 (Oracle Join)**
```sql
SELECT a.empno
     , a.ename
     , b.deptno
     , b.dname
  FROM emp a
     , dept b
 WHERE a.job = 'MANAGER'
   AND b.deptno IN (10, 20, 30)
``` 
![](https://velog.velcdn.com/images/piczo/post/4ed370fe-a334-45b1-98b5-266255941597/image.png)
오라클 조인에서 크로스 조인을 하기 위해서는 FROM 절에 테이블을 작성하고 WHERE 절에서 조인 칼럼을 작성하지 않으면 두 개의 테이블이 서로 크로스 조인된다.

 ---

### 📚 풀 아우터 조인 (FULL OUTER JOIN)
두 개의 테이블을 조인하여 조인된 데이터는 조인된 상태로 조회되고, 조인 안된 데이터는 조인이 안된 상태로 조회된다. **조인되어도 조회되고 조인이 안되어도 모두 조회**된다고 생각하면 된다.

* **안시 조인 (ANSI JOIN)**
```sql
SELECT a.empno
     , a.ename
     , a.deptno
     , b.dname
  FROM emp a
  FULL OUTER JOIN dept b
    ON a.deptno = b.deptno
```
 ![](https://velog.velcdn.com/images/piczo/post/aa0074da-6ef2-4feb-9253-73a31873e934/image.png)
풀 아우터 조인은 ANSI JOIN에서만 사용 가능하고 Oracle Join에서는 사용할 수 없다. 
자주 사용하는 조인 방법은 아니기 때문에 개념만 이해하면 된다.

---

### 📚 셀프 조인(Self Join)
셀프 조인은 **같은 테이블 내의 데이터를 조인**합니다. 
동일한 테이블 1개를 그 자신에게 합치는, 즉 똑같은 테이블을 합치는 조인
![](https://velog.velcdn.com/images/piczo/post/a482cd06-5b46-4a95-9ce6-cb0674c20203/image.png)
위 테이블을 보면 고객의 이름과 그 고객의 배우자의 아이디는 알 수 있지만, 배우자의 성과 이름은 바로 알지 못하는 상황이다. 
이처럼 customer 테이블에 배우자의 성과 이름을 붙여주고 싶을 때 셀프 조인을 사용한다. customer 테이블을 customer 테이블에 조인하여 customer 테이블 안에 있는 데이터를 customer 테이블 안에 있는 데이터와 매칭 하여 옆에다가 붙인다.
```sql
SELECT
 cust.customer_id,
 cust.firstname,
 cust.lastname,
 cust.birthdate,
 cust.spouse_id,
 spouse.firstname AS spouse_firstname,
 spouse_lastname AS spouse_lastname
FROM customer AS cust
INNER JOIN customer AS spouse
   ON cust.spouse_id = spouse.customer_id
```
![](https://velog.velcdn.com/images/piczo/post/d0353b62-14a7-4dd7-8602-9398fcad5763/image.png)
**📌 셀프 조인에서 유념할 점은 셀프 조인은 테이블의 이름을 꼭 지정해줘야 한다.** 
그 이유는 똑같은 데이터가 총 2개의 테이블에 저장되어 있는 상황에서 SQL은 특정 데이터를 어떤 테이블에서 가져와야 할지 모르기 때문이다. 
SQL에서는 셀프 조인을 동일한 테이블을 합친다고 인식하지 않는다.
똑같은 테이블을 합치기 때문에 우리가 셀프 조인이라는 이름을 붙인 것이지 SQL 자체에는 셀프 조인이라는 개념이 존재하지 않는다.
그래서 셀프 조인을 하고 싶을 때 SQL 문에다가** 서로 다른 테이블 별칭을 주어 서로 다른 테이블 2개를 조인하는 것**이라고 인식하게 한다.



---

✨ **참고 블로그**
[SELF JOIN](https://kimsyoung.tistory.com/entry/SELF-JOIN-%E4%B8%8A-%EA%B0%99%EC%9D%80-%ED%85%8C%EC%9D%B4%EB%B8%94%EC%9D%84-%EC%A1%B0%EC%9D%B8%ED%95%98%EA%B8%B0)
[ORACLE JOIN](https://gent.tistory.com/469)
