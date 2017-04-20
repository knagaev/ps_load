USE patscape
GO
/****** Object:  Table [dbo].[tls207_pers_appln]    Script Date: 07/07/2015 08:18:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tls207_pers_appln](
	[person_id] [int] NOT NULL DEFAULT ('0'),
	[appln_id] [int] NOT NULL DEFAULT ('0'),
	[applt_seq_nr] [smallint] NOT NULL DEFAULT ('0'),
	[invt_seq_nr] [smallint] NOT NULL DEFAULT ('0')
PRIMARY KEY CLUSTERED 
(
	[person_id] ASC,
	[appln_id] ASC,
	[applt_seq_nr] ASC,
	[invt_seq_nr] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

BULK INSERT [dbo].[tls207_pers_appln]
		FROM 'C:\PLR\Patstat\tls\processed\tls207.txt'
		WITH
		(
		BATCHSIZE = 20000, 
		DATAFILETYPE = 'char',
		FORMATFILE = 'C:\PLR\ps_load\patstat\fmt\tls207.fmt'
		)
GO

IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tls207_pers_appln]') AND name = N'IX_tls207_pers_appln_id')
DROP INDEX [IX_tls207_pers_appln_id] ON [dbo].[tls207_pers_appln] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_tls207_pers_appln_id] ON [dbo].[tls207_pers_appln] 
(
	[appln_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = OFF) ON [PRIMARY]
GO

IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tls207_pers_appln]') AND name = N'IX_tls207_pers_appln_pers_id')
DROP INDEX [IX_tls207_pers_appln_pers_id] ON [dbo].[tls207_pers_appln] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_tls207_pers_appln_pers_id] ON [dbo].[tls207_pers_appln] 
(
	[person_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = OFF) ON [PRIMARY]
GO

