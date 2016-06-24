USE [ProxfinitySQL]
GO

/****** Object:  StoredProcedure [dbo].[GetTopicsInCommon]    Script Date: 6/23/2016 5:15:16 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetTopicsInCommon]
	-- Add the parameters for the stored procedure here
	@email1 VARCHAR(255),
	@email2 VARCHAR(255)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT DISTINCT cat_subcat 
	FROM [dbo].[EventSteam]
	WHERE left_email = @email1
	AND right_email = @email2

	UNION

	SELECT DISTINCT cat_subcat 
	FROM [dbo].[EventSteam]
	WHERE left_email = @email2
	AND right_email = @email1
END

GO

