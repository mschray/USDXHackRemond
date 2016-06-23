USE [ProxfinitySQL]
GO

/****** Object:  StoredProcedure [dbo].[GetAttendeeMatchByEmail]    Script Date: 6/23/2016 5:13:21 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetAttendeeMatchByEmail] 
	@email VARCHAR(255)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	WITH TopMatches (right_email, common_topic_count)
	AS
    -- Insert statements for procedure here
	(SELECT distinct right_email, count(right_email) AS common_topic_count
	FROM [dbo].[EventSteam]
	where left_email = @email
	and status = '1'
	and right_email != 'nan'
	group by right_email

	UNION

	SELECT distinct left_email, count(right_email) AS common_topic_count
	FROM [dbo].[EventSteam]
	where right_email = @email
	and status = '1'
	and left_email != 'nan'
	group by left_email)

	SELECT TOP 1 *
	FROM TopMatches
	order by 'common_topic_count' desc
END

GO


