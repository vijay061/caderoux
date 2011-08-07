/*
	Presentation: Get a Lever and Pick Any Turtle
	Slide 28:
	Script: Creates Additional Demo tables for code generation
*/
USE LeversAndTurtles
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Demo].[CodeGen1]') AND type in (N'U'))
	DROP TABLE [Demo].[CodeGen1]
GO

CREATE TABLE [Demo].[CodeGen1] (
	ID int IDENTITY
	,Value varchar(50)
	,SortOrder int NOT NULL
)
GO

EXEC DBMeta.AddXP '[Demo].[CodeGen1]', 'SUBSYSTEM', 'LOOKUP'
GO
EXEC DBMeta.AddXP '[Demo].[CodeGen1]', 'CODEGEN', 'TRUE'
GO
EXEC DBMeta.AddXP '[Demo].[CodeGen1]', 'SORTCOLUMN', 'SortOrder'
GO

INSERT INTO Demo.CodeGen1 (Value, SortOrder)
VALUES ('George', 3), ('Paul', 2), ('John', 1), ('Ringo', 4)
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Demo].[CodeGen2]') AND type in (N'U'))
	DROP TABLE [Demo].[CodeGen2]
GO

CREATE TABLE [Demo].[CodeGen2] (
	ID int IDENTITY
	,Value varchar(50)
)
GO

EXEC DBMeta.AddXP '[Demo].[CodeGen2]', 'SUBSYSTEM', 'LOOKUP'
GO
EXEC DBMeta.AddXP '[Demo].[CodeGen2]', 'CODEGEN', 'TRUE'
GO
EXEC DBMeta.AddXP '[Demo].[CodeGen2]', 'SORTCOLUMN', 'ID'
GO

INSERT INTO Demo.CodeGen2 (Value)
VALUES ('My Bonnie'), ('The Saints')
		, ('Love Me Do'), ('P.S. I Love You')
		, ('Please Please Me'), ('Ask Me Why')
		, ('From Me to You'), ('Thank You Girl')
		, ('She Loves You'), ('I''ll Get You')
GO


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Demo].[CodeGen3]') AND type in (N'U'))
	DROP TABLE [Demo].[CodeGen3]
GO

CREATE TABLE [Demo].[CodeGen3] (
	ID int IDENTITY
	,Value varchar(50)
)
GO

EXEC DBMeta.AddXP '[Demo].[CodeGen3]', 'SUBSYSTEM', 'LOOKUP'
GO
EXEC DBMeta.AddXP '[Demo].[CodeGen3]', 'CODEGEN', 'TRUE'
GO
EXEC DBMeta.AddXP '[Demo].[CodeGen3]', 'SORTCOLUMN', 'Value'
GO

INSERT INTO Demo.CodeGen3 (Value)
VALUES ('Asher, Jane'), ('Boyd, Pattie')
		, ('Lennon, Cynthia'), ('Ono, Yoko')
		, ('Cox, Maureen'), ('Mills, Heather')
		, ('McCartney, Linda'), ('Pang, May')
		, ('Harrison, Olivia'), ('Bach, Barbara')
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Demo].[CodeGen4]') AND type in (N'U'))
	DROP TABLE [Demo].[CodeGen4]
GO

CREATE TABLE [Demo].[CodeGen4] (
	ID int IDENTITY
	,Value varchar(50)
)
GO

EXEC DBMeta.AddXP '[Demo].[CodeGen4]', 'SUBSYSTEM', 'LOOKUP'
GO
EXEC DBMeta.AddXP '[Demo].[CodeGen4]', 'CODEGEN', 'TRUE'
GO

INSERT INTO Demo.CodeGen4 (Value)
VALUES ('George'), ('Paul'), ('John'), ('Ringo')
GO

USE master
GO