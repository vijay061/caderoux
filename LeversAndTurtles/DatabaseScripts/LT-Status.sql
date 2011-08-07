/*
	Presentation: Get a Lever and Pick Any Turtle
	Ref: https://bitly.com/bundles/caderoux/3
	Script: Display a list of all the metadata in the database during the presentation as it is changing between scripts
	By: Cade Roux cade@rosecrescent.com
	This work is licensed under a Creative Commons Attribution-ShareAlike 3.0 Unported License.
	http://creativecommons.org/licenses/by-sa/3.0/
*/

USE LeversAndTurtles
GO

SELECT *
FROM DBMeta.Properties
ORDER BY ObjectType, ObjectSchema, ObjectName, PropertyName
GO

USE master
GO