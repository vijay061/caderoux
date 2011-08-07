/*
	Presentation: Get a Lever and Pick Any Turtle
	Ref: https://bitly.com/bundles/caderoux/3
	Slide: 16 - DBMeta.Properties
	Script: Creates a DBMeta.Properties view
	By: Cade Roux cade@rosecrescent.com
	This work is licensed under a Creative Commons Attribution-ShareAlike 3.0 Unported License.
	http://creativecommons.org/licenses/by-sa/3.0/
*/
USE LeversAndTurtles
GO

-- SELECT * FROM sys.extended_properties 

IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[DBMeta].[Properties]'))
	DROP VIEW [DBMeta].[Properties]
GO

CREATE VIEW DBMeta.Properties AS
	SELECT 'SCHEMA' AS ObjectType
			,QUOTENAME(s.name) AS FullObjectName
			,s.name as ObjectSchema
			,NULL AS ObjectName
			,NULL AS SubName
			,xp.name AS PropertyName
			,xp.value AS PropertyValue
	FROM sys.extended_properties AS xp
	INNER JOIN sys.schemas AS s
		ON s.schema_id = xp.major_id
		AND xp.class_desc = 'SCHEMA'

	UNION ALL

	SELECT o.type_desc AS ObjectType
			,QUOTENAME(OBJECT_SCHEMA_NAME(o.object_id)) + '.' + QUOTENAME(o.name) AS FullObjectName
			,OBJECT_SCHEMA_NAME(o.object_id) AS ObjectSchema
			,o.name AS ObjectName
			,NULL AS SubName
			,xp.name AS PropertyName
			,xp.value AS PropertyValue
	FROM sys.extended_properties AS xp
	INNER JOIN sys.objects AS o
		ON o.object_id = xp.major_id
		AND xp.minor_id = 0
		AND xp.class_desc = 'OBJECT_OR_COLUMN'

	UNION ALL

	SELECT 'COLUMN' AS ObjectType
			,QUOTENAME(OBJECT_SCHEMA_NAME(t.object_id)) + '.' + QUOTENAME(t.name) + '.' + QUOTENAME(c.name) AS FullObjectName
			,OBJECT_SCHEMA_NAME(t.object_id) AS ObjectSchema
			,t.name AS ObjectName
			,c.name AS SubName
			,xp.name AS PropertyName
			,xp.value AS PropertyValue
	FROM sys.extended_properties AS xp
	INNER JOIN sys.objects AS t
		ON t.object_id = xp.major_id
		AND xp.minor_id <> 0
		AND xp.class_desc = 'OBJECT_OR_COLUMN'
		AND t.type_desc = 'USER_TABLE'
	INNER JOIN sys.columns AS c
		ON c.object_id = t.object_id
		AND c.column_id = xp.minor_id
GO

EXEC sys.sp_addextendedproperty 
	@name = 'MS_Description'
	,@value = 'View to make sys.extended_properties easier to use'
	,@level0type = 'SCHEMA'
	,@level0name = 'DBMeta'
	,@level1type = 'VIEW'
	,@level1name = 'Properties'
	,@level2type = NULL
	,@level2name = NULL
GO
EXEC sys.sp_addextendedproperty 
	@name = 'SUBSYSTEM'
	,@value = 'META'
	,@level0type = 'SCHEMA'
	,@level0name = 'DBMeta'
	,@level1type = 'VIEW'
	,@level1name = 'Properties'
	,@level2type = NULL
	,@level2name = NULL
GO

SELECT *
FROM DBMeta.Properties
ORDER BY ObjectType, ObjectSchema, ObjectName, PropertyName
GO

USE master
GO