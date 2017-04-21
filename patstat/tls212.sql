USE patscape
GO

/****** Object:  Table [dbo].[tls212_citation]    Script Date: 03/02/2016 08:20:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tls212_citation](
	[pat_publn_id] [int] NOT NULL DEFAULT ('0'),
	[citn_id] [smallint] NOT NULL DEFAULT ('0'),
	[citn_origin] [char](3) NOT NULL DEFAULT (''),
	[cited_pat_publn_id] [int] NOT NULL DEFAULT ('0'),
	[cited_appln_id] [int] NOT NULL DEFAULT ('0'),
	[pat_citn_seq_nr] [smallint] NOT NULL DEFAULT ('0'),
	[cited_npl_publn_id] [int] NOT NULL DEFAULT ('0'),
	[npl_citn_seq_nr] [smallint] NOT NULL DEFAULT ('0'),
	[citn_gener_auth] [char](2) NOT NULL DEFAULT (''),	
PRIMARY KEY CLUSTERED 
(
	[pat_publn_id] ASC,
	[citn_id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]


BULK INSERT [dbo].[tls212_citation]
		FROM 'C:\PLR\Patstat\tls\processed\tls212.txt'
		WITH
		(
		BATCHSIZE = 100000, 
		DATAFILETYPE = 'char',
		FORMATFILE = 'C:\PLR\ps_load\patstat\fmt\tls212.fmt'
		)
GO

IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tls212_citation]') AND name = N'tls212_citation_XLS212C2')
DROP INDEX [tls212_citation_XLS212C2] ON [dbo].[tls212_citation] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [tls212_citation_XLS212C2] ON [dbo].[tls212_citation] 
(
	[cited_pat_publn_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = OFF) ON [PRIMARY]
GO

IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tls212_citation]') AND name = N'tls212_citation_XLS212C3')
DROP INDEX [tls212_citation_XLS212C3] ON [dbo].[tls212_citation] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [tls212_citation_XLS212C3] ON [dbo].[tls212_citation] 
(
	[cited_appln_id] ASC,
	[pat_publn_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = OFF) ON [PRIMARY]
GO

