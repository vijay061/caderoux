/*
	Presentation: Get a Lever and Pick Any Turtle
	Slide: 19
	Script: Creates Demo tables and indexes
*/
USE LeversAndTurtles
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Demo].[Demo1]') AND type in (N'U'))
	DROP TABLE [Demo].[Demo1]
GO

CREATE TABLE Demo.Demo1 (
	ItemID int IDENTITY NOT NULL 
	,ItemDescription varchar(50) NOT NULL
)
GO

EXEC DBMeta.AddXP 'Demo.Demo1', 'SUBSYSTEM', 'DEMO1'
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Demo].[Demo2]') AND type in (N'U'))
	DROP TABLE [Demo].[Demo2]
GO

CREATE TABLE Demo.Demo2 (
	ItemID int IDENTITY NOT NULL 
	,ItemDescription varchar(50) NOT NULL
	,UniqueBusinessKey int NULL
)
GO

CREATE UNIQUE NONCLUSTERED INDEX IX_Demo2 ON Demo.Demo2
	(
	UniqueBusinessKey
	)
GO

EXEC DBMeta.AddXP 'Demo.Demo2', 'SUBSYSTEM', 'DEMO2'
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Demo].[Demo3]') AND type in (N'U'))
	DROP TABLE [Demo].[Demo3]
GO

CREATE TABLE Demo.Demo3 (
	ItemID int IDENTITY NOT NULL 
	,ItemDescription varchar(50) NOT NULL
	,Gender varchar(1) NOT NULL
)
GO

EXEC DBMeta.AddXP 'Demo.Demo3', 'SUBSYSTEM', 'DEMO'
GO
--EXEC DBMeta.AddXP 'Demo.Demo3.Gender', 'DBHealth.SmallVarcharColumns', 'EXCLUDE'
--GO

USE master
GO