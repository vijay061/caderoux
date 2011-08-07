/*
	Presentation: Get a Lever and Pick Any Turtle
	Ref: https://bitly.com/bundles/caderoux/3
	Slide 27: Now we have a bunch of rules
	Script: Implements DBHealth.RunChecks to run all checks in a particular set
	By: Cade Roux cade@rosecrescent.com
	This work is licensed under a Creative Commons Attribution-ShareAlike 3.0 Unported License.
	http://creativecommons.org/licenses/by-sa/3.0/
*/
USE LeversAndTurtles
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[DBHealth].[RunChecks]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [DBHealth].[RunChecks]
GO

CREATE PROCEDURE DBHealth.RunChecks
	@SetPattern AS varchar(max) = '%'
AS
BEGIN
	DECLARE @sql AS varchar(max) = ''
	SELECT @sql += 'EXEC ' + p.FullObjectName + CHAR(13) + CHAR(10)
	FROM DBMeta.Properties AS p
	INNER JOIN DBHealth.MonitoredSchemas AS ms
		ON ms.SchemaName = p.ObjectSchema
		AND p.PropertyName = 'HEALTH_CHECK_PROC'
		AND p.PropertyValue = 'TRUE'
	INNER JOIN DBMeta.Properties AS s
		ON p.FullObjectName = s.FullObjectName
		AND s.PropertyName = 'HEALTH_CHECK_SET'
		AND CAST(s.PropertyValue AS varchar(max)) LIKE @SetPattern
	ORDER BY p.ObjectSchema, p.ObjectName
	
	EXEC (@sql)
END
GO

EXEC DBMeta.AddXP 'DBHealth.RunChecks', 'MS_Description', 'Procedure to run a set of health check procedures'
GO
EXEC DBMeta.AddXP 'DBHealth.RunChecks', 'SUBSYSTEM', 'HEALTH'
GO

IF EXISTS (SELECT * FROM DBMeta.Properties WHERE FullObjectName = '[DBHealth].[MonitoredSchemas]' AND PropertyName = 'SUBSYSTEM')
	EXEC DBMeta.DropXP 'DBHealth.MonitoredSchemas', 'SUBSYSTEM'
GO
IF EXISTS (SELECT * FROM DBMeta.Properties WHERE FullObjectName = '[Demo].[Demo3].[Gender]' AND PropertyName = 'DBHealth.SmallVarcharColumns')
	EXEC DBMeta.DropXP 'Demo.Demo3.Gender', 'DBHealth.SmallVarcharColumns'
GO

EXEC DBHealth.RunChecks
GO

EXEC DBMeta.AddXP 'DBHealth.MonitoredSchemas', 'SUBSYSTEM', 'HEALTH'
GO
EXEC DBMeta.AddXP 'Demo.Demo3.Gender', 'DBHealth.SmallVarcharColumns', 'EXCLUDE'
GO

EXEC DBHealth.RunChecks
GO

USE master
GO
