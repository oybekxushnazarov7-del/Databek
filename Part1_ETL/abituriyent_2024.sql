CREATE DATABASE MANDAT_DB
GO
USE MANDAT_DB
GO

IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'abituriyent_2024')
BEGIN
    CREATE TABLE abituriyent_2024 (
        ID VARCHAR(50) PRIMARY KEY,
        tr_class NVARCHAR(100),
        status NVARCHAR(50),
        ball FLOAT,
        oliy_talim_muassasasi NVARCHAR(255),
        FIO nvarchar(100),
        yonalish nvarchar(200),
        talim_shakli NVARCHAR(100),
        til nvarchar(100),
    );
END

select * from abituriyent_2024