USE [ProxfinitySQL]
GO

/****** Object:  View [dbo].[TrendingTopics]    Script Date: 6/23/2016 5:16:04 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

create view [dbo].[TrendingTopics] as
SELECT distinct cat_subcat as Topic, count(cat_subcat) as TopicMatches
--left_badgeId, right_badgeId, left_maxRssi, left_tickCount, status, 
FROM [dbo].[EventSteam]
GROUP BY cat_subcat 




GO

