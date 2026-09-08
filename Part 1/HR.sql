create database HR
GO
USE HR
GO

IF OBJECT_ID('dbo.EMPLOYEE', 'U') IS NULL 
BEGIN
	create table EMPLOYEE (
		Employee_ID int primary key,
		Employee_FName nvarchar(50),
		Employee_LName nvarchar(50),
		Employee_HireDate  date,
		Employee_Title nvarchar(100) default 'Unknown'
	)
END

IF OBJECT_ID('dbo.SKILL', 'U') IS NULL 
BEGIN
	create table SKILL (
		Skill_ID int identity(100,10) primary key,
		Skill_Name nvarchar(100),
		Skill_Description nvarchar(max)
	)
END

IF OBJECT_ID('dbo.CERTIFIED', 'U') IS NULL 
BEGIN
	create table CERTIFIED (
		Employee_ID int,
		Skill_ID int,
		Certified_Data date,

		constraint FK_EMP_CER
		foreign key (Employee_ID) references EMPLOYEE(Employee_ID),

		constraint FK_SKILL_CER 
		foreign key (Skill_ID) references SKILL(Skill_ID),

		constraint CH_EMP_Skill_ID check (Skill_ID between 100 and 220) 
	)
END