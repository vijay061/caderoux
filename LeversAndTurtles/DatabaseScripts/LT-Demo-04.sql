/*
	Presentation: Get a Lever and Pick Any Turtle
	Ref: https://bitly.com/bundles/caderoux/3
	Slide 29:
	Script: Code generate all the SPs which get different lookups
	By: Cade Roux cade@rosecrescent.com
	This work is licensed under a Creative Commons Attribution-ShareAlike 3.0 Unported License.
	http://creativecommons.org/licenses/by-sa/3.0/
*/

USE LeversAndTurtles
GO

DECLARE @template AS varchar(max) = '
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N''[{SCHEMA_NAME}].[Lookup_{TABLE_NAME}]'') AND type in (N''P'', N''PC''))
	DROP PROCEDURE [{SCHEMA_NAME}].[Lookup_{TABLE_NAME}]
GO

-- Code Generated on {DATETIME} by {USER}
CREATE PROCEDURE [{SCHEMA_NAME}].[Lookup_{TABLE_NAME}]
AS
BEGIN
	SELECT {COLUMN_LIST}
	FROM [{SCHEMA_NAME}].[{TABLE_NAME}]
	ORDER BY {SORT_COLUMN}
END
GO
'

DECLARE @sql AS varchar(max) = 'USE LeversAndTurtles
GO
'

SELECT @sql += REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(@template,
	'{SCHEMA_NAME}', SCHEMA_NAME),
	'{TABLE_NAME}', TABLE_NAME),
	'{SORT_COLUMN}', SORT_COLUMN),
	'{COLUMN_LIST}', COLUMN_LIST),
	'{DATETIME}', GETDATE()),
	'{USER}', SUSER_SNAME())
FROM Demo.LookupDefinitions

SET @sql += 'USE master
GO
'

PRINT @sql

USE master
GO
