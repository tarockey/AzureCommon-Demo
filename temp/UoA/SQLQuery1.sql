
--drop table tb_temp_course

create table tb_temp_course
(
	courseA varchar(50),
	points varchar(50),
	title varchar(1000),
	[description] varchar(1000),
	prerequisite varchar(1000),
	Restriction varchar(1000)
)
go

select * from  tb_temp_course a  where prerequisite > ''

select  prerequisite from tb_temp_course a where courseA = 'COMPSYS 726' and a.
--truncate table tb_temp_course
 
 

 Prerequisite: At least one of PHYSICS 220-261 
 Prerequisite: 15 points from PHYSICS 120, 160 and 15 points from MATHS 108, 110, 150 
 Prerequisite: B– average in one of ENGSCI 211, MATHS 253, PHYSICS 211 and either PHYSICS 201 or 231 
 Prerequisite: B– in PHYSICS 202 or 261, and 15 points from ENGSCI 211, MATHS 253, PHYSICS 211 
 Prerequisite: PHYSICS 701, or MATHS 340 and 361 
 Restriction: CHEMMAT 774, 775, 776 
 To complete this course students must enrol in CHEMMAT 788 A and B 
 Prerequisite: 45 points at Stage II Psychology and 15 points from STATS 101-125, 191 
 Prerequisite: ENGGEN 140 or CHEM 110 or 120 
