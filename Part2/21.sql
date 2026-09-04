CREATE TABLE [dbo].[Employee](
 [ID] [int] NULL,
 [Name] [nvarchar](50) NULL,
 [Salary] [int] NULL
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Projects](
 [Project_ID] [int] NULL,
 [Employee_ID] [int] NULL
) ON [PRIMARY]
GO
INSERT [dbo].[Employee] ([ID], [Name], [Salary]) VALUES (1, N'A', 100)
GO
INSERT [dbo].[Employee] ([ID], [Name], [Salary]) VALUES (2, N'B', 50)
GO
INSERT [dbo].[Employee] ([ID], [Name], [Salary]) VALUES (3, N'C', 200)
GO
INSERT [dbo].[Employee] ([ID], [Name], [Salary]) VALUES (4, N'D', 150)
GO
INSERT [dbo].[Employee] ([ID], [Name], [Salary]) VALUES (5, N'E', 30)
GO
INSERT [dbo].[Employee] ([ID], [Name], [Salary]) VALUES (6, N'F', 10)
GO
INSERT [dbo].[Employee] ([ID], [Name], [Salary]) VALUES (7, N'G', 90)
GO
INSERT [dbo].[Employee] ([ID], [Name], [Salary]) VALUES (8, N'H', 180)
GO
INSERT [dbo].[Projects] ([Project_ID], [Employee_ID]) VALUES (1, 1)
GO
INSERT [dbo].[Projects] ([Project_ID], [Employee_ID]) VALUES (2, 3)
GO
INSERT [dbo].[Projects] ([Project_ID], [Employee_ID]) VALUES (3, 4)
GO
INSERT [dbo].[Projects] ([Project_ID], [Employee_ID]) VALUES (4, 5)
GO
INSERT [dbo].[Projects] ([Project_ID], [Employee_ID]) VALUES (5, 6)
GO
INSERT [dbo].[Projects] ([Project_ID], [Employee_ID]) VALUES (6, 2)
GO
INSERT [dbo].[Projects] ([Project_ID], [Employee_ID]) VALUES (7, 8)
GO
INSERT [dbo].[Projects] ([Project_ID], [Employee_ID]) VALUES (8, 7)
GO
INSERT [dbo].[Projects] ([Project_ID], [Employee_ID]) VALUES (9, 7)
GO
INSERT [dbo].[Projects] ([Project_ID], [Employee_ID]) VALUES (10, 8)
GO
INSERT [dbo].[Projects] ([Project_ID], [Employee_ID]) VALUES (11, 4)
GO
INSERT [dbo].[Projects] ([Project_ID], [Employee_ID]) VALUES (12, 3)
GO
INSERT [dbo].[Projects] ([Project_ID], [Employee_ID]) VALUES (13, 1)
GO
INSERT [dbo].[Projects] ([Project_ID], [Employee_ID]) VALUES (14, 1)
GO
INSERT [dbo].[Projects] ([Project_ID], [Employee_ID]) VALUES (15, 3)
GO
INSERT [dbo].[Projects] ([Project_ID], [Employee_ID]) VALUES (16, 4)
GO
INSERT [dbo].[Projects] ([Project_ID], [Employee_ID]) VALUES (17, 5)
GO
INSERT [dbo].[Projects] ([Project_ID], [Employee_ID]) VALUES (18, 6)
GO
INSERT [dbo].[Projects] ([Project_ID], [Employee_ID]) VALUES (19, 7)
GO
INSERT [dbo].[Projects] ([Project_ID], [Employee_ID]) VALUES (20, 8)
GO
INSERT [dbo].[Projects] ([Project_ID], [Employee_ID]) VALUES (21, 2)
GO
INSERT [dbo].[Projects] ([Project_ID], [Employee_ID]) VALUES (22, 5)
GO

select * from Projects

SELECT TOP 3
    E.ID,
    E.Name,
    E.Salary,
    COUNT(P.Project_ID) AS ProjectCount
FROM Employee AS E
JOIN Projects AS P
    ON P.Employee_ID = E.ID
GROUP BY E.ID, E.Name, E.Salary
HAVING COUNT(P.Project_ID) >= 3
ORDER BY E.Salary ASC;