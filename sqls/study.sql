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