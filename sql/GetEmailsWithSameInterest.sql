USE [ProxfinitySQL]
GO

/****** Object:  StoredProcedure [dbo].[GetEmailsWithSameInterest]    Script Date: 6/23/2016 5:14:55 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetEmailsWithSameInterest]
    @Topic nvarchar(250),   
    @MyEmail nvarchar(50)   
AS   

    SELECT right_email 
    FROM EventSteam  
    WHERE cat_subcat = @Topic
	AND left_email = @MyEmail
	AND [status] = 1
	
	UNION
	
	SELECT left_email 
    FROM EventSteam  
    WHERE cat_subcat = @Topic
	AND right_email = @MyEmail
	AND [status] = 1;
	  

GO

