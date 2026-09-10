CREATE DATABASE MANDAT_DB
GO
USE MANDAT_DB
GO

IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'abituriyent_2024')
BEGIN
    CREATE TABLE abituriyent_2024 (
        row_id INT IDENTITY(1,1) PRIMARY KEY,
        ID VARCHAR(50),
        tr_class NVARCHAR(100),
        status NVARCHAR(50),
        ball FLOAT,
        oliy_talim_muassasasi NVARCHAR(255),
        FIO NVARCHAR(100),
        yonalish NVARCHAR(200),
        talim_shakli NVARCHAR(100),
        til NVARCHAR(100)
    );
END

select * from abituriyent_2024