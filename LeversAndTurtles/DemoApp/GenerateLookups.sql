IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Demo].[Lookup_CodeGen1]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [Demo].[Lookup_CodeGen1]
GO

-- Code Generated on 09/14/2010 00:37:20 by NB255-Netbook\Cade
CREATE PROCEDURE [Demo].[Lookup_CodeGen1]
AS
BEGIN
	SELECT ID, Value, SortOrder
	FROM [Demo].[CodeGen1]
	ORDER BY SortOrder
END
GO
	IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Demo].[Lookup_CodeGen2]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [Demo].[Lookup_CodeGen2]
GO

-- Code Generated on 09/14/2010 00:37:20 by NB255-Netbook\Cade
CREATE PROCEDURE [Demo].[Lookup_CodeGen2]
AS
BEGIN
	SELECT ID, Value
	FROM [Demo].[CodeGen2]
	ORDER BY ID
END
GO
	IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Demo].[Lookup_CodeGen3]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [Demo].[Lookup_CodeGen3]
GO

-- Code Generated on 09/14/2010 00:37:20 by NB255-Netbook\Cade
CREATE PROCEDURE [Demo].[Lookup_CodeGen3]
AS
BEGIN
	SELECT ID, Value
	FROM [Demo].[CodeGen3]
	ORDER BY Value
END
GO
	IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Demo].[Lookup_CodeGen4]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [Demo].[Lookup_CodeGen4]
GO

-- Code Generated on 09/14/2010 00:37:20 by NB255-Netbook\Cade
CREATE PROCEDURE [Demo].[Lookup_CodeGen4]
AS
BEGIN
	SELECT ID, Value
	FROM [Demo].[CodeGen4]
	ORDER BY 1
END
GO
	