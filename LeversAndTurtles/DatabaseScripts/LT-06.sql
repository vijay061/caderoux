/*
	Presentation: Get a Lever and Pick Any Turtle
	Slide: 23 - Rule #2
	Script: 
*/
USE LeversAndTurtles
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[DBHealth].[UniqueIndexOnNullableColumn]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [DBHealth].[UniqueIndexOnNullableColumn]
GO

CREATE PROCEDURE DBHealth.UniqueIndexOnNullableColumn
AS
BEGIN
	SELECT OBJECT_SCHEMA_NAME(@@PROCID) + '.' + OBJECT_NAME(@@PROCID) AS [Procedure], QUOTENAME(OBJECT_SCHEMA_NAME(ic.object_id)) + '.' +
		QUOTENAME(OBJECT_NAME(ic.object_id)) AS TableName
		,QUOTENAME(i.name) AS IndexName
		,QUOTENAME(c.name) AS ColumnName
		,'Unique Index on Nullable Column' AS Problem
	FROM sys.index_columns AS ic
	INNER JOIN DBHealth.MonitoredSchemas AS ms
		ON ms.SchemaName = OBJECT_SCHEMA_NAME(ic.object_id)
	INNER JOIN sys.indexes AS i
		ON i.object_id = ic.object_id
		AND i.index_id = ic.index_id
	INNER JOIN sys.columns AS c
		ON c.object_id = ic.object_id
		AND c.column_id = ic.column_id
	WHERE i.is_unique = 1
		AND c.is_nullable = 1
	ORDER BY QUOTENAME(OBJECT_SCHEMA_NAME(ic.object_id)) + '.' +
			QUOTENAME(OBJECT_NAME(ic.object_id))
			,QUOTENAME(i.name)
			,QUOTENAME(c.name)
END
GO

EXEC DBMeta.AddXP 'DBHealth.UniqueIndexOnNullableColumn', 'MS_Description', 'Show all nullable columns in unique indexes'
GO
EXEC DBMeta.AddXP 'DBHealth.UniqueIndexOnNullableColumn', 'HEALTH_CHECK_PROC', 'TRUE'
GO
EXEC DBMeta.AddXP 'DBHealth.UniqueIndexOnNullableColumn', 'HEALTH_CHECK_SET', 'INDEXING'
GO
EXEC DBMeta.AddXP 'DBHealth.UniqueIndexOnNullableColumn', 'SUBSYSTEM', 'HEALTH'
GO

EXEC DBHealth.UniqueIndexOnNullableColumn
GO

USE master
GO
