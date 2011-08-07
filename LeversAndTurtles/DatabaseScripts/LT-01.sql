/*
	Presentation: Get a Lever and Pick Any Turtle
	Slide: 11 - Some Database Ground Rules
	Script: Creates a database and three schemas
*/
USE master
GO

IF EXISTS (
		SELECT *
		FROM sys.databases
		WHERE name = 'LeversAndTurtles'
	)
	ALTER DATABASE LeversAndTurtles
	SET SINGLE_USER
	WITH ROLLBACK IMMEDIATE

	DROP DATABASE LeversAndTurtles
GO

CREATE DATABASE LeversAndTurtles
GO

USE LeversAndTurtles
GO

CREATE SCHEMA DBMeta
GO
EXEC sys.sp_addextendedproperty
	@name = 'MS_Description'
	,@value = 'Schema for metadata utilities for Presentation: Get a Lever and Pick Any Turtle'
	,@level0type = 'SCHEMA'
	,@level0name = 'DBMeta'
	,@level1type = NULL
	,@level1name = NULL
	,@level2type = NULL
	,@level2name = NULL
GO

CREATE SCHEMA DBHealth
GO
EXEC sys.sp_addextendedproperty
	@name = 'MS_Description'
	,@value = 'Schema for database health utilities for Presentation: Get a Lever and Pick Any Turtle'
	,@level0type = 'SCHEMA'
	,@level0name = 'DBHealth'
	,@level1type = NULL
	,@level1name = NULL
	,@level2type = NULL
	,@level2name = NULL
GO

CREATE SCHEMA Demo
GO
EXEC sys.sp_addextendedproperty
	@name = 'MS_Description'
	,@value = 'Schema for user data for Presentation: Get a Lever and Pick Any Turtle'
	,@level0type = 'SCHEMA'
	,@level0name = 'Demo'
	,@level1type = NULL
	,@level1name = NULL
	,@level2type = NULL
	,@level2name = NULL
GO

USE master
GO
