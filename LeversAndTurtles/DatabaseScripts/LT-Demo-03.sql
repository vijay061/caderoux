/*
	SELECT {COLUMN_LIST}
	FROM {SCHEMA_NAME}.{TABLE_NAME}
	ORDER BY {SORT_COLUMN}
*/

USE [LeversAndTurtles]
GO

IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[Demo].[LookupDefinitions]'))
	DROP VIEW [Demo].[LookupDefinitions]
GO

CREATE VIEW Demo.LookupDefinitions
AS
	SELECT CodeGenTable.ObjectSchema AS SCHEMA_NAME
			,CodeGenTable.ObjectName AS TABLE_NAME
			,CAST(COALESCE(CodeGenSort.PropertyValue, '1') AS VARCHAR(MAX)) AS SORT_COLUMN
			,STUFF(COLUMN_LIST.COLUMN_LIST, 1, 2, '') AS COLUMN_LIST
	FROM DBMeta.Properties AS CodeGenTable
	LEFT JOIN DBMeta.Properties AS CodeGenSort
		ON CodeGenSort.FullObjectName = CodeGenTable.FullObjectName
		AND CodeGenSort.PropertyName = 'SORTCOLUMN'
	OUTER APPLY (
		SELECT ', ' + c.COLUMN_NAME
		FROM INFORMATION_SCHEMA.COLUMNS c
		WHERE c.TABLE_SCHEMA = CodeGenTable.ObjectSchema
			AND c.TABLE_NAME = CodeGenTable.ObjectName
		ORDER BY c.ORDINAL_POSITION
		FOR XML PATH('')
	) AS COLUMN_LIST (COLUMN_LIST)
	WHERE CodeGenTable.PropertyName = 'CODEGEN'
		AND CodeGenTable.PropertyValue = 'TRUE'
GO

SELECT * FROM Demo.LookupDefinitions
GO

USE master
GO