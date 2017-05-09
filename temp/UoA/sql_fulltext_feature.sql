--https://technet.microsoft.com/en-us/library/ms142583(v=sql.105).aspx

--creating fulltext catalog
CREATE FULLTEXT CATALOG ftCatalog AS DEFAULT;
--creating fulltext index
CREATE UNIQUE INDEX ui_ukCourse ON tb_course(courseA); 
CREATE FULLTEXT INDEX ON tb_course(title, [description]) KEY INDEX ui_ukCourse ON ftCatalog;

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
