USE patscape
GO

/****** Object:  Table [dbo].[tls211_pat_publn]    Script Date: 03/02/2016 01:03:14 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tls211_pat_publn](
	[pat_publn_id] [int] NOT NULL DEFAULT ('0'),
	[publn_auth] [char](2) NOT NULL DEFAULT (''),
	[publn_nr] [varchar](15) NOT NULL DEFAULT (''),
	[publn_nr_original] [varchar](100) NOT NULL DEFAULT (''),
	[publn_kind] [char](2) NOT NULL DEFAULT (''),
	[appln_id] [int] NOT NULL DEFAULT ('0'),
	[publn_date] [date] NOT NULL DEFAULT ('9999-12-31'),
	[publn_lg] [char](2) NOT NULL DEFAULT (''),
	[publn_first_grant] [tinyint] NOT NULL DEFAULT ('0'),
	[publn_claims] [smallint] NOT NULL DEFAULT ('0'),
PRIMARY KEY CLUSTERED 
(
	[pat_publn_id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

BULK INSERT [dbo].[tls211_pat_publn]
		FROM 'C:\PLR\Patstat\tls\processed\tls211.txt'
		WITH
		(
		BATCHSIZE = 20000, 
		DATAFILETYPE = 'char',
		FORMATFILE = 'C:\PLR\ps_load\patstat\fmt\tls211.fmt'
		)
GO

IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tls211_pat_publn]') AND name = N'tls211_pat_publn_XLS211M2')
DROP INDEX [tls211_pat_publn_XLS211M2] ON [dbo].[tls211_pat_publn] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [tls211_pat_publn_XLS211M2] ON [dbo].[tls211_pat_publn] 
(
	[publn_auth] ASC,
	[publn_nr] ASC,
	[publn_kind] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = OFF) ON [PRIMARY]
GO

IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tls211_pat_publn]') AND name = N'tls211_pat_publn_XLS211M3')
DROP INDEX [tls211_pat_publn_XLS211M3] ON [dbo].[tls211_pat_publn] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [tls211_pat_publn_XLS211M3] ON [dbo].[tls211_pat_publn] 
(
	[appln_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = OFF) ON [PRIMARY]
GO

IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tls211_pat_publn]') AND name = N'tls211_pat_publn_XLS211M4')
DROP INDEX [tls211_pat_publn_XLS211M4] ON [dbo].[tls211_pat_publn] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [tls211_pat_publn_XLS211M4] ON [dbo].[tls211_pat_publn] 
(
	[publn_date] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = OFF) ON [PRIMARY]
GO

