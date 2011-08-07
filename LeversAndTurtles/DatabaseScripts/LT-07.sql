/*
	Presentation: Get a Lever and Pick Any Turtle
	Ref: https://bitly.com/bundles/caderoux/3
	Slide: 25 - Rule #3
	Script: Implements DBHealth.SmallVarcharColumns exception report
	By: Cade Roux cade@rosecrescent.com
	This work is licensed under a Creative Commons Attribution-ShareAlike 3.0 Unported License.
	http://creativecommons.org/licenses/by-sa/3.0/
*/
USE LeversAndTurtles
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[DBHealth].[SmallVarcharColumns]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [DBHealth].[SmallVarcharColumns]
GO

CREATE PROCEDURE DBHealth.SmallVarcharColumns
AS
BEGIN
	SELECT OBJECT_SCHEMA_NAME(@@PROCID) + '.' + OBJECT_NAME(@@PROCID) AS [Procedure], QUOTENAME(c.TABLE_SCHEMA) + '.' + QUOTENAME(c.TABLE_NAME) AS TableName, QUOTENAME(c.COLUMN_NAME) AS ColumnName, 'Small varchar column: ' + c.DATA_TYPE + '(' + CAST(c.CHARACTER_MAXIMUM_LENGTH as varchar(50)) + ')' AS Problem
	FROM INFORMATION_SCHEMA.COLUMNS AS c
	INNER JOIN DBHealth.MonitoredSchemas AS ms
		ON ms.SchemaName = c.TABLE_SCHEMA
	WHERE c.DATA_TYPE IN ('varchar', 'nvarchar')
		AND c.CHARACTER_MAXIMUM_LENGTH IN (1, 2)
END
GO

EXEC DBMeta.AddXP 'DBHealth.SmallVarcharColumns', 'MS_Description', 'Health check for small varchar columns which should be char'
GO
EXEC DBMeta.AddXP 'DBHealth.SmallVarcharColumns', 'HEALTH_CHECK_PROC', 'TRUE'
GO
EXEC DBMeta.AddXP 'DBHealth.SmallVarcharColumns', 'HEALTH_CHECK_SET', 'TABLE DESIGN'
GO
EXEC DBMeta.AddXP 'DBHealth.SmallVarcharColumns', 'SUBSYSTEM', 'HEALTH'
GO

EXEC DBHealth.SmallVarcharColumns
GO

USE master
GO
