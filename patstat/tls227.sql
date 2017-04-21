USE patscape
GO

/****** Object:  Table [dbo].[tls227_pers_publn]    Script Date: 07/07/2015 04:32:25 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tls227_pers_publn](
	[person_id] [int] NOT NULL DEFAULT ('0'),
	[pat_publn_id] [int] NOT NULL DEFAULT ('0'),
	[applt_seq_nr] [smallint] NOT NULL DEFAULT ('0'),
	[invt_seq_nr] [smallint] NOT NULL DEFAULT ('0')
PRIMARY KEY CLUSTERED 
(
	[person_id] ASC,
	[pat_publn_id] ASC,
	[applt_seq_nr] ASC,
	[invt_seq_nr] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

GO

BULK INSERT [dbo].[tls227_pers_publn]
		FROM 'C:\PLR\Patstat\tls\processed\tls227.txt'
		WITH
		(
		BATCHSIZE = 20000, 
		DATAFILETYPE = 'char',
		ERRORFILE = 'C:\PLR\Patstat\tls\bad_tls227.txt',
		FORMATFILE = 'C:\PLR\ps_load\patstat\fmt\tls227.fmt'
		)
GO

IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tls227_pers_publn]') AND name = N'IX_tls227_pers_publn_id')
DROP INDEX [IX_tls227_pers_publn_id] ON [dbo].[tls227_pers_publn] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_tls227_pers_publn_id] ON [dbo].[tls227_pers_publn] 
(
	[pat_publn_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = OFF) ON [PRIMARY]
GO

IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tls227_pers_publn]') AND name = N'IX_tls227_pers_publn_pers_id')
DROP INDEX [IX_tls227_pers_publn_pers_id] ON [dbo].[tls227_pers_publn] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_tls227_pers_publn_pers_id] ON [dbo].[tls227_pers_publn] 
(
	[person_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = OFF) ON [PRIMARY]
GO

