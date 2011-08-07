/*
	Presentation: Get a Lever and Pick Any Turtle
	Ref: https://bitly.com/bundles/caderoux/3
	Slide: 22 - Rule #0
	Script: Make a DBHealth.MonitoredSchemas view
	By: Cade Roux cade@rosecrescent.com
	This work is licensed under a Creative Commons Attribution-ShareAlike 3.0 Unported License.
	http://creativecommons.org/licenses/by-sa/3.0/
*/
USE LeversAndTurtles
GO

IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[DBHealth].[MonitoredSchemas]'))
	DROP VIEW [DBHealth].[MonitoredSchemas]
GO

CREATE VIEW DBHealth.MonitoredSchemas AS
	SELECT ObjectSchema AS SchemaName
	FROM DBMeta.Properties
	WHERE ObjectType = 'SCHEMA'
		AND PropertyName = 'HEALTH_MONITOR_SCHEMA'
		AND PropertyValue = 'TRUE'
GO

EXEC DBMeta.AddXP 'DBHealth.MonitoredSchemas', 'MS_Description', 'View of schemas to have health monitored'
GO

-- Leave out the subsystem here so it will be detected as a defect later on
--EXEC DBMeta.AddXP 'DBHealth.MonitoredSchemas', 'SUBSYSTEM', 'HEALTH'
--GO

IF NOT EXISTS (
		SELECT *
		FROM DBMeta.Properties
		WHERE ObjectType = 'SCHEMA'
			AND ObjectSchema = 'Demo'
			AND PropertyName = 'HEALTH_MONITOR_SCHEMA'
		)
	EXEC DBMeta.AddXP 'Demo', 'HEALTH_MONITOR_SCHEMA', 'TRUE'
GO

IF NOT EXISTS (
		SELECT *
		FROM DBMeta.Properties
		WHERE ObjectType = 'SCHEMA'
			AND ObjectSchema = 'DBMeta'
			AND PropertyName = 'HEALTH_MONITOR_SCHEMA'
		)
	EXEC DBMeta.AddXP 'DBMeta', 'HEALTH_MONITOR_SCHEMA', 'TRUE'
GO

IF NOT EXISTS (
		SELECT *
		FROM DBMeta.Properties
		WHERE ObjectType = 'SCHEMA'
			AND ObjectSchema = 'DBHealth'
			AND PropertyName = 'HEALTH_MONITOR_SCHEMA'
		)
	EXEC DBMeta.AddXP 'DBHealth', 'HEALTH_MONITOR_SCHEMA', 'TRUE'
GO

SELECT *
FROM DBHealth.MonitoredSchemas
GO

USE master
GO
