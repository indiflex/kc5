use schooldb;

create table Major (
  id smallint unsigned auto_increment primary key comment '학과번호',
  name varchar(31) not null comment '학과명'
);

insert into Major(name) values ('철학과'), ('컴퓨터공학과'), ('건축과');

select * from Major;

create table Student(
  id int unsigned auto_increment not null comment '학번',
  createdate timestamp default current_timestamp not null comment '등록일시',
  updatedate timestamp default current_timestamp not null 
              on update current_timestamp comment '작업일시',
  birthdt varchar(10) not null comment '생년월일',
  major smallint unsigned null comment '학과ID',
  mobile varchar(11) not null comment '휴대폰 번호',
  email varchar(255) not null comment '이메일주소',
  gender bit not null default 0 comment '성별(0: 여성, 1: 남성)',
  graduatedat date null comment '졸업일',
  primary key pk_Student(id),
  foreign key fk_major_Major_id(major)
        references Major(id) on DELETE SET NULL on UPDATE CASCADE,
  unique key uniq_Student_email(email)
);
alter table Student add column name varchar(31) not null;
alter table Student modify column name varchar(31) not null after updatedate;
select * from Student;
update Student set name = concat('김', id, '수');

insert into Student(name, birthdt, major, mobile, email) 
  values ('김1수', '19900101', 1, '01001000001', '1@gmail.com'), 
        ('김3수', '19900102', 3, '01001000002', '3@gmail.com');
        
insert into Student(name, birthdt, major, mobile, email) 
  values ('김4수', '19900101', 1, '01001000004', '4@gmail.com');

select * from Student;
select * from Major;
update Student set major = null where id = 4;

select s.*, m.name from Student s inner join Major m on s.major = m.id;
select s.*, m.name from Student s inner join Major m on s.major = m.id
 where s.birthdt >= '19900102';
 
select s.*, m.name from Student s left outer join Major m on s.major = m.id;

create table StudentLike like Student;
select * from StudentLike;
show create table StudentBackup;

insert into StudentLike select * from Student;

create table StudentBackup AS select * from Student;
select * from StudentBackup;

drop table StudentLike;
drop table StudentBackup;

select * from Student;
set time_zone = 'Asia/Seoul';

select last_insert_id();

drop table if exists Prof;
create table Prof (
  id smallint unsigned auto_increment not null primary key,
  name varchar(31) not null,
  likecnt int not null default 0
);

drop table if exists Subject;
create table Subject (
  id mediumint unsigned auto_increment not null primary key,
  name varchar(15) not null,
  prof smallint unsigned null,
  foreign key fk_Subject_prof_Prof (prof)
    references Prof(id) on update cascade on delete set null
);

create table Enroll (
  id int unsigned auto_increment not null primary key,
  student int unsigned not null,
  subject mediumint unsigned not null,
  foreign key fk_Enroll_student_Student (student)
    references Student(id) on update cascade on delete cascade,
  foreign key fk_Enroll_subject_Subject (subject)
    references Subject(id) on update cascade on delete cascade
);

desc Student;

select * from Student where name like '%수';
select * from Student where name like '김%수';
select * from Student where name like '김__수';

select * from Student where id >= 1 and id <= 3;
select * from Student where id between 1 and 3;
select * from Student where id >= 1 or id <= 3;
select * from Student where id >= 1
UNION ALL
select * from Student where id <= 3;

select * from Student order by id desc limit 2;

select * from Student order by id asc limit 2 offset 1;
select * from Student order by id asc limit 1, 2;

select * from Student s inner join Major m on s.major = m.id
 where s.id in (1,3); -- raw sql

select * from Student where id in (1,3);
select * from Major where id = 1;
select * from Major where id = 2;
desc Prof;
alter table Major add column prof smallint unsigned null comment '담당교수';

select * from Student where name like '김%';
select * from Major where name like '%학과';

select * from Student s inner join Major m on s.major = m.id
 where s.name like '김%' and m.name like '%학과';

select * from Student s inner join Major m on s.major = m.id
 where s.id > 2;

select * from Student
-- update Student set gender = 1
 where id > 2;

update Student s inner join Major m on s.major = m.id
   set s.gender = 1
 where s.name like '김%' and m.name like '%학과';
 
-- update <from 부분> set <변경부분> where ... (주의! 항상 select 를 먼저 하고 수행)
update Student s inner join Major m on s.major = m.id
   set s.gender = 1, m.prof = 2
 where s.id > 2;
 
select * from Prof;
insert into Prof(name) values('김교수'), ('박교수'), ('최교수');

start transaction;
 
select * from Student s inner join Major m on s.major = m.id
 where s.name like '김%' and m.name like '%학과';
 
-- join 결과 중에 지우고 싶은 하나의 테이블을 delete 다음에 적워줘!
delete s from Student s inner join Major m on s.major = m.id
 where s.name like '김%' and m.name like '%학과';
 
select * from Student where id > 0;
delete from Student;

rollback;

show index from Student;
explain select * from Student where email like 'a%';
explain select * from Student where email like 'a%' or email like 'b%';
explain select * from Student where email between 'a' and 'z';
