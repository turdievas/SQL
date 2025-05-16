create database puzzles
use puzzles
--puzzle1
SELECT DISTINCT
  CASE WHEN col1 < col2 THEN col1 ELSE col2 END AS col1,
  CASE WHEN col1 < col2 THEN col2 ELSE col1 END AS col2
FROM InputTbl;
--puzzle2
select*from TestMultipleZero where A<>0 or B<>0 or C<>0 or D<>0 
--puzzle3
	 select*from section1 where id%2=1
	 --puzzle4
	 select *from section1 where id= (select MIN(id) from section1)
	 --puzzle5
	 select *from section1 where id= (select MAX(id) from section1)
	 --puzzle6
	 select*from section1 where name like 'B%'
--puzzle7
select*from ProductCodes where code like '%[_]%'
