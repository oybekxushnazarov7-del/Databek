create database Store
GO
USE STORE 
GO

IF OBJECT_ID('FK_STORE_EMPLOYEE','F') IS NOT NULL ALTER TABLE STORE DROP CONSTRAINT FK_STORE_EMPLOYEE;
IF OBJECT_ID('FK_EMPLOYEE_STORE','F') IS NOT NULL ALTER TABLE EMPLOYEE DROP CONSTRAINT FK_EMPLOYEE_STORE;
IF OBJECT_ID('FK_STORE_REGION','F') IS NOT NULL ALTER TABLE STORE DROP CONSTRAINT FK_STORE_REGION;

DROP TABLE IF EXISTS dbo.STORE;
DROP TABLE IF EXISTS dbo.EMPLOYEE;
DROP TABLE IF EXISTS dbo.REGION;
IF EXISTS (SELECT * FROM SYS.SEQUENCES WHERE name='emp_code') DROP SEQUENCE emp_code;
GO

IF NOT EXISTS (SELECT * FROM SYS.SEQUENCES WHERE name = 'emp_code' AND schema_id = SCHEMA_ID('dbo'))
BEGIN
	create sequence emp_code
		start with 1
		increment by 1;
END
GO


IF OBJECT_ID ('dbo.REGION', 'U') IS NULL 
BEGIN 
	create table Region (
	REGION_CODE int primary key,
	REGION_DESCRIPT nvarchar(100) not null
	)
END


IF OBJECT_ID ('dbo.EMPLOYEE', 'U') IS NULL 
BEGIN 
	create table EMPLOYEE (
		EMP_CODE int default (next value for emp_code) primary key,
		EMP_TITLE nvarchar(10),
		EMP_LNAME nvarchar(100),
		EMP_FNAME nvarchar(100),
		EMP_INITIAL nvarchar(10),
		EMP_DOB date,
		STORE_CODE int default 3
	)
END

IF OBJECT_ID ('dbo.STORE', 'U') IS NULL 
BEGIN 
	create table STORE (
	STORE_CODE int identity(1,1) primary key,
	STORE_NAME nvarchar(100),
	STORE_YTD_SALES decimal(12,2),
	REGION_CODE int,
	EMP_CODE int,

	constraint CH_STORE_SALES check (STORE_YTD_SALES > 0)
	)
END
GO


IF NOT EXISTS (SELECT * FROM SYS.FOREIGN_KEYS WHERE name = 'FK_STORE_REGION')
BEGIN
    ALTER TABLE STORE
    ADD CONSTRAINT FK_STORE_REGION 
    FOREIGN KEY (REGION_CODE) REFERENCES REGION(REGION_CODE);
END;


IF NOT EXISTS (SELECT * FROM SYS.FOREIGN_KEYS WHERE name = 'FK_STORE_EMPLOYEE')
BEGIN
    ALTER TABLE STORE
    ADD CONSTRAINT FK_STORE_EMPLOYEE 
    FOREIGN KEY (EMP_CODE) REFERENCES EMPLOYEE(EMP_CODE);
END;


IF NOT EXISTS (SELECT * FROM SYS.FOREIGN_KEYS WHERE name = 'FK_EMPLOYEE_STORE')
BEGIN
    ALTER TABLE EMPLOYEE
    ADD CONSTRAINT FK_EMPLOYEE_STORE 
    FOREIGN KEY (STORE_CODE) REFERENCES STORE(STORE_CODE);
END;
GO


ALTER TABLE EMPLOYEE NOCHECK CONSTRAINT FK_EMPLOYEE_STORE;
ALTER TABLE STORE NOCHECK CONSTRAINT FK_STORE_EMPLOYEE;
GO

INSERT INTO REGION (REGION_CODE, REGION_DESCRIPT) VALUES
(1, 'East'),
(2, 'West');


INSERT INTO EMPLOYEE (EMP_CODE, EMP_TITLE, EMP_LNAME, EMP_FNAME, EMP_INITIAL, EMP_DOB, STORE_CODE) VALUES
(1, 'Mr.', 'Williamson', 'John', 'W', '1964-05-21', 3),
(2, 'Ms.', 'Ratula', 'Nancy', NULL, '1969-02-09', 2),
(3, 'Ms.', 'Greenboro', 'Lottie', 'R', '1961-10-02', 4),
(4, 'Mrs.', 'Rumpersfro', 'Jennie', 'S', '1971-06-01', 5),
(5, 'Mr.', 'Smith', 'Robert', 'L', '1959-11-23', 3),
(6, 'Mr.', 'Renselaer', 'Cary', 'A', '1965-12-25', 1),
(7, 'Mr.', 'Ogallo', 'Roberto', 'S', '1962-07-31', 3),
(8, 'Ms.', 'Johnsson', 'Elizabeth', 'I', '1968-09-10', 1),
(9, 'Mr.', 'Eindsmar', 'Jack', 'W', '1955-04-19', 2),
(10, 'Mrs.', 'Jones', 'Rose', 'R', '1966-03-06', 4),
(11, 'Mr.', 'Broderick', 'Tom', NULL, '1972-10-21', 3),
(12, 'Mr.', 'Washington', 'Alan', 'Y', '1974-09-08', 2),
(13, 'Mr.', 'Smith', 'Peter', 'N', '1964-08-25', 3),
(14, 'Ms.', 'Smith', 'Sherry', 'H', '1966-05-25', 4),
(15, 'Mr.', 'Olenko', 'Howard', 'U', '1964-05-24', 5),
(16, 'Mr.', 'Archialo', 'Barry', 'V', '1960-09-03', 5),
(17, 'Ms.', 'Grimaldo', 'Jeanine', 'K', '1970-11-12', 4),
(18, 'Mr.', 'Rosenberg', 'Andrew', 'D', '1971-01-24', 4),
(19, 'Mr.', 'Rosten', 'Peter', 'F', '1968-10-03', 4),
(20, 'Mr.', 'Mckee', 'Robert', 'S', '1970-03-06', 1),
(21, 'Ms.', 'Baumann', 'Jennifer', 'A', '1974-12-11', 3);

ALTER SEQUENCE emp_code RESTART WITH 22;
GO


SET IDENTITY_INSERT STORE ON;

INSERT INTO STORE (STORE_CODE, STORE_NAME, STORE_YTD_SALES, REGION_CODE, EMP_CODE) VALUES
(1, 'Access Junction', 1003455.76, 2, 8),
(2, 'Database Corner', 1421987.39, 2, 12),
(3, 'Tuple Charge', 986783.22, 1, 7),
(4, 'Attribute Alley', 944568.56, 2, 3),
(5, 'Primary Key Point', 2930098.45, 1, 15);

SET IDENTITY_INSERT STORE OFF;
GO

ALTER TABLE EMPLOYEE  WITH CHECK CHECK CONSTRAINT FK_EMPLOYEE_STORE;
ALTER TABLE STORE  WITH  CHECK CHECK CONSTRAINT FK_STORE_EMPLOYEE;
GO

select * from EMPLOYEE
select * from REGION
select * from STORE 