USE [ProxfinitySQL]
GO

/****** Object:  View [dbo].[MatchLeaders]    Script Date: 6/23/2016 5:15:44 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

create view [dbo].[MatchLeaders] as
SELECT distinct cat_subcat as Topic, left_firstname, left_lastname, right_firstname, right_lastname, count([left_badgeid]+[right_badgeid]) as TopicMatches
--left_badgeId, right_badgeId, left_maxRssi, left_tickCount, status, 
FROM [dbo].[EventSteam]
GROUP BY cat_subcat, left_badgeId, right_badgeId, left_maxRssi, left_tickCount, status, left_firstname, left_lastname,right_firstname, right_lastname
HAVING (((left_maxRssi) > '100') AND (([status])='3'))



GO

