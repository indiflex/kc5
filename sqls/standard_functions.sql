select sum(salary) from Emp;
select dept, sum(salary) from Emp group by dept;
select conv('FF', 16, 10), power(2,3), rand();
select '2024-04-25', CAST('2024-04-25 23:55:59.111' as datetime), convert('2024-04-25', date);
select CONVERT(-1.567, signed Integer), CONVERT(abs(-1.567), unsigned Integer),
       CONVERT(-1.567, unsigned Integer);
select cast(str_to_date('2018-02-03', '%Y-%m-%d') as date);  
select date_format('2018-02-03', '%Y-%d-%m');

select dname, HEX(AES_ENCRYPT(dname, '암호키')) from Dept; -- AES_DECRYPT
select dname, AES_ENCRYPT(dname, '암호키') from Dept; -- AES_DECRYPT
select dname, AES_DECRYPT(UNHEX(HEX(AES_ENCRYPT(dname, '암호키'))), '암호키') from Dept; -- AES_DECRYPT

select sub.*, CAST(AES_DECRYPT(UNHEX(sub.enc), '암호키') as char)
from (select dname, HEX(AES_ENCRYPT(dname, '암호키')) enc from Dept) sub;

select dname, SHA2(dname, 256) from Dept;

select dept, group_concat(ename, '::', salary)
  from Emp group by dept;
  
select concat('abc', ':', 'efg', ':', null, ':', 'hij'), 
       concat_ws(':', 'abc', 'efg', null, 'hij');
       
select ifnull(captain, '공석'), if(captain is null, '공석', captain),
       (case when captain is null
             then '공석' else captain end),
       (case captain when 30 then '3333' when 51 then '555' else '공석' end),
       NullIf(captain, 150), captain
  from Dept;
  
select ascii('A'), HEX(char(65, 66)), CAST(char(65, 66) as char);
select length('AB한글'), char_length('AB한글'), bit_length('A'), sign(-2), sign(2);
select 5 % 2, mod(5, 2);
select elt(2, 'str1', 'str2', 'str3'), field('s1', 's0', 's1');
select substring('abcdefg', 2, 3);
select substring_index('a,b,c,d', ',', 2);
select substring_index(substring_index('a,b,c,d', ',', 2), ',', -1);
select substring_index(substring_index('a,b,c,d', ',', 3), ',', -1);
select instr('str', 't'), locate('s1', 's0s1s2');
select insert('12345', 3, 2, '/');
select format(123456789, 0), format(78901.012356, 4), truncate(789.012356, 4);
select left('abc', 2), right('abc', 2), upper('abc'), lower('AB'), 
lpad('5', 2, '0'), rpad('15', 3, '0');
select reverse('abc'), repeat('a', 3), concat('A', space(5), 'B');
select replace('abcdefg', 'cde', 'xxx');
select trim(' AB '), trim(both 's' from 'ssstrss');
select trim(leading 's' from 'ssstrss'), trim(trailing 's' from 'ssstrss');
select concat('X', ltrim(' AB '), 'X'), concat('X', rtrim(' AB '), 'X');
select now(), sysdate(), curdate(), curtime();
select year(now()), month(now()), day(now()), month('2020-11-29'),
	   hour(now()), minute(now()), second(now()), quarter(now()), week(now());
       
select weekday('2024-11-17'), weekday('2024-11-18'), weekday('2024-11-19');   -- 월요일 0 ~ 6
select dayofweek('2024-11-16'), dayofweek('2024-11-17'), dayofweek('2024-11-18'); -- 일요일 1 ~ 7

select DATE(now()), TIME(now()), MAKEDATE(2025, 336), MAKETIME(19,3,50), TIME('19:03:50');
select time_to_sec('0:1:30'), period_add(202012, 12), period_diff(202103, 202011);
select datediff('2024-12-01', '2025-03-11'), timediff('12:20:33', '11:30:20');

select DATE_FORMAT(DATE_ADD(NOW(), INTERVAL -1 DAY), '%Y-%m-%d %H:%i:%s');

select '12ABC' regexp '[a-z0-9]';
SELECT REGEXP_INSTR('dog cat dog', 'dog', 2);
SELECT REGEXP_INSTR('aa aaa aaaa', 'a{4}');
SELECT REGEXP_LIKE('abc', 'ABC', 'c');
SELECT REGEXP_REPLACE('abc def ghi', '[a-z]+', 'X', 2, 2);
SELECT REGEXP_REPLACE('abc def ghi', '[a-z]+', 'X', 2);