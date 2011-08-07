/*
	Presentation: Get a Lever and Pick Any Turtle
	Slide: 16 - DBMeta.AddXP, UpdateXP, DropXP
	Script: Create three helper SPs to deal with XPs
*/
USE LeversAndTurtles
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[DBMeta].[ObjectInfo]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
	DROP FUNCTION [DBMeta].[ObjectInfo]
GO

CREATE FUNCTION DBMeta.ObjectInfo(@obj varchar(max))
RETURNS TABLE AS RETURN (
	SELECT ObjectSchema = OBJECT_SCHEMA_NAME(o.object_id)
			,ObjectName = OBJECT_NAME(o.object_id)
			,FullObjectName = QUOTENAME(OBJECT_SCHEMA_NAME(o.object_id)) + '.' + QUOTENAME(o.name)
			,ObjectType = o.type_desc
			,IsSchema = CAST(0 AS bit)
			,level0type = 'SCHEMA'
			,level0name = OBJECT_SCHEMA_NAME(o.object_id)
			,level1type = CASE WHEN o.type_desc = 'VIEW' THEN 'VIEW'
								WHEN o.type_desc = 'USER_TABLE' THEN 'TABLE'
								WHEN o.type_desc = 'SQL_STORED_PROCEDURE' THEN 'PROCEDURE'
								WHEN o.type_desc = 'SQL_INLINE_TABLE_VALUED_FUNCTION' THEN 'FUNCTION'
								ELSE o.type_desc
							END
			,level1name = OBJECT_NAME(o.object_id)
			,level2type = NULL
			,level2name = NULL
	FROM sys.objects AS o
	WHERE o.object_id = OBJECT_ID(@obj)

	UNION ALL

	SELECT ObjectSchema = SCHEMA_NAME(SCHEMA_ID(@obj))
		,ObjectName = NULL
		,FullObjectName = QUOTENAME(SCHEMA_NAME(SCHEMA_ID(@obj)))
		,ObjectType = 'SCHEMA'
		,IsSchema = CAST(1 AS bit)
		,level0type = 'SCHEMA'
		,level0name = SCHEMA_NAME(SCHEMA_ID(@obj))
		,level1type = NULL
		,level1name = NULL
		,level2type = NULL
		,level2name = NULL
	WHERE SCHEMA_ID(@obj) IS NOT NULL

	UNION ALL
	
	SELECT ObjectSchema = OBJECT_SCHEMA_NAME(o.object_id)
			,ObjectName = OBJECT_NAME(o.object_id)
			,FullObjectName = QUOTENAME(OBJECT_SCHEMA_NAME(o.object_id)) + '.' + QUOTENAME(o.name)
			,ObjectType = 'COLUMN'
			,IsSchema = CAST(0 AS bit)
			,level0type = 'SCHEMA'
			,level0name = OBJECT_SCHEMA_NAME(o.object_id)
			,level1type = 'TABLE'
			,level1name = OBJECT_NAME(o.object_id)
			,level2type = 'COLUMN'
			,level2name = PARSENAME(@obj, 1)
	FROM sys.objects AS o
	WHERE PARSENAME(@obj, 1) IS NOT NULL
		AND PARSENAME(@obj, 2) IS NOT NULL
		AND PARSENAME(@obj, 3) IS NOT NULL
		AND PARSENAME(@obj, 4) IS NULL
		AND o.object_id = OBJECT_ID(QUOTENAME(PARSENAME(@obj, 3)) + '.' + QUOTENAME(PARSENAME(@obj, 2)))
)
GO

EXEC sys.sp_addextendedproperty 
	@name = 'MS_Description'
	,@value = 'Return XP-friendly object types'
	,@level0type = 'SCHEMA'
	,@level0name = 'DBMeta'
	,@level1type = 'FUNCTION'
	,@level1name = 'ObjectInfo'
	,@level2type = NULL
	,@level2name = NULL
GO
EXEC sys.sp_addextendedproperty 
	@name = 'SUBSYSTEM'
	,@value = 'META'
	,@level0type = 'SCHEMA'
	,@level0name = 'DBMeta'
	,@level1type = 'FUNCTION'
	,@level1name = 'ObjectInfo'
	,@level2type = NULL
	,@level2name = NULL
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[DBMeta].[AddXP]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [DBMeta].[AddXP]
GO

CREATE PROCEDURE DBMeta.AddXP
	@obj AS varchar(max)
	,@name AS sysname
	,@value AS varchar(7500)
AS
BEGIN
	DECLARE @level0type AS varchar(128)
	DECLARE @level0name AS sysname
	DECLARE @level1type AS varchar(128)
	DECLARE @level1name AS sysname
	DECLARE @level2type AS varchar(128)
	DECLARE @level2name AS sysname
	
	SELECT @level0type = level0type
		,@level0name = level0name
		,@level1type = level1type
		,@level1name = level1name
		,@level2type = level2type
		,@level2name = level2name
	FROM DBMeta.ObjectInfo(@obj)

	EXEC sys.sp_addextendedproperty 
		@name = @name
		,@value = @value
		,@level0type = @level0type
		,@level0name = @level0name
		,@level1type = @level1type
		,@level1name = @level1name
		,@level2type = @level2type
		,@level2name = @level2name
END
GO

--EXEC sys.sp_addextendedproperty 
--	@name = 'MS_Description'
--	,@value = 'Procedure to make sys.extended_properties easier to use'
--	,@level0type = 'SCHEMA'
--	,@level0name = 'DBMeta'
--	,@level1type = 'PROCEDURE'
--	,@level1name = 'AddXP'
--	,@level2type = NULL
--	,@level2name = NULL

EXEC DBMeta.AddXP 'DBMeta.AddXP', 'MS_Description', 'Procedure to make sys.extended_properties easier to use'
GO
EXEC DBMeta.AddXP 'DBMeta.AddXP', 'SUBSYSTEM', 'META'
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[DBMeta].[UpdateXP]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [DBMeta].[UpdateXP]
GO

CREATE PROCEDURE DBMeta.UpdateXP
	@obj AS varchar(max)
	,@name AS sysname
	,@value AS varchar(7500)
AS
BEGIN
	DECLARE @level0type AS varchar(128)
	DECLARE @level0name AS sysname
	DECLARE @level1type AS varchar(128)
	DECLARE @level1name AS sysname
	DECLARE @level2type AS varchar(128)
	DECLARE @level2name AS sysname
	
	SELECT @level0type = level0type
		,@level0name = level0name
		,@level1type = level1type
		,@level1name = level1name
		,@level2type = level2type
		,@level2name = level2name
	FROM DBMeta.ObjectInfo(@obj)

	EXEC sys.sp_updateextendedproperty 
		@name = @name
		,@value = @value
		,@level0type = @level0type
		,@level0name = @level0name
		,@level1type = @level1type
		,@level1name = @level1name
		,@level2type = @level2type
		,@level2name = @level2name
END
GO

EXEC DBMeta.AddXP 'DBMeta.UpdateXP', 'MS_Description', 'Procedure to make sys.extended_properties easier to use'
GO
EXEC DBMeta.UpdateXP 'DBMeta.UpdateXP', 'MS_Description', 'Procedure to make sys.extended_properties easier to update'
GO
EXEC DBMeta.AddXP 'DBMeta.UpdateXP', 'SUBSYSTEM', 'META'
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[DBMeta].[DropXP]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [DBMeta].[DropXP]
GO

CREATE PROCEDURE DBMeta.DropXP
	@obj AS varchar(max)
	,@name AS sysname
AS
BEGIN
	DECLARE @level0type AS varchar(128)
	DECLARE @level0name AS sysname
	DECLARE @level1type AS varchar(128)
	DECLARE @level1name AS sysname
	DECLARE @level2type AS varchar(128)
	DECLARE @level2name AS sysname
	
	SELECT @level0type = level0type
		,@level0name = level0name
		,@level1type = level1type
		,@level1name = level1name
		,@level2type = level2type
		,@level2name = level2name
	FROM DBMeta.ObjectInfo(@obj)

	EXEC sys.sp_dropextendedproperty 
		@name = @name
		,@level0type = @level0type
		,@level0name = @level0name
		,@level1type = @level1type
		,@level1name = @level1name
		,@level2type = @level2type
		,@level2name = @level2name
END
GO

EXEC DBMeta.AddXP 'DBMeta.DropXP', 'MS_Description', 'Procedure to make sys.extended_properties easier to use'
GO
EXEC DBMeta.DropXP 'DBMeta.DropXP', 'MS_Description'
GO
EXEC DBMeta.AddXP 'DBMeta.DropXP', 'MS_Description', 'Procedure to make sys.extended_properties easier to drop'
GO
EXEC DBMeta.AddXP 'DBMeta.DropXP', 'SUBSYSTEM', 'META'
GO

USE master
GO
