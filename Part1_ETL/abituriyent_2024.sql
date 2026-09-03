IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'abituriyent_2024')
    BEGIN
        CREATE TABLE abituriyent_2024 (
            id INT IDENTITY(1,1) PRIMARY KEY,
            tr_class NVARCHAR(255),
            status NVARCHAR(50),
            ball FLOAT
        )
    END

select * from abituriyent_2024