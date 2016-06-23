USE [ProxfinitySQL]
GO

/****** Object:  View [dbo].[ViewEventStream]    Script Date: 6/23/2016 5:16:53 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- ==========================================
-- Create View template for Windows Azure SQL Database
-- ==========================================

CREATE VIEW [dbo].[ViewEventStream] AS
SELECT distinct([Id])
      ,[booth_visit]
      ,[cat_subcat]
      ,[left_badgeId]
      ,[left_email]
      ,[left_firstname]
      ,[left_flags]
      ,[left_initials]
      ,[left_lastname]
      ,[left_matchShortId]
      ,[left_maxRssi]
      ,[left_missing_results]
      ,[left_playerShortId]
      ,[left_tickCount]
      ,[right_badgeId]
      ,[right_email]
      ,[right_firstname]
      ,[right_flags]
      ,[right_initials]
      ,[right_lastname]
      ,[right_matchShortId]
      ,[right_maxRssi]
      ,[right_missing_results]
      ,[right_playerShortId]
      ,[right_tickCount]
      ,[status]
      ,[eventName]
      ,[EventEnqueuedUtcTime]
      ,[EventProcessedUtcTime]
      ,[IotHub]
      ,[PartitionId]
  FROM [dbo].[EventSteam]

GO

