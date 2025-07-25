/**
* MYSQL :: 정형 데이터를 저장하는 데이터베이스
- SQL 문법을 사용하여 데이터를 CRUD 한다.
- C(Create : 생성, insert)
- R(Read : 조회, select)
- U(Update : 수정, update)
- D(Delete : 삭제, delete)
- 개발자는 DML에 대한 CRUD 명령어를 잘 사용할 수 있어야한다!!!
- SQL은 대소문자 구분하지 않음, 보통 소문자로 작성
- snake 방식의 네이밍 규칙을 가짐

- SQL은 크게 DDL, DML, DCL, DTL로 구분할 수 있다.
1. DDL(Data Definition Language) : 데이터 정의어
	: 데이터를 저장하기 위한 공간을 생성하고 논리적으로 정의하는 언어
    : create, alter, truncate, drop
2. DML(Data Manipulation Language) : 데이터 조작어
	: 데이터를 CRUD하는 명령어
    :insert, select, update, delete
3. DCL(Data Control Language) : 데이터 제어어
	: 데이터에 대한 권한과 보안을 정의하는 언어
    : grant, revoke
4. DTL(Data Transaction Language, TCL) : 트랜잭션 제어어
	: 데이터베이스의 처리 작업 단위인 트랜잭션을 관리하는 언어
    : commit, save, rollback
*/

/* 반드시 기억해 주세요!!!  - 워크벤치 실행시 마다 명령어 실행!!!! */
show databases;		-- 모든 데이터베이스 조회
use hrdb2019;	-- 사용할 데이터베이스 오픈
select database();	-- 데이터베이스 선택
show tables;	-- 데이터베이스의 모든 테이블 조회

/************************************
	DESC(DESCRIBE) : 테이블 구조 확인
    형식 > desc(describe) [테이블명];
*************************************/
show tables;
desc employee;
desc department;
desc unit;
desc vacation;

/********************************************
	SELECT : 테이블 내용 조회
    형식 > selcet [컬럼리스트] from [테이블명];
*********************************************/
select emp_id, emp_name from employee;
select * from employee;
select emp_name, gender, hire_date from employee;

-- 사원테이블의 사번, 사원명, 성별, 입사일, 급여를 조회
desc employee;
select emp_id, emp_name, gender, hire_date, salary from employee;

-- 부서테이블의 모든 정보 조회
show tables;
select * from department;

-- AS : 컬럼명 별칭 부여
-- 형식 > selcet [컬럼명 as 별칭, ...] from [테이블명];
-- 사원테이블의 사번, 사원명, 성별, 입사일, 급여 컬럼을 조회한 한글 컬럼명으로 출력
select emp_id as 사번, emp_name as 사원명, gender as "성 별", hire_date 입사일, salary 급여 
from employee;

-- 사원테이블의 ID, NAME, GENDER, HDATE, SALARY 컬럼명으로 조회
select emp_id ID, emp_name NAME, gender GENDER, hire_date HDATE, salary SALARY 
from employee;

-- 사원테이블의 사번, 사원명, 부서명, 폰번호, 이메일, 급여, 보너스(급여*10%)를 조회
-- 기존의 컬럼에 연산을 수행하여 새로운 컬럼을 생성할 수 있다!!
desc employee;
select emp_id, emp_name, dept_id, phone, email, salary, salary*10 as bonus 
from employee;

-- 현재 날짜를 조회
select curdate() as DATE 
from dual;

/**********************************
	SELECT : 테이블 내용 상세 조회
    형식 > selcet [컬럼리스트] 
			from [테이블명]
            where [조건절];
**********************************/
-- 정주고 사원의 정보를 조회
select * from employee;
select * from employee 
where emp_name = "정주고";		-- ''도 사용 가능

-- sys 부서에 속한 모든 사원을 조회
select * 
from employee 
where dept_id = "sys";

-- 사번이 S0005인 사원의 사원명, 성별, 입사일, 부서아이디, 이메일, 급여를 조회
select emp_name, gender, hire_date, dept_id, email, salary 
from employee 
where emp_id = "S0005";

-- sys부서에 속한 모든 사원들을 조회, 단 출력되는 emp_id 컬럼은 '사원번호' 별칭으로 조회
desc employee;
select emp_id as 사원번호, emp_name, eng_name, gender, hire_date, salary 
from employee 
where dept_id = "sys";

-- emp_name '사원명' 별칭 수정
select emp_id as 사원번호, emp_name 사원명, eng_name, gender, hire_date, salary 
from employee 
where dept_id = "sys";

-- !! where 조건절 컬럼으로 별청을 사용할 수 있을까요???
-- 사원명이 홍길동인 사원을 별칭으로 조회??? :: where 조건절에서 별칭을 컬럼명으로 사용할 수 없다!
select emp_id as 사원번호, emp_name 사원명, eng_name, gender, hire_date, salary 
from employee 
where 사원명 = "홍길동";

-- 전략기획 부서의 모든 사원들의 사번, 사원명, 입사일, 급여를 조회
select * from department;
select emp_id, emp_name, hire_date, salary, dept_id 
from employee 
where dept_id = "STG";

-- 입사일이 2014년 8월 1일인 사원들을 조회
select * 
from employee 
where hire_date = "2014-08-01";	-- DATE 타입은 표현은 문자열처럼, 처리는 숫자처럼

-- 급여가 5000인 사원들을 조회
select * 
from employee
where salary = 5000;

-- 성별이 남자인 사원들을 조회
select * 
from employee 
where gender = "M";

-- 성별이 여자인 사원들을 조회
select * 
from employee 
where gender = "F";

-- NULL : 아직 정의되지 않은 미지수 -> 가장 큰 수가 됨(가장 마지막에 나옴)
-- 숫자에서는 가장 큰 수로 인식, 논리적인 의미를 포함하고 있으므로 등호(=)로는 검색이 안됨. is키워드와 함께 사용 가능
-- 급여가 NULL인 값을 가진 사원들을 조회
select * 
from employee 
where salary is null;

-- 영어이름이 정해지지 않은 사원들을 조회
select * 
from employee 
where eng_name is null; 

-- 퇴사하지 않은 사원들을 조회
select * 
from employee 
where retire_date is null;

-- 퇴사하지 않은 사원들의 보너스 칼럼(급여*20%)을 추가하여 조회
select emp_name, dept_id, salary, salary*20 as bonus 
from employee 
where retire_date is null;

-- 퇴사한 사원들의 사번, 사원명, 이메일, 폰번호, 급여를 조회
select emp_id, emp_name, email, phone, salary 
from employee 
where retire_date is not null;

-- IFNULL : NULL 값을 다른 값으로 대체하는 방법
-- 형식 > ifnull(null 포함 컬럼명, 대체값)

-- STG 부서에 속한 사원들의 정보 조회. 단, 급여가 NULL인 사원은 0으로 치환
select emp_id, emp_name, email, phone, ifnull(salary, 0) as salary 
from employee 
where dept_id = "STG";

-- 사원 전체 테이블의 내용을 조회. 단, 영어이름이 정해지지 않은 사원들은 'SMITH' 이름으로 치환
select emp_id, emp_name, ifnull(eng_name, "SMITH") as eng_name, hire_date, salary 
from employee;

-- MKT 부서의 사원들을 조회, 재직중인 사원들의 retire_date 컬럼은 현재 날짜로 치환
select emp_id, emp_name, gender, hire_date, ifnull(retire_date, curdate()) as retire_date, dept_id, salary 
from employee 
where dept_id = "MKT";

/*****************************************
	DISTINCT : 중복된 데이터를 배제하고 조회
    형식 > selcet distinct [컬럼리스트] 
			from [테이블명]
            where [조건절];
*****************************************/
-- 사원테이블의 부서리스트를 조회
select distinct dept_id from employee;

-- 주의!! UNIQUE한 컬럼과 함께 조회하는 경우 distinct가 적용되지 않음
select distinct emp_id, dept_id from employee;

/**********************************************
	ORDER BY : 데이터 정렬
    형식 > selcet [컬럼리스트] 
			from [테이블명]
            where [조건절]
            order by [컬럼명, ...] asc/desc;
**********************************************/
-- 급여를 기준으로 오름차순 정렬
select * 
from employee order by salary asc;

-- 모든 사원을 급여, 성별을 기준으로 오름차순 정렬
select * 
from employee order by salary, gender;

-- eng_name이 NULL인 사원들을 입사일 기준으로 내림차순 정렬
select * 
from employee 
where eng_name is null order by hire_date desc;

-- 퇴직한 사원들을 급여기준으로 내림차순 정렬
select * 
from employee 
where retire_date is not null order by salary desc;

-- 퇴직한 사원들을 급여기준으로 내림차순 정렬, salary 컬럼을 '급여' 별칭으로 치환
-- '급여' 별칭으로 order by가 가능할까요??? :: 별칭으로 order by 가능함!
-- where 조건절 데이터 탐색 > 출력할 컬럼리스트 만들기 > order by 정렬 진행
select emp_id, emp_name, dept_id, hire_date, retire_date, salary as 급여 
from employee 
where retire_date is not null order by 급여 desc;

-- 정보시스템(SYS) 부서 사원들 중 입사일이 빠른 순서, 급여를 많이 받는 순서로 정렬
-- hire_date, salary 컬럼은 '입사일', '급여' 별칭으로 컬럼리스트 생성 후 정렬
select emp_id, emp_name, dept_id, hire_date as 입사일, salary as 급여 
from employee 
where dept_id = "SYS" order by 입사일 asc, 급여 desc;

/**********************************************
	조건절 + 비교연산자 : 특정 범위 혹은 데이터 검색
    형식 > selcet [컬럼리스트] 
			from [테이블명]
            where [조건절] 비교연산자(<, >, =등)
            order by [컬럼명, ...] asc/desc;
**********************************************/
-- 급여가 5000 이상인 사원들을 조회, 급여를 오름차순 정렬
select * 
from employee 
where salary >= 5000 order by salary;

-- 입사일이 2017-01-01 이후 입사한 사원들을 조회
select * 
from employee 
where hire_date > "2017-01-01";

-- 입사일이 2015-01-01 이후거나, 급여가 6000 이상인 사원들을 조회
-- ~이거나, ~또는 : OR - 두개의 조건 중 하나만 만족해도 조회 가능
select * 
from employee 
where hire_date > "2015-01-01" or salary >= 6000;

-- 입사일이 2015-01-01 이후이고, 급여가 6000 이상인 사원들을 조회
-- ~이고 : AND - 두개의 조건이 모두 만족해야만 조회 가능
select * 
from employee 
where hire_date > "2015-01-01" and salary >= 6000;

-- 특정 기간 : 2015-01-01 ~ 2017-12-31 사이에 입사한 모든 사원 조회
-- 부서기준으로 오름차순 정렬
select * 
from employee 
where hire_date >= "2015-01-01" and hire_date <= "2017-12-31" order by dept_id;

-- 급여가 6000 이상, 8000 이하인 사원들을 모두 조회
select * 
from employee 
where salary >= 6000 and salary <= 8000;

-- MKT 부서의 사원들의 사번, 사원명, 입사일, 이메일, 급여, 보너스(급여의 20%) 조회
-- 급여가 NULL인 사원의 보너스는 기본 50
-- 보너스가 1000 이상인 사원 조회
-- 보너스가 높은 사원 기준으로 정렬
select emp_id, emp_name, hire_date, email, salary, ifnull(salary*0.2, 50) as bonus 
from employee 
where dept_id = "MKT" and salary*0.2 >= 1000 order by bonus desc;

-- 사원명이 '일지매', '오삼식', '김삼순' 인 사원들을 조회
select * 
from employee 
where emp_name = "일지매" or emp_name = "오삼식" or emp_name = "김삼순";

/**************************************************
	BETWEEN ~ AND : 논리곱
    형식 > selcet [컬럼리스트] 
			from [테이블명]
            where [컬럼명] between 값1 and 값2;
            
	IN : 논리합(OR)
    형식 > selcet [컬럼리스트] 
			from [테이블명]
            where [컬럼명] in (갑1, 값2,값3,...);
**************************************************/
-- between ~ and
-- 특정 기간 : 2015-01-01 ~ 2017-12-31 사이에 입사한 모든 사원 조회
-- 부서기준으로 오름차순 정렬
select * 
from employee 
where hire_date between "2015-01-01" and '2017-12-31' order by dept_id asc;

-- 급여가 6000 이상, 8000 이하인 사원들을 모두 조회
select * 
from employee 
where salary between 6000 and 8000;

-- in
-- 사원명이 '일지매', '오삼식', '김삼순' 인 사원들을 조회
select * 
from employee 
where emp_name in ("일지매", "오삼식", "김삼순");

-- 부서아이디가 MKT, SYS, STG에 속한 모든 사원 조회
select * 
from employee 
where dept_id in("MKT", "SYS", "STG") order by dept_id;

/*****************************************************
	와일드 문자(%, _) + LIKE 연산자 : 특정 문자열 검색
    % : 전체, _ : 한 글자
    형식 > selcet [컬럼리스트] 
			from [테이블명]
            where [컬럼명]like "와일드 문자 포함 검색어";
*****************************************************/
-- '한'씨 성을 가진 모든 사원을 조회
select * 
from employee 
where emp_name like "한%";

-- 영어이름이 'f'로 시작하는 모든 사원을 조회
select * 
from employee 
where eng_name like "f%";

-- 이메일 이름 중 두번째 자리에 'a'가 들어가는 모든사원을 조회
select * 
from employee 
where email like "_a%";

-- 이메일 아이디가 4자인 모든 사원을 조회
select * 
from employee 
where email like "____@%";

/**********************************************
	내장함수 : 숫자함수, 문자함수, 날짜함수
    호출되는 위치 - [컬럼리스트], [조건절의 컬럼명]
**********************************************/
-- [숫자함수]
-- 함수 실습을 위한 테이블 : DUAL 테이블
-- (1) abs(숫자) : 절대값
select abs(100), abs(-100) from dual;

-- (2) floor(숫자), truncate(숫자, 자리수) : 소수점 버리기
select floor(123.456), truncate(123.456, 0), truncate (123.456, 1) from dual;

-- 사원 테이블의 SYS 부서 사원들의 사번, 사원명, 부서아이디, 폰번호, 급여, 보너스(급여의 25%)컬럼을 추가하여 조회
-- 보너스 칼럼은 소수점 1자리로 출력
show tables;
select emp_id, emp_name, dept_id, phone, salary, truncate(salary*0.25, 1) as bonus
from employee
where dept_id = "SYS";

-- (3) rand() : 임의의 수를 난수로 발생시키는 함수, 0 ~ 1 사이의 난수 생성
select rand() from dual;

-- 정수 3자리(0 ~ 999) 난수 발생
select floor(rand() * 1000) as number from dual;

-- 정수 4자리(0 ~ 9999) 난수 발생, 소수점 2자리
select truncate(rand() * 10000, 2) as number from dual; 

-- (4) mod(숫자, 나누는 수) : 나머지 함수
select mod(123, 2) as odd, mod(124,2) as even from dual;

-- 3자리 수를 랜덤으로 발생시켜, 2로 나눈 후 홀수, 짝수를 구분
select mod(floor(rand() * 1000), 2) as result from dual;

-- [문자함수]
-- (1) concat(문자열1, 문자열2, ...) : 문자열을 합쳐주는 함수
select concat("안녕하세요~", ' 홍길동', "입니다.") as str from dual;

-- 사번, 사원명, 사원명2 컬럼을 생성하여 조회
-- 사원명2 컬럼의 데이터 형식은 S0001(홍길동) 출력
select 	emp_id
		, emp_name
        , concat(emp_id, "(", emp_name, ")") as emp_name2 
from employee;

-- 사번, 사원명, 영어이름, 입사일, 폰번호, 급여를 조회
-- 영어이름의 출력 형식을 홍길동/hong 타입으로 출력
-- 영어이름이  null인 경우에는 'smith'를 기본으로 조회
select 	emp_id
		, emp_name
		, concat(emp_name, "/", ifnull(eng_name, "smith")) as eng_name
        , hire_date
        , phone
        , salary
from 	employee;

-- (2) substring(문자열, 위치, 갯수) : 문자열 추출, 공백도 하나의 문자로 처리
select substring("대한민국 홍길동", 1, 4), substring("대한민국 홍길동", 6, 3) 
from dual;

-- 사원테이블의 사번, 사원명, 입사년도, 입사월, 입사일, 급여를 조회
select 	emp_id, emp_name, 
		substring(hire_date, 1, 4) as hire_year,
		substring(hire_date, 6, 2) as hire_month, 
		substring(hire_date, 9, 2) as hire_day, salary
from employee;

-- 2015년도에 입사한 모든 사원 조회
select *
from employee
where substring(hire_date, 1, 4) = 2015;

-- 2018년도에 입사한 정보시스템(sys) 부서 사원 조회
select *
from employee
where substring(hire_date, 1, 4) = 2018 and dept_id = "sys";

-- (3) left(문자열, 갯수), right(문자열, 갯수) : 왼쪽, 오른쪽 기준으로 문자열 추출
select left(curdate(), 4) as year, right('010-1234-4567', 4) as phone from dual;

-- 2018년도에 입사한 모든 사원 조회
select *
from employee
where left(hire_date, 4) = 2018;

-- 2015년부터 2017년 사이에 입사한 모든 사원 조회
select *
from employee
where left(hire_date, 4) between 2015 and 2017;

-- 사원번호, 사원명, 입사일, 폰번호, 급여를 조회
-- 폰번호는 마지막 4자리만 출력
select emp_id, emp_name, hire_date, right(phone, 4) as phone, salary
from employee;

-- (4) upper(문자열), lower(문자열) : 대문자, 소문자로 치환
select upper('welcomeToMysql!!!') as upper, lower('welcomeToMysql!!!') as lower from dual;

-- 사번, 사원명, 영어이름, 부서아이디, 이메일, 급여를 조회
-- 영어이름은 전체 대문자, 부서아이디는 소문자, 이메일은 대문자
select 	emp_id, 
		emp_name, 
		upper(eng_name) as eng_name, 
        lower(dept_id) as dept_id, 
        upper(email) as email,
        salary 
from employee;

-- (5) trim() : 공백 제거
select 	trim('      대한민국') as t1,
		trim('대한민국      ') as t2,
		trim('대한      민국') as t3,
		trim('   대한민국   ') as t4
from dual;

-- (6) format(문자열, 소수점자리) : 문자열 포맷
select format(123456, 0) as foramt from dual;
select format('123456', 0) as foramt from dual;

-- 사번, 사원명, 입사일, 폰번호, 급여, 보너스(급여의20%)를 조회
-- 급여, 보너스는 소수점 없이 3자리 콤마(,)로 구분하여 출력
-- 급여가 null인 경우에는 기본값 0
-- 2015년부터 2017년 사이에 입사한 사원
-- 사번 기준으로 내림차순 정렬
select 	emp_id
		, emp_name
        , hire_date 
        , phone
        , format(ifnull(salary, 0),0) as salary
        , format(ifnull(salary, 0)*0.2, 0) as bonus
from 	employee
where left(hire_date, 4) between 2015 and 2017 
order by emp_id desc;

-- [날짜함수]
-- curdate() : 현재 날짜(년, 월, 일)
-- sysdate(), now() : 현재 날짜(년, 월, 일, 시, 분, 초)
select curdate(), sysdate(), now() from dual;

-- [형변환 함수]
-- cast(변환하고자 하는 값 as 데이터 타입) 
-- convert(변환하고자 하는 값 as 데이터 타입) : MySQL에서 지원하는 OLD버전
select 1234 as number, cast(1234 as char) as string from dual;
select '1234' as string, cast('1234' as signed integer) as number from dual;
select '20250723' as string , cast('20250723' as date) as date from dual;
select 	now() as date
		, cast(now() as char) as string
		, cast(cast(now() as char) as date) as date
        , cast(cast(now() as char) as datetime) as datetime
        , cast(curdate() as datetime) as datetime
from 	dual;

select 	'12345' as string 
		, cast('12345' as signed integer) as cast_int
        , cast('12345' as unsigned integer) as cast_int
        , cast('12345' as decimal(10, 2)) as cast_decimal
from 	dual;

-- [문자 치환 함수]
-- replace(문자열, old, new)
select '홍-길-동' as old, replace('홍-길-동', '-', ',') as new from dual;

-- 사원테이블의 사번, 사원명, 입사일, 퇴사일, 부서아이디, 폰번호, 급여를 조회
-- 입사일, 퇴사일 출력은 '-'을 '/'로 치환하여 출력
-- 재직중인 사원은 현재날짜를 출력
-- 급여 출력시 3자리 콤마(,) 구분
select 	emp_id
		, emp_name
        , replace(hire_date, '-', '/') as hire_date
        , replace(ifnull(retire_date, curdate()), '-', '/') as retire_date
        , dept_id
        , phone
        , format(salary, 0) as salary
from 	employee;

-- '20150101' 입력된 날짜를 기준으로 해당 날짜 이후에 입사한 사원들을 모두 조회
-- 모든 MySQL 데이터베이스에서 적용 가능한 형태로 작성
select *
from employee
where hire_date >= cast('20150101' as date);

-- '20150101' ~ '20171231' 사이에 입사한 사원들을 모두 조회
-- 모든 MySQL 데이터베이스에서 적용 가능한 형태로 작성
select *
from employee
where hire_date between cast('20150101' as date) and cast('20171231' as date) ;

select *
from employee
where hire_date between '20150101' and '20171231';

/************************************************************
	그룹(집계)함수 : sum(), avg(), min(), max(), count(),...
    group by - 그룹함수를 적용하기 위한 그룹핑 컬럼 정의 
    having - 그룹함수에서 사용하는 조건절
    ** 그룹함수는 그룹핑이 가능한 반복된 데이터를 가진 컬럼과 사용O
************************************************************/
-- (1) sum(숫자) : 전체 총합을 구하는 함수
-- 사원들 전체의 급여 총액을 조회, 3자리 구분, 마지막에 '만원' 표시
select concat(format(sum(salary), 0), "만원") as 총급여 from employee;

-- (2) avg(숫자) : 전체 평균을 구하는 함수
--  사원들 전체의 급여 평균을 조회, 3자리 구분, 앞에 '$' 표시
-- 소수점은 절삭
select concat("$", format(avg(salary), 0)) as 평균급여 from employee;

-- 정보시스템(sys) 부서 전체의 급여 총액과 평균을 조회
-- 3자리 구분, 마지막에 '만원' 표시
select 	concat(format(sum(salary), 0), "만원") as 총급여
		, concat(format(avg(salary), 0), "만원") as 평균급여
from 	employee
where	dept_id = 'sys';

-- (3) max(숫자) : 최대값 구하는 함수
-- 가장 높은 급여를 받는 사원의 급여를 조회
select max(salary) from employee;

-- (4) min(숫자) : 최소값 구하는 함수
-- 가장 낮은 급여를 받는 사원의 급여를 조회
select min(salary) from employee;

-- 사원들의 총급여, 평균급여, 최대급여, 최소급여를 조회
-- 3자리 구분
select 	format(sum(salary), 0) as 총급여
		, format(avg(salary), 0) as 평균급여
        , format(max(salary), 0) as 최대급여
        , format(min(salary), 0) as 최소급여
from 	employee;

-- (5) count(컬럼) : 조건에 맞는 데이터의 row 수를 조회, null은 제외
-- 전체 row count
select count(*) from employee;	-- 20
-- 급여 컬럼의 row count
select count(salary) from employee;	-- 19

-- 재직중인 사원의 row count
select 	count(*) as 총사원
		, count(retire_date) as 퇴사자
        , count(*) - count(retire_date) as 재직자
from employee;

-- '2015'년도에 입사한 입사자 수
select count(*) as '2015년 입사자'
from employee
where left(hire_date, 4) = 2015;

-- 정보시스템(sys) 부서의 사원수
select count(*) as '정보시스템 부서 사원수'
from employee
where dept_id = "sys";

-- 가장 빠른 입사자, 가장 늦은 입사자를 조회 : max(), min() 함수를 사용
select min(hire_date) , max(hire_date)
from employee;

-- 가장 빨리 입사한 사람의 정보를 조회 : 서브쿼리로 그룹함수 사용!! 
select *
from employee
where hire_date = (select min(hire_date) from employee);

select *
from employee
where hire_date = '2013-01-01';

-- [group by] : 그룹함수와 일반컬럼을 함께 사용할 수 있도록 함
-- ~별 그룹핑이 가능한 컬럼으로 쿼리를 실행

-- 부서별 총급여, 평균급여, 사원수, 최대급여, 최소급여
select dept_id, sum(salary), avg(salary), count(*), max(salary), min(salary)
from employee
group by dept_id;

-- 연도별 사원수, 총급여, 평균급여, 최대급여, 최소급여 조회
-- 소수점X, 3자리 구분
select 	left(hire_date, 4) as 연도
		, count(*) as 사원수
		, format(sum(salary), 0) as 총급여
        , format(avg(salary), 0) as 평균급여
        , format(max(salary), 0) as 최대급여
        , format(min(salary), 0) as 최소급여
from 	employee
group by left(hire_date, 4);

-- [having 조건절] : 그룹함수를 적용한 결과에 조건을 추가

-- 부서별 총급여, 평균급여를 조회
-- 부서의 총급여가 30000 이상인 부서만 출력
-- 급여 컬럼의 null은 제외
select 	dept_id
		, format(sum(salary), 0) 총급여
        , format(avg(salary), 0) 평균급여
from 	employee
where 	salary is not null
group by dept_id
having sum(salary) >= 30000;

-- 연도별 사원수, 총급여, 평균급여, 최대급여, 최소급여 조회
-- 소수점X, 3자리 구분
-- 총급여가 30000 이상인 년도 출력
-- 급여 협상이 안된 사원은 제외
select 	left(hire_date, 4) as 연도
		, count(*) as 사원수
		, format(sum(salary), 0) as 총급여
        , format(avg(salary), 0) as 평균급여
        , format(max(salary), 0) as 최대급여
        , format(min(salary), 0) as 최소급여
from 	employee
where salary is not null
group by left(hire_date, 4)
having sum(salary) >= 30000;

-- rollup 함수 : 리포팅을 위한 함수
-- 부서별 사원수, 총급여, 평균급여 조회
select 	dept_id 부서명
		, count(*) as 사원수
        , format(sum(ifnull(salary, 0)), 0) as 총급여
        , format(avg(ifnull(salary, 0)), 0) as 평균급여
from 	employee
group by dept_id with rollup;

-- rollup한 결과의 부서아이디를 추가
select 	if(grouping(dept_id), '총합계', ifnull(dept_id, '-')) 부서명
		, count(*) as 사원수
        , format(sum(ifnull(salary, 0)), 0) as 총급여
        , format(avg(ifnull(salary, 0)), 0) as 평균급여
from 	employee
group by dept_id with rollup ;

-- 
select 	left(hire_date, 4) 연도
		, count(*) as 사원수
		, format(sum(salary), 0) as 총급여
        , format(avg(salary), 0) as 평균급여
        , format(max(salary), 0) as 최대급여
        , format(min(salary), 0) as 최소급여
from 	employee
where salary is not null
group by left(hire_date, 4) with rollup;

-- limit 함수 : 출력갯수 제한 함수
select *
from employee
limit 3;

-- 최대급여를 수급하는 사원 순서대로 5명 조회
select *
from employee
order by salary desc
limit 5;
