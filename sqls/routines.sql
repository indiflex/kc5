select s.*, p.name
  from Subject s left outer join Prof p on s.prof = p.id;
  
select * from Subject;
select * from Prof;
insert into Subject(name, prof)
             values('전산학', 1),('DB', 2),('NW', 3),('AI', null);
             
-- grant all privileges on schooldb.v_subject to xuser@'%';
select * from v_subject where name='NW';