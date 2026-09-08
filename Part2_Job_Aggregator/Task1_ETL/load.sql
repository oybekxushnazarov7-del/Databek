CREATE DATABASE Part2
GO
USE Part2
GO

IF OBJECT_ID('dbo.fact_job_skills', 'U') IS NOT NULL DROP TABLE dbo.fact_job_skills;
IF OBJECT_ID('dbo.fact_jobs', 'U') IS NOT NULL DROP TABLE dbo.fact_jobs;
IF OBJECT_ID('dbo.dim_channels', 'U') IS NOT NULL DROP TABLE dbo.dim_channels;
IF OBJECT_ID('dbo.dim_skills', 'U') IS NOT NULL DROP TABLE dbo.dim_skills;
IF OBJECT_ID('dbo.dim_occupations', 'U') IS NOT NULL DROP TABLE dbo.dim_occupations;
IF OBJECT_ID('dbo.dim_locations', 'U') IS NOT NULL DROP TABLE dbo.dim_locations;

CREATE TABLE dbo.dim_channels (
    id INT PRIMARY KEY,
    chat_id VARCHAR(100),
    group_id VARCHAR(100),
    username VARCHAR(100),
    title NVARCHAR(MAX),
    description NVARCHAR(MAX),
    member_count INT,
    is_active INT,
    created_at DATE,
    updated_at DATE
);

CREATE TABLE dbo.dim_locations (
    location_id INT PRIMARY KEY,
    country_code VARCHAR(20),
    country NVARCHAR(MAX),
    city NVARCHAR(MAX)
);

CREATE TABLE dbo.dim_occupations (
    occupation_id INT PRIMARY KEY,
    occupation_name NVARCHAR(MAX)
);

CREATE TABLE dbo.dim_skills (
    skill_id INT PRIMARY KEY,
    skill_name NVARCHAR(MAX)
);

CREATE TABLE dbo.fact_jobs (
    job_id INT PRIMARY KEY,
    job_name NVARCHAR(MAX),
    company_name NVARCHAR(MAX),
    job_type NVARCHAR(255),
    job_salary FLOAT,
    salary_min FLOAT,
    salary_max FLOAT,
    salary_currency VARCHAR(20),
    salary_is_negotiable BIT,
    created_at DATE,
    location_id INT FOREIGN KEY REFERENCES dbo.dim_locations(location_id),
    occupation_id INT FOREIGN KEY REFERENCES dbo.dim_occupations(occupation_id)
);

CREATE TABLE dbo.fact_job_skills (
    job_id INT FOREIGN KEY REFERENCES dbo.fact_jobs(job_id),
    skill_id INT FOREIGN KEY REFERENCES dbo.dim_skills(skill_id),
    CONSTRAINT PK_fact_job_skills PRIMARY KEY (job_id, skill_id)
);