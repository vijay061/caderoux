/*
	Presentation: Get a Lever and Pick Any Turtle
	Ref: https://bitly.com/bundles/caderoux/3
	Slide: 23 - Rule #1
	Script: Implements DBHealth.MissingSubsystem exception report
	By: Cade Roux cade@rosecrescent.com
	This work is licensed under a Creative Commons Attribution-ShareAlike 3.0 Unported License.
	http://creativecommons.org/licenses/by-sa/3.0/
*/

/*
	USE LeversAndTurtles
	GO

	-- Drop the subsystem if it exists for demo purposes - this should be missing
	IF EXISTS (SELECT * FROM DBMeta.Properties WHERE FullObjectName = '[DBHealth].[MonitoredSchemas]' AND PropertyName = 'SUBSYSTEM')
		EXEC DBMeta.DropXP 'DBHealth.MonitoredSchemas', 'SUBSYSTEM'
	GO

	-- Uncomment in run to demo the ad hoc query
	--EXEC DBMeta.AddXP 'DBHealth.MonitoredSchemas', 'SUBSYSTEM', 'HEALTH'
	--GO

	SELECT QUOTENAME(t.TABLE_SCHEMA) + '.' + QUOTENAME(t.TABLE_NAME) AS FullObjectName, 'TABLE/VIEW' AS ObjectType, 'No SUBSYSTEM' AS Problem
	FROM INFORMATION_SCHEMA.TABLES AS t
	INNER JOIN DBHealth.MonitoredSchemas AS ms
		ON ms.SchemaName = t.TABLE_SCHEMA
	LEFT JOIN DBMeta.Properties AS tp
		ON tp.FullObjectName = QUOTENAME(t.TABLE_SCHEMA) + '.' + QUOTENAME(t.TABLE_NAME)
		AND tp.PropertyName = 'SUBSYSTEM'
	WHERE tp.PropertyName IS NULL
	
	UNION ALL
	
	SELECT QUOTENAME(r.ROUTINE_SCHEMA) + '.' + QUOTENAME(r.ROUTINE_NAME) AS FullObjectName, 'ROUTINE' AS ObjectType, 'No SUBSYSTEM' AS Problem
	FROM INFORMATION_SCHEMA.ROUTINES AS r
	INNER JOIN DBHealth.MonitoredSchemas AS ms
		ON ms.SchemaName = r.ROUTINE_SCHEMA
	LEFT JOIN DBMeta.Properties AS rp
		ON rp.FullObjectName = QUOTENAME(r.ROUTINE_SCHEMA) + '.' + QUOTENAME(r.ROUTINE_NAME)
		AND rp.PropertyName = 'SUBSYSTEM'
	WHERE rp.PropertyName IS NULL
*/

USE LeversAndTurtles
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[DBHealth].[MissingSubsystem]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [DBHealth].[MissingSubsystem]
GO

CREATE PROCEDURE DBHealth.MissingSubsystem
AS
BEGIN
	SELECT OBJECT_SCHEMA_NAME(@@PROCID) + '.' + OBJECT_NAME(@@PROCID) AS [Procedure], QUOTENAME(t.TABLE_SCHEMA) + '.' + QUOTENAME(t.TABLE_NAME) AS FullObjectName, 'TABLE/VIEW' AS ObjectType, 'No SUBSYSTEM' AS Problem
	FROM INFORMATION_SCHEMA.TABLES AS t
	INNER JOIN DBHealth.MonitoredSchemas AS ms
		ON ms.SchemaName = t.TABLE_SCHEMA
	LEFT JOIN DBMeta.Properties AS tp
		ON tp.FullObjectName = QUOTENAME(t.TABLE_SCHEMA) + '.' + QUOTENAME(t.TABLE_NAME)
		AND tp.PropertyName = 'SUBSYSTEM'
	WHERE tp.PropertyName IS NULL
	
	UNION ALL
	
	SELECT OBJECT_SCHEMA_NAME(@@PROCID) + '.' + OBJECT_NAME(@@PROCID) AS [Procedure], QUOTENAME(r.ROUTINE_SCHEMA) + '.' + QUOTENAME(r.ROUTINE_NAME) AS FullObjectName, 'ROUTINE' AS ObjectType, 'No SUBSYSTEM' AS Problem
	FROM INFORMATION_SCHEMA.ROUTINES AS r
	INNER JOIN DBHealth.MonitoredSchemas AS ms
		ON ms.SchemaName = r.ROUTINE_SCHEMA
	LEFT JOIN DBMeta.Properties AS rp
		ON rp.FullObjectName = QUOTENAME(r.ROUTINE_SCHEMA) + '.' + QUOTENAME(r.ROUTINE_NAME)
		AND rp.PropertyName = 'SUBSYSTEM'
	WHERE rp.PropertyName IS NULL
END
GO

EXEC DBMeta.AddXP 'DBHealth.MissingSubsystem', 'MS_Description', 'Show all tables and routines missing a SUBSYSTEM identification'
GO
EXEC DBMeta.AddXP 'DBHealth.MissingSubsystem', 'SUBSYSTEM', 'HEALTH'
GO
EXEC DBMeta.AddXP 'DBHealth.MissingSubsystem', 'HEALTH_CHECK_PROC', 'TRUE'
GO
EXEC DBMeta.AddXP 'DBHealth.MissingSubsystem', 'HEALTH_CHECK_SET', 'ORGANIZATIONAL'
GO

-- Drop the subsystem if it exists for demo purposes - this should be missing
IF EXISTS (SELECT * FROM DBMeta.Properties WHERE FullObjectName = '[DBHealth].[MonitoredSchemas]' AND PropertyName = 'SUBSYSTEM')
	EXEC DBMeta.DropXP 'DBHealth.MonitoredSchemas', 'SUBSYSTEM'
GO

EXEC DBHealth.MissingSubsystem
GO

---- Add in the missing subsystem
--EXEC DBMeta.AddXP 'DBHealth.MonitoredSchemas', 'SUBSYSTEM', 'HEALTH'
--GO

--EXEC DBHealth.MissingSubsystem
--GO

USE master
GO
