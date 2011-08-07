/*
	Presentation: Get a Lever and Pick Any Turtle
	Ref: https://bitly.com/bundles/caderoux/3
	Slide: 12 - Some Database Ground Rules
	Script: Creates a database and three schemas
	By: Cade Roux cade@rosecrescent.com
	This work is licensed under a Creative Commons Attribution-ShareAlike 3.0 Unported License.
	http://creativecommons.org/licenses/by-sa/3.0/
*/
USE master
GO

IF EXISTS ( SELECT  *
            FROM    sys.databases
            WHERE   name = 'LeversAndTurtles' ) 
    BEGIN
        ALTER DATABASE LeversAndTurtles
        SET SINGLE_USER
        WITH ROLLBACK IMMEDIATE

        DROP DATABASE LeversAndTurtles
    END
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

SELECT  'SCHEMA' AS ObjectType
       ,QUOTENAME(s.name) AS FullObjectName
       ,s.name AS ObjectSchema
       ,NULL AS ObjectName
       ,NULL AS SubName
       ,xp.name AS PropertyName
       ,xp.value AS PropertyValue
FROM    LeversAndTurtles.sys.extended_properties AS xp
INNER JOIN LeversAndTurtles.sys.schemas AS s
        ON s.schema_id = xp.major_id
           AND xp.class_desc = 'SCHEMA'
GO