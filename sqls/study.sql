select database() from dual;

create table T (
  id int unsigned auto_increment not null primary key,
  name varchar(31) not null
);

select * from T;

select t.*  from T t where id = 3;

delete from T where name='최길동';

select * from T where name like '%길동';
select * from T where mobile like '0101234%';

show index from T;

insert into T(name, email, mobile) values('홍길동1', 'hong@gmail.com', '01012340010')
 on duplicate key update name = concat(name, '1');

insert ignore into T(name, email, mobile) values('박길동x', 'park@gmail.com', '01012340002');

alter table T add column email varchar(255) null;

alter table T add column mobile varchar(11) not null;

update T set mobile = concat('0101234000', id);

show processlist;

select * from Emp;
desc Emp;
select * from Dept;

alter table Dept add column captain int unsigned null;
alter table Dept add constraint fk_Dept_captain_Emp foreign key (captain)
    references Emp(id) on update cascade on delete set null;
    
show index from Dept;
show index from Emp;
show create table Emp;
CREATE TABLE `Emp` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `ename` varchar(31) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `dept` tinyint unsigned NOT NULL,
  `salary` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `dept` (`dept`),
  CONSTRAINT `emp_ibfk_1` FOREIGN KEY (`dept`) REFERENCES `Dept` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=253 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

create table EmailLog(
  id int unsigned not null auto_increment primary key,
  sender int unsigned not null comment '발신자',
  receiver varchar(1024) not null comment '수신자',
  subject varchar(255) not null default '' comment '제목',
  body text null comment '내용',
  foreign key fk_EmailLog_sender_Emp (sender)
    references Emp(id) on update cascade on delete no action
) ENGINE = MyIsam;

select * from Dept;

select * from Emp where dept = (select max(id) from Dept);
select * from Emp where dept = (select min(id) from Dept);

select * from Emp
 where dept in (select min(id) from Dept UNION select max(id) from Dept);
 
select dept, avg(salary) avgsal from Emp group by dept;
select dept, avg(salary) avgsal -- 5
  from Emp  -- 1
 where dept > 5  -- 2
 group by dept -- 3
 having count(*) >= 40 -- 4
 order by dept desc -- 6
 limit 1; -- 7

-- cnt = count(*)
select * from Emp where dept > 5;
select dept, count(*), avg(salary) from Emp where dept > 5 group by dept;
select dept, count(*) cnt, avg(salary) from Emp where dept > 5
 group by dept having cnt >= 40;
select dept, count(*) cnt, avg(salary) avgsal from Emp where dept > 5
 group by dept having cnt >= 40 order by dept desc;
 
-- 부서 별 급여 평균이 전체 평균보다 높은 부서의 id와 평균 급여를 구하시오.
select dept, avg(salary) from Emp group by dept;
select avg(salary) from Emp;

select dept, avg(salary) avgsal from Emp
 group by dept having avgsal > (select avg(salary) from Emp);
 
-- 부서 별 급여 평균이 전체 평균보다 높은 부서의 id와 평균 급여를 구하시오. <-- 부서명 같이!
-- 1) sub-query (50)
select e.dept, (select dname from Dept where id = e.dept) as 'deptname',
       avg(salary) avgsal from Emp e
 group by dept having avgsal > (select avg(salary) from Emp);

-- 2) join (95)
select main.dept, d.dname, main.avgsal 
  from (select dept, avg(salary) avgsal
          from Emp
         group by dept
         having avgsal > (select avg(salary) from Emp)) main
    inner join Dept d on main.dept = d.id;
    
-- 3) join 2 (100)
select e.dept, max(d.dname) '부서명', avg(salary) avgsal
  from Emp e inner join Dept d on e.dept = d.id
 group by e.dept having avgsal > (select avg(salary) from Emp);
 
-- `전체 평균`보다 `더 높은 급여`를 가진 직원 목록을 출력하시오.
-- (부서id, 부서명, 직원id, 직원명, 급여)
select e.dept, d.dname, e.id, e.ename, e.salary
  from Emp e inner join Dept d on e.dept = d.id
 where salary > (select avg(salary) from Emp);

-- `부서 별` `최고 급여자` 목록을 추출하시오.
update Emp set salary = 901 + dept
  where id in (152, 97,18,80,133,47,128);
  
-- phase 1) 부서별 최고 급여
select dept, max(salary) from Emp group by dept;
select * from Emp where dept = 1 and salary = 902;
  
-- phase 2) 최고 급여와 부서를 join으로 filtering
select e.dept, d.dname, e.ename, e.id, e.salary
  from Emp e inner join (select dept, max(salary) maxsal from Emp group by dept) ms
                on e.dept = ms.dept and e.salary = ms.maxsal
             inner join Dept d on e.dept = d.id
 order by e.dept;


-- ex P.49) Dept 테이블에 이름이 가장 빠른 직원(가나다 순)을 captain으로 update 하시오
select dept, min(ename) from Emp group by dept;

select e.*, m.minName
  from Emp e inner join (select dept, min(ename) minName from Emp group by dept) m
             on e.dept = m.dept and e.ename = m.minName;
 
select * from Dept;
select * from Emp where ename='김바순';
select * from Emp where id = 207;
update Emp set name where id = 207;

-- select 먼저!
select d.id, d.dname, d.captain, (select min(ename) from Emp where dept = d.id)
 from Dept d;
 
-- 만약에 captain에 이름이 들어간다면... but, captain = emp.id
update Dept d set captain = (select min(ename) from Emp where dept = d.id);

select d.*, m.*, e.id
  from Dept d inner join (select dept, min(ename) minName from Emp group by dept) m
                      on d.id = m.dept
              inner join Emp e on m.dept = e.dept and m.minName = e.ename;
              
update Dept d inner join (select dept, min(ename) minName from Emp group by dept) m
                      on d.id = m.dept
              inner join Emp e on m.dept = e.dept and m.minName = e.ename
   set d.captain = e.id;
              
select d.*, e.ename, e.salary from Dept d inner join Emp e on d.captain = e.id;

select * from Emp
 where ename = SOME(select min(ename) from Emp group by dept)
 order by dept;

-- ex. Emp table에 outdt(퇴사일) 컬럼 추가
alter table Emp add column outdt varchar(10) null comment '퇴사일';
select * from Emp;

-- 1) Emp.id가 3, 5 인 직원을 4월 25일자 퇴사 처리하시오.
select * from Emp where id in (3,5);
update Emp set outdt='2025-04-25' where id in (3,5);

select curdate();

-- 2) Emp.id가 14, 26 인 직원을 오늘자 퇴사 처리하시오. 만약 Dept.captain이 퇴사자면 공석으로 처리!
select * from Dept;
select * from Emp e left outer join Dept d on e.id = d.captain
 where e.id in (14, 26);
 
update Emp e left outer join Dept d on e.id = d.captain
   set e.outdt = curdate(), d.captain = null
 where e.id in (14, 26);
 
-- ex.Dept 테이블에 empcnt 컬럼 추가하고, Emp 테이블의 Trigger를 이용하여 부서별 직원수를 관리하시오.
alter table Dept add column empcnt smallint unsigned not null default 0;
select * from Dept;

update Dept d
   set empcnt = (select count(*) from Emp where dept = d.id);
   
select * from Emp where dept = 6;
   
select f_empinfo(99999);
select *, f_empinfo(captain) capName from Dept;
select id, f_empinfo(id) from Emp order by id limit 10;
update Emp set dept = null where id = 4;

select d.*, e.ename as capName, (select avg(salary) from Emp where dept = d.id) avgsal
  from Dept d left outer join Emp e on d.captain = e.id
 where d.dname like '%업%';
 
select d.*, e.ename as capName, adept.avgsal
  from Dept d inner join (select dept, avg(salary) avgsal from Emp group by dept) adept
                 on d.id = adept.dept
              left outer join Emp e on d.captain = e.id
 where d.dname like '%업%';
 
call sp_deptinfo('업');
desc Dept;
desc Emp;

call sp_dept_sal();
select * from Dept order by id desc;

select min(salary), sum(case when salary = 100 then 1 else 0 end)
          from Emp where dept = 1;
select minsal, (select count(*) from Emp where dept = 1 and salary = minsal)
  from (select min(salary) minsal
          from Emp where dept = 1) sub;
          
with MinSal AS (select min(salary) minsal from Emp where dept = 1),
    MinSalCnt AS (select min(salary), count(*) from Emp
                   where dept = 1 and salary = (select minsal from MinSal limit 1))
 select * from MinSalCnt;
    
        
select * from Emp where dept = 1 and salary = 100;

WITH 
  AvgSal AS (
    select d.dname, avg(e.salary) avgsal
      from Dept d inner join Emp e on d.id = e.dept
     group by d.id
  ),
  MaxAvgSal AS (
    select * from AvgSal order by avgsal desc limit 1
  ),
  MinAvgSal AS (
    select * from AvgSal order by avgsal limit 1
  ),
  SumUp AS (
    select '최고' as gb, m1.* from MaxAvgSal m1
    UNION
    select '최저' as gb, m2.* from MinAvgSal m2
  )
select gb, dname, format(avgsal * 10000,0) from SumUp
UNION
select '', '차액', format( (max(avgsal) - min(avgsal)) * 10000, 0) from SumUp;

WITH RECURSIVE CteDept(id, pid, pname, dname, dx, h) AS 
(
    select id, pid, cast('' as char(31)), dname, 0, cast(id as char(10)) from Dept where pid = 0
    UNION ALL
    select d.id, d.pid, cte.dname, d.dname, dx + 1, concat(cte.h, '-', d.id) 
      from Dept d inner join CteDept cte on d.pid = cte.id
)
select /*+ SET_VAR(cte_max_recursion_depth = 5) */ dx, dname, h from CteDept order by h;

select id, dname, empcnt, lead(empcnt, 1) over () '다음 직원 수'
  from Dept order by id;

select row_number() over (order by dept, salary desc) '순번', e.*,
    avg(salary) over (partition by dept order by salary desc) '급여 평균',
    sum(salary) over (partition by dept order by salary desc) '급여 누적치'
  from Emp e
 where ename like '박%';
 
select
    row_number() over(order by dept, salary desc) '순번',
    e.*,
    rank() over w '부서내 순위',
    dense_rank() over w '부서내 순위',
    percent_rank() over w '부서내 %순위',
    cume_dist() over w '부서내 %경계',
    ntile(3) over w '급여등급'
  from Emp e
 where ename like '박%'
 WINDOW w as (partition by dept order by dept, salary desc);
 
select p.id, d.id, (case when p.id is not null
            then max(p.dname)
            else 'Total' end
        ) as '상위부서', 
       (case when d.id is not null
            then max(d.dname)
            else '- 소계 -' end
        ) as '부서',
       format(sum(e.salary), 0) as '급여합'
  from Dept p
        inner join Dept d on p.id = d.pid
        inner join Emp e on d.id = e.dept
 group by p.id, d.id
 with rollup;
 
select (case when dept is null then '전체직원수' else dept end), 
    (case when salary is null then '직원수' else salary end), count(*) from Emp
 where dept is not null group by dept, salary
 with rollup;
 
-- pivot
select d.dname, avg(e.salary), sum(e.salary), min(e.salary), max(e.salary)
  from Emp e inner join Dept d on e.dept = d.id
 group by e.dept;
 
-- pivot
select '평균급여' as '구분',
   format(avg(if(dept = 3, salary, null)) * 10000, 0) '영업1팀',
   format(avg(case when dept = 4 then salary end) * 10000, 0) '영업2팀',
   format(avg(case when dept = 5 then salary end) * 10000, 0) '영업3팀',
   format(avg(case when dept = 6 then salary end) * 10000, 0) '서버팀',
   format(avg(case when dept = 7 then salary end) * 10000, 0) '클라팀'
 from Emp
UNION
select '급역합계',
   format(sum(salary * (dept = 3)) * 10000, 0),
   format(sum(salary * (dept = 4)) * 10000, 0),
   format(sum(salary * (dept = 5)) * 10000, 0),
   format(sum(salary * (dept = 6)) * 10000, 0),
   format(sum(salary * (dept = 7)) * 10000, 0)
 from Emp
UNION
select '최소급여',   
   format(min(IF(dept = 3, salary, ~0)) * 10000, 0),
   format(min(IF(dept = 4, salary, ~0)) * 10000, 0),
   format(min(IF(dept = 5, salary, ~0)) * 10000, 0),
   format(min(IF(dept = 6, salary, ~0)) * 10000, 0),
   format(min(IF(dept = 7, salary, ~0)) * 10000, 0)
 from Emp
UNION
select '최대급여',   
   format(max(IF(dept = 3, salary, 0)) * 10000, 0),
   format(max(IF(dept = 4, salary, 0)) * 10000, 0),
   format(max(IF(dept = 5, salary, 0)) * 10000, 0),
   format(max(IF(dept = 6, salary, 0)) * 10000, 0),
   format(max(IF(dept = 7, salary, 0)) * 10000, 0)
 from Emp;

-- json 데이터 다루기

alter table Emp add column remark json;

update Emp set remark = '{"id": 1, "age": 30, "fam": [{"id": 1, "name": "유세차"}]}'
 where id = 2;

update Emp set remark = '{"id": 3, "age": 33, "fam": [{"id": 1, "name": "유세차"}, {"id":2, "name": "홍길숭"}]}'
 where id = 3;

update Emp set remark = '{"id": 4, "age": 34, "fam": [{"id": 1, "name": "유세차"}]}'
 where id = 4;

update Emp set remark = json_object( 'id', 5, 'age', 44, 
                          'fam', json_array(
                              json_object('id', 1, 'name', '지세차'),
                              json_object('id', 2, 'name', '지세창')   )  )
 where id = 5;

select *, json_pretty(remark) from Emp where id <= 5;
select id, JSON_EXTRACT(remark, "$.id"), remark->'$.id', remark->'$.age', remark->'$.fam[0 to 2]', remark 
  from Emp where id <= 5;
  
update Emp
   set remark = json_set(remark, '$.name', '홍길동', '$.age', 55)
 where id = 2;
 
update Emp
   set remark = json_array_append(remark, '$.fam', json_object('id', 2, 'name', '유세이'))
 where id = 2;

select * from Emp where remark->'$.id' > 1;
select e.*, d.dname from Emp e inner join Dept d on e.remark->'$.id' = d.id
 where e.id <= 5;

alter table Emp add index index_Emp_remark_famxx ((
  cast(remark->>'$.fam[*].name' as char(255) array)
));

show index from Emp; -- cast(json_unquote(json_extract(`remark`,_utf8mb4\'$.fam[*].name\')) as char(255) array)

explain select * from Emp
 where '유세차' member of (remark->>'$.fam[*].name');
 -- where remark->'$.fam[0].name' = '유세차';

explain select * from Emp where abs(id) > 10;
explain select * from Emp where id > 10 or id < -10;
explain select * from Emp where id + 100 > 10;
explain select * from Emp where ename like '김%';
explain select * from Emp where id > 0 limit 1000, 10;

explain select * from Emp where id in (select captain from Dept where captain is not null);
explain select * from Emp e where exists (select * from Dept where captain = e.id);
explain select * from Emp where id in (1,2,3);

show variables like 'innodb_ft%';

desc StopWord;
create table StopWord(value varchar(31) not null);

insert into StopWord(value) values ('가까스로'), ('가령'), ('각각'), ('각자'), ('각종'), ('갖고말하자면'), ('같다'), ('같이'), ('개의치않고'), ('거니와'), ('거바'), ('거의'), ('것과'), ('것들'), ('게다가'), ('게우다'), ('겨우'), ('견지에서'), ('이르다'), ('있다'), ('겸사겸사'), ('고려하면'), ('고로'), ('공동으로'), ('과연'), ('관계없이'), ('관련이'), ('관하여'), ('관한'), ('관해서는'), ('구체적으로'), ('구토하다'), ('그들'), ('그때'), ('그래'), ('그래도'), ('그래서'), ('그러나'), ('그러니'), ('그러니까'), ('그러면'), ('그러므로'), ('그러한즉'), ('그런'), ('까닭에'), ('그런데'), ('그런즉'), ('그럼'), ('그럼에도불구하고'), ('그렇게'), ('함으로써'), ('그렇지'), ('않다면'), ('않으면'), ('그렇지만'), ('그렇지않으면'), ('그리고'), ('그리하여'), ('그만이다'), ('그에'), ('따르는'), ('그위에'), ('그저'), ('그중에서'), ('그치지'), ('않다'), ('근거로'), ('근거하여'), ('기대여'), ('기점으로'), ('기준으로'), ('기타'), ('까닭으로'), ('까악'), ('까지'), ('미치다'), ('까지도'), ('꽈당'), ('끙끙'), ('끼익'), ('나머지는'), ('남들'), ('남짓'), ('너희'), ('너희들'), ('논하지'), ('놀라다'), ('누가'), ('알겠는가'), ('누구'), ('다른'), ('방면으로'), ('다만'), ('다섯'), ('다소'), ('다수'), ('다시'), ('말하자면'), ('다시말하면'), ('다음'), ('다음에'), ('다음으로'), ('단지'), ('답다'), ('당신'), ('당장'), ('대로'), ('하다'), ('대하면'), ('대하여'), ('대해'), ('대해서'), ('댕그'), ('더구나'), ('더군다나'), ('더라도'), ('더불어'), ('더욱더'), ('더욱이는'), ('도달하다'), ('도착하다'), ('동시에'), ('동안'), ('된바에야'), ('된이상'), ('두번째로'), ('둥둥'), ('뒤따라'), ('뒤이어'), ('든간에'), ('등등'), ('딩동'), ('따라'), ('따라서'), ('따위'), ('따지지'), ('때가'), ('되어'), ('때문에'), ('또한'), ('뚝뚝'), ('해도'), ('인하여'), ('로부터'), ('로써'), ('마음대로'), ('마저'), ('마저도'), ('마치'), ('막론하고'), ('못하다'), ('만약'), ('만약에'), ('만은'), ('아니다'), ('만이'), ('만일'), ('만큼'), ('말할것도'), ('없고'), ('매번'), ('메쓰겁다'), ('모두'), ('무렵'), ('무릎쓰고'), ('무슨'), ('무엇'), ('무엇때문에'), ('물론'), ('바꾸어말하면'), ('바꾸어말하자면'), ('바꾸어서'), ('말하면'), ('한다면'), ('바꿔'), ('바로'), ('바와같이'), ('밖에'), ('안된다'), ('반대로'), ('반드시'), ('버금'), ('보는데서'), ('보다더'), ('보드득'), ('본대로'), ('봐라'), ('부류의'), ('사람들'), ('부터'), ('불구하고'), ('불문하고'), ('붕붕'), ('비걱거리다'), ('비교적'), ('비길수'), ('없다'), ('비로소'), ('비록'), ('비슷하다'), ('비추어'), ('보아'), ('비하면'), ('뿐만'), ('아니라'), ('뿐만아니라'), ('뿐이다'), ('삐걱'), ('삐걱거리다'), ('상대적으로'), ('생각한대로'), ('설령'), ('설마'), ('설사'), ('소생'), ('소인'), ('습니까'), ('습니다'), ('시각'), ('시간'), ('시작하여'), ('시초에'), ('시키다'), ('실로'), ('심지어'), ('아니'), ('아니나다를가'), ('아니라면'), ('아니면'), ('아니었다면'), ('아래윗'), ('아무거나'), ('아무도'), ('아야'), ('아울러'), ('아이'), ('아이고'), ('아이구'), ('아이야'), ('아이쿠'), ('아하'), ('아홉'), ('않기'), ('위하여'), ('위해서'), ('알았어'), ('앞에서'), ('앞의것'), ('약간'), ('양자'), ('어기여차'), ('어느'), ('년도'), ('어느것'), ('어느곳'), ('어느때'), ('어느쪽'), ('어느해'), ('어디'), ('어때'), ('어떠한'), ('어떤'), ('어떤것'), ('어떤것들'), ('어떻게'), ('어떻해'), ('어이'), ('어째서'), ('어쨋든'), ('어쩔수'), ('어찌'), ('어찌됏든'), ('어찌됏어'), ('어찌하든지'), ('어찌하여'), ('언제'), ('언젠가'), ('얼마'), ('되는'), ('얼마간'), ('얼마나'), ('얼마든지'), ('얼마만큼'), ('얼마큼'), ('엉엉'), ('가서'), ('달려'), ('한하다'), ('에게'), ('에서'), ('여기'), ('여덟'), ('여러분'), ('여보시오'), ('여부'), ('여섯'), ('여전히'), ('여차'), ('연관되다'), ('연이서'), ('영차'), ('옆사람'), ('예를'), ('들면'), ('들자면'), ('예컨대'), ('예하면'), ('오로지'), ('오르다'), ('오자마자'), ('오직'), ('오호'), ('오히려'), ('같은'), ('와르르'), ('와아'), ('왜냐하면'), ('외에도'), ('요만큼'), ('요만한'), ('요만한걸'), ('요컨대'), ('우르르'), ('우리'), ('우리들'), ('우선'), ('우에'), ('종합한것과같이'), ('운운'), ('위에서'), ('서술한바와같이'), ('윙윙'), ('으로'), ('으로서'), ('으로써'), ('응당'), ('의거하여'), ('의지하여'), ('의해'), ('의해되다'), ('의해서'), ('되다'), ('외에'), ('정도의'), ('이것'), ('이곳'), ('이때'), ('이라면'), ('이래'), ('이러이러하다'), ('이러한'), ('이런'), ('이럴정도로'), ('이렇게'), ('많은'), ('이렇게되면'), ('이렇게말하자면'), ('이렇구나'), ('이로'), ('이르기까지'), ('이리하여'), ('이만큼'), ('이번'), ('이봐'), ('이상'), ('이어서'), ('이었다'), ('이와'), ('이와같다면'), ('이외에도'), ('이용하여'), ('이유만으로'), ('이젠'), ('이지만'), ('이쪽'), ('이천구'), ('이천육'), ('이천칠'), ('이천팔'), ('듯하다'), ('인젠'), ('일것이다'), ('일곱'), ('일단'), ('일때'), ('일반적으로'), ('일지라도'), ('임에'), ('틀림없다'), ('입각하여'), ('입장에서'), ('잇따라'), ('자기'), ('자기집'), ('자마자'), ('자신'), ('잠깐'), ('잠시'), ('저것'), ('저것만큼'), ('저기'), ('저쪽'), ('저희'), ('전부'), ('전자'), ('전후'), ('점에서'), ('정도에'), ('제각기'), ('제외하고'), ('조금'), ('조차'), ('조차도'), ('졸졸'), ('좋아'), ('좍좍'), ('주룩주룩'), ('주저하지'), ('않고'), ('줄은'), ('몰랏다'), ('줄은모른다'), ('중에서'), ('중의하나'), ('즈음하여'), ('즉시'), ('지든지'), ('지만'), ('지말고'), ('진짜로'), ('쪽으로'), ('차라리'), ('참나'), ('첫번째로'), ('총적으로'), ('보면'), ('콸콸'), ('쾅쾅'), ('타다'), ('타인'), ('탕탕'), ('토하다'), ('통하여'), ('틈타'), ('펄렁'), ('하게될것이다'), ('하게하다'), ('하겠는가'), ('하고'), ('하고있었다'), ('하곤하였다'), ('하구나'), ('하기'), ('하기는한데'), ('하기만'), ('하면'), ('하기보다는'), ('하기에'), ('하나'), ('하느니'), ('하는'), ('김에'), ('편이'), ('낫다'), ('하는것도'), ('하는것만'), ('하는것이'), ('하는바'), ('하더라도'), ('하도다'), ('하도록시키다'), ('하도록하다'), ('하든지'), ('하려고하다'), ('하마터면'), ('할수록'), ('하면된다'), ('하면서'), ('하물며'), ('하여금'), ('하여야'), ('하자마자'), ('하지'), ('않는다면'), ('않도록'), ('하지마'), ('하지마라'), ('하지만'), ('하하'), ('이유는'), ('몰라도'), ('한데'), ('한마디'), ('한적이있다'), ('한켠으로는'), ('한항목'), ('따름이다'), ('생각이다'), ('안다'), ('지경이다'), ('힘이'), ('할때'), ('할만하다'), ('할망정'), ('할뿐'), ('할수있다'), ('할수있어'), ('할줄알다'), ('할지라도'), ('할지언정'), ('함께'), ('해도된다'), ('해도좋다'), ('해봐요'), ('해서는'), ('해야한다'), ('해요'), ('했어요'), ('향하다'), ('향하여'), ('향해서'), ('허걱'), ('허허'), ('헉헉'), ('헐떡헐떡'), ('형식으로'), ('쓰여'), ('혹시'), ('혹은'), ('혼자'), ('훨씬'), ('휘익'), ('흐흐'), ('힘입어');insert into StopWord(value) values ('가까스로'), ('가령'), ('각각'), ('각자'), ('각종'), ('갖고말하자면'), ('같다'), ('같이'), ('개의치않고'), ('거니와'), ('거바'), ('거의'), ('것과'), ('것들'), ('게다가'), ('게우다'), ('겨우'), ('견지에서'), ('이르다'), ('있다'), ('겸사겸사'), ('고려하면'), ('고로'), ('공동으로'), ('과연'), ('관계없이'), ('관련이'), ('관하여'), ('관한'), ('관해서는'), ('구체적으로'), ('구토하다'), ('그들'), ('그때'), ('그래'), ('그래도'), ('그래서'), ('그러나'), ('그러니'), ('그러니까'), ('그러면'), ('그러므로'), ('그러한즉'), ('그런'), ('까닭에'), ('그런데'), ('그런즉'), ('그럼'), ('그럼에도불구하고'), ('그렇게'), ('함으로써'), ('그렇지'), ('않다면'), ('않으면'), ('그렇지만'), ('그렇지않으면'), ('그리고'), ('그리하여'), ('그만이다'), ('그에'), ('따르는'), ('그위에'), ('그저'), ('그중에서'), ('그치지'), ('않다'), ('근거로'), ('근거하여'), ('기대여'), ('기점으로'), ('기준으로'), ('기타'), ('까닭으로'), ('까악'), ('까지'), ('미치다'), ('까지도'), ('꽈당'), ('끙끙'), ('끼익'), ('나머지는'), ('남들'), ('남짓'), ('너희'), ('너희들'), ('논하지'), ('놀라다'), ('누가'), ('알겠는가'), ('누구'), ('다른'), ('방면으로'), ('다만'), ('다섯'), ('다소'), ('다수'), ('다시'), ('말하자면'), ('다시말하면'), ('다음'), ('다음에'), ('다음으로'), ('단지'), ('답다'), ('당신'), ('당장'), ('대로'), ('하다'), ('대하면'), ('대하여'), ('대해'), ('대해서'), ('댕그'), ('더구나'), ('더군다나'), ('더라도'), ('더불어'), ('더욱더'), ('더욱이는'), ('도달하다'), ('도착하다'), ('동시에'), ('동안'), ('된바에야'), ('된이상'), ('두번째로'), ('둥둥'), ('뒤따라'), ('뒤이어'), ('든간에'), ('등등'), ('딩동'), ('따라'), ('따라서'), ('따위'), ('따지지'), ('때가'), ('되어'), ('때문에'), ('또한'), ('뚝뚝'), ('해도'), ('인하여'), ('로부터'), ('로써'), ('마음대로'), ('마저'), ('마저도'), ('마치'), ('막론하고'), ('못하다'), ('만약'), ('만약에'), ('만은'), ('아니다'), ('만이'), ('만일'), ('만큼'), ('말할것도'), ('없고'), ('매번'), ('메쓰겁다'), ('모두'), ('무렵'), ('무릎쓰고'), ('무슨'), ('무엇'), ('무엇때문에'), ('물론'), ('바꾸어말하면'), ('바꾸어말하자면'), ('바꾸어서'), ('말하면'), ('한다면'), ('바꿔'), ('바로'), ('바와같이'), ('밖에'), ('안된다'), ('반대로'), ('반드시'), ('버금'), ('보는데서'), ('보다더'), ('보드득'), ('본대로'), ('봐라'), ('부류의'), ('사람들'), ('부터'), ('불구하고'), ('불문하고'), ('붕붕'), ('비걱거리다'), ('비교적'), ('비길수'), ('없다'), ('비로소'), ('비록'), ('비슷하다'), ('비추어'), ('보아'), ('비하면'), ('뿐만'), ('아니라'), ('뿐만아니라'), ('뿐이다'), ('삐걱'), ('삐걱거리다'), ('상대적으로'), ('생각한대로'), ('설령'), ('설마'), ('설사'), ('소생'), ('소인'), ('습니까'), ('습니다'), ('시각'), ('시간'), ('시작하여'), ('시초에'), ('시키다'), ('실로'), ('심지어'), ('아니'), ('아니나다를가'), ('아니라면'), ('아니면'), ('아니었다면'), ('아래윗'), ('아무거나'), ('아무도'), ('아야'), ('아울러'), ('아이'), ('아이고'), ('아이구'), ('아이야'), ('아이쿠'), ('아하'), ('아홉'), ('않기'), ('위하여'), ('위해서'), ('알았어'), ('앞에서'), ('앞의것'), ('약간'), ('양자'), ('어기여차'), ('어느'), ('년도'), ('어느것'), ('어느곳'), ('어느때'), ('어느쪽'), ('어느해'), ('어디'), ('어때'), ('어떠한'), ('어떤'), ('어떤것'), ('어떤것들'), ('어떻게'), ('어떻해'), ('어이'), ('어째서'), ('어쨋든'), ('어쩔수'), ('어찌'), ('어찌됏든'), ('어찌됏어'), ('어찌하든지'), ('어찌하여'), ('언제'), ('언젠가'), ('얼마'), ('되는'), ('얼마간'), ('얼마나'), ('얼마든지'), ('얼마만큼'), ('얼마큼'), ('엉엉'), ('가서'), ('달려'), ('한하다'), ('에게'), ('에서'), ('여기'), ('여덟'), ('여러분'), ('여보시오'), ('여부'), ('여섯'), ('여전히'), ('여차'), ('연관되다'), ('연이서'), ('영차'), ('옆사람'), ('예를'), ('들면'), ('들자면'), ('예컨대'), ('예하면'), ('오로지'), ('오르다'), ('오자마자'), ('오직'), ('오호'), ('오히려'), ('같은'), ('와르르'), ('와아'), ('왜냐하면'), ('외에도'), ('요만큼'), ('요만한'), ('요만한걸'), ('요컨대'), ('우르르'), ('우리'), ('우리들'), ('우선'), ('우에'), ('종합한것과같이'), ('운운'), ('위에서'), ('서술한바와같이'), ('윙윙'), ('으로'), ('으로서'), ('으로써'), ('응당'), ('의거하여'), ('의지하여'), ('의해'), ('의해되다'), ('의해서'), ('되다'), ('외에'), ('정도의'), ('이것'), ('이곳'), ('이때'), ('이라면'), ('이래'), ('이러이러하다'), ('이러한'), ('이런'), ('이럴정도로'), ('이렇게'), ('많은'), ('이렇게되면'), ('이렇게말하자면'), ('이렇구나'), ('이로'), ('이르기까지'), ('이리하여'), ('이만큼'), ('이번'), ('이봐'), ('이상'), ('이어서'), ('이었다'), ('이와'), ('이와같다면'), ('이외에도'), ('이용하여'), ('이유만으로'), ('이젠'), ('이지만'), ('이쪽'), ('이천구'), ('이천육'), ('이천칠'), ('이천팔'), ('듯하다'), ('인젠'), ('일것이다'), ('일곱'), ('일단'), ('일때'), ('일반적으로'), ('일지라도'), ('임에'), ('틀림없다'), ('입각하여'), ('입장에서'), ('잇따라'), ('자기'), ('자기집'), ('자마자'), ('자신'), ('잠깐'), ('잠시'), ('저것'), ('저것만큼'), ('저기'), ('저쪽'), ('저희'), ('전부'), ('전자'), ('전후'), ('점에서'), ('정도에'), ('제각기'), ('제외하고'), ('조금'), ('조차'), ('조차도'), ('졸졸'), ('좋아'), ('좍좍'), ('주룩주룩'), ('주저하지'), ('않고'), ('줄은'), ('몰랏다'), ('줄은모른다'), ('중에서'), ('중의하나'), ('즈음하여'), ('즉시'), ('지든지'), ('지만'), ('지말고'), ('진짜로'), ('쪽으로'), ('차라리'), ('참나'), ('첫번째로'), ('총적으로'), ('보면'), ('콸콸'), ('쾅쾅'), ('타다'), ('타인'), ('탕탕'), ('토하다'), ('통하여'), ('틈타'), ('펄렁'), ('하게될것이다'), ('하게하다'), ('하겠는가'), ('하고'), ('하고있었다'), ('하곤하였다'), ('하구나'), ('하기'), ('하기는한데'), ('하기만'), ('하면'), ('하기보다는'), ('하기에'), ('하나'), ('하느니'), ('하는'), ('김에'), ('편이'), ('낫다'), ('하는것도'), ('하는것만'), ('하는것이'), ('하는바'), ('하더라도'), ('하도다'), ('하도록시키다'), ('하도록하다'), ('하든지'), ('하려고하다'), ('하마터면'), ('할수록'), ('하면된다'), ('하면서'), ('하물며'), ('하여금'), ('하여야'), ('하자마자'), ('하지'), ('않는다면'), ('않도록'), ('하지마'), ('하지마라'), ('하지만'), ('하하'), ('이유는'), ('몰라도'), ('한데'), ('한마디'), ('한적이있다'), ('한켠으로는'), ('한항목'), ('따름이다'), ('생각이다'), ('안다'), ('지경이다'), ('힘이'), ('할때'), ('할만하다'), ('할망정'), ('할뿐'), ('할수있다'), ('할수있어'), ('할줄알다'), ('할지라도'), ('할지언정'), ('함께'), ('해도된다'), ('해도좋다'), ('해봐요'), ('해서는'), ('해야한다'), ('해요'), ('했어요'), ('향하다'), ('향하여'), ('향해서'), ('허걱'), ('허허'), ('헉헉'), ('헐떡헐떡'), ('형식으로'), ('쓰여'), ('혹시'), ('혹은'), ('혼자'), ('훨씬'), ('휘익'), ('흐흐'), ('힘입어');

CREATE TABLE Notice(
  id int unsigned not null auto_increment Primary Key,
  createdate timestamp not null default CURRENT_TIMESTAMP comment '작성일',
  workdate timestamp not null default CURRENT_TIMESTAMP
           on Update CURRENT_TIMESTAMP comment '수정일',
  title varchar(255) not null comment '제목',
  writer int unsigned null comment '작성자',
  contents text null comment '내용'
);

ALTER TABLE Notice ADD CONSTRAINT fk_Notice_writer
  FOREIGN KEY (writer) REFERENCES Emp(id) ON DELETE SET NULL;

CREATE FULLTEXT INDEX ft_idx_Notice_title_contents
       on Notice(title, contents);

insert into Notice(title, contents) values
 ('세종대왕', '조선의 제4대 국왕이다.'),
 ('단군', '단군왕검(檀君王儉)은 한민족의 시조이자 고조선(古朝鮮)의 국조(國祖), 대종교의 시작.'),
 ('정약용', '조선 후기의 문신이자 실학자·저술가·시인·철학자·과학자·공학자이다.'),
 ('계백', '백제 말기의 군인이다.'),
 ('이순신', '조선 중기의 무신이었다. 본관은 덕수(德水), 자는 여해(汝諧), 시호는 충무(忠武).'),
 ('김유신', '신라의 화랑의 우두머리였으며 태대각간(太大角干)이었고 신라에 귀순한 가야 왕족의 후손.');
 
explain select * from Notice where contents like '%조선%';

explain select * from Notice where match(title, contents) against('조선');

SET GLOBAL innodb_optimize_fulltext_only = ON;
OPTIMIZE TABLE testdb.Notice;
SET GLOBAL innodb_optimize_fulltext_only = OFF;

select * from information_schema.innodb_ft_index_table;

show variables like 'innodb_ft%';

select * from Notice  where match(title, contents) against('이순신');

select * from Notice
  where match(title, contents) against('이순신+본관은' in boolean mode);
  
select * from Notice
 where match(title, contents) against('고조선* 조선*' IN boolean mode);
 
select * from Notice where match(title, contents) against('고조선');
 
select * from Notice
 where match(title, contents) against('고조선* 조선* -이순신*' IN boolean mode);
select * from Notice
 where match(title, contents) against(concat('고조선', '*') IN boolean mode);

-- ex1) 문신과 무신 모두 출력하시오.
select * from Notice
 where match(title, contents) against('무신* 문신*' IN boolean mode);
 
-- ex2) 문신과 무신 중 후기 인물은 제외하시오.
select * from Notice
 where match(title, contents) against('무신* 문신* -후기*' IN boolean mode);

-- ex3) 문신과 무신 중 중기 인물만 출력하시오.
select * from Notice
 where match(title, contents) against('무신* 문신* +중기*' IN boolean mode);


-- backup & restore
-- select * from T;
select * from Dept;
update Dept set dname = '프론트엔드팀' where id = 7;
update Dept set dname = '백엔드팀' where id = 6;

update Dept set dname = '이상한팀';