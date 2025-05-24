create table T (
  id int unsigned not null auto_increment primary key,
  name varchar(31)
);

insert into T(name) values('홍길동'), ('김길동');

select * from T;

show index from Notice;