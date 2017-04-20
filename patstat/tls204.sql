USE [patstat2016b]
GO
/****** Object:  Table [dbo].[tls204_appln_prior]    Script Date: 07/07/2015 08:17:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tls204_appln_prior](
	[appln_id] [int] NOT NULL DEFAULT ('0'),
	[prior_appln_id] [int] NOT NULL DEFAULT ('0'),
	[prior_appln_seq_nr] [smallint] NOT NULL DEFAULT ('0'),
PRIMARY KEY CLUSTERED 
(
	[appln_id] ASC,
	[prior_appln_id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]


BULK INSERT [dbo].tls204_appln_prior
		FROM 'C:\PLR\Patstat\tls\processed\tls204.txt'
		WITH
		(
		BATCHSIZE = 20000, 
		DATAFILETYPE = 'char',
		FORMATFILE = 'C:\PLR\ps_load\patstat\fmt\tls204.fmt'
		)
GO

IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tls204_appln_prior]') AND name = N'IX_tls204_prior_appln_id')
DROP INDEX [IX_tls204_prior_appln_id] ON [dbo].[tls204_appln_prior] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_tls204_prior_appln_id] ON [dbo].[tls204_appln_prior] 
(
	[prior_appln_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


