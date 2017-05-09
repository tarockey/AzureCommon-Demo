--https://technet.microsoft.com/en-us/library/ms142583(v=sql.105).aspx

--creating fulltext catalog
CREATE FULLTEXT CATALOG ftCatalog AS DEFAULT;
--creating fulltext index
CREATE UNIQUE INDEX ui_ukCourse ON tb_course(courseA); 
CREATE FULLTEXT INDEX ON tb_course(courseA, title, [description]) KEY INDEX ui_ukCourse ON ftCatalog;

--populating indexing
ALTER FULLTEXT INDEX ON tb_course ENABLE; 
GO 
ALTER FULLTEXT INDEX ON tb_course START FULL POPULATION;
GO

--https://technet.microsoft.com/en-us/library/cc879300(v=sql.105).aspx
--query
Select * from tb_course WHERE CONTAINS(title, 'food or "bio*"') or CONTAINS([description], 'food or "bio*"');
Select * from tb_course WHERE CONTAINS(title, '"bio*"') ;

Select * from tb_course WHERE CONTAINS(title, 'FORMSOF(FREETEXT, Bio)');
Select * from tb_course WHERE CONTAINS([description], 'FORMSOF(FREETEXT, Bio)');


Select * from tb_course WHERE CONTAINS(courseA, 'FORMSOF(INFLECTIONAL, ENGEN)');
Select * from tb_course WHERE CONTAINS(courseA, '"EN*"') ;


Select A.* from tb_course AS A INNER JOIN CONTAINSTABLE  (tb_course, courseA, '"ENG" NEAR EN') 
AS KEY_TBL ON A.courseA = KEY_TBL.[KEY]

select 
CHARINDEX(' ', courseA),
DATALENGTH( courseA),
SUBSTRING(courseA, 1, CHARINDEX(' ', courseA))
from tb_course

alter table tb_course 
add  courseCode  AS (SUBSTRING(courseA, 1, CHARINDEX(' ', courseA) -1));

select distinct courseCode from tb_course