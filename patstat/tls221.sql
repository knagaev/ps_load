USE patscape
GO

/****** Object:  Table [dbo].[tls221_inpadoc_prs]    Script Date: 07/07/2015 08:13:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tls221_inpadoc_prs](
	[appln_id] [int] NOT NULL DEFAULT ('0'),
	[prs_event_seq_nr] [smallint] NOT NULL DEFAULT ('0'),
	[prs_gazette_date] [date] NOT NULL DEFAULT ('9999-12-31'),
	[prs_code] [char](4) NOT NULL DEFAULT (''),
	[l501ep] [varchar](2) NOT NULL DEFAULT (''),
	[l502ep] [varchar](4) NOT NULL DEFAULT (''),
	[lec_id] [smallint] NOT NULL DEFAULT ('0'),
	[l503ep] [varchar](20) NOT NULL DEFAULT (''),
	[l504ep] [varchar](2) NOT NULL DEFAULT (''),
	[l505ep] [date] NOT NULL DEFAULT ('9999-12-31'),
	[l506ep] [varchar](2) NOT NULL DEFAULT (''),
	[l507ep] [varchar](300) NOT NULL DEFAULT (''),
	[l508ep] [varchar](20) NOT NULL DEFAULT (''),
	[l509ep] [nvarchar](255) NOT NULL DEFAULT (''),
	[l510ep] [nvarchar](700) NOT NULL DEFAULT (''),
	[l511ep] [varchar](20) NOT NULL DEFAULT (''),
	[l512ep] [date] NOT NULL DEFAULT ('9999-12-31'),
	[l513ep] [date] NOT NULL DEFAULT ('9999-12-31'),
	[l515ep] [nvarchar](255) NOT NULL DEFAULT (''),
	[l516ep] [varchar](50) NOT NULL DEFAULT (''),
	[l517ep] [nvarchar](255) NOT NULL DEFAULT (''),
	[l518ep] [date] NOT NULL DEFAULT ('9999-12-31'),
	[l519ep] [nvarchar](255) NOT NULL DEFAULT (''),
	[l520ep] [tinyint] NOT NULL DEFAULT ('0'),
	[l522ep] [nvarchar](255) NOT NULL DEFAULT (''),
	[l523ep] [date] NOT NULL DEFAULT ('9999-12-31'),
	[l524ep] [varchar](100) NOT NULL DEFAULT (''),
	[l525ep] [date] NOT NULL DEFAULT ('9999-12-31'),
PRIMARY KEY CLUSTERED 
(
	[appln_id] ASC,
	[prs_event_seq_nr] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]


BULK INSERT [dbo].[tls221_inpadoc_prs]
		FROM 'C:\PLR\Patstat\tls\processed\tls221.txt'
		WITH
		(
		BATCHSIZE = 20000, 
		DATAFILETYPE = 'widenative',
		--ERRORFILE = 'C:\PLR\Patstat\tls\bad_tls221.txt',
		FORMATFILE = 'C:\PLR\ps_load\patstat\fmt\tls221.fmt'
		)
GO

IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tls221_inpadoc_prs]') AND name = N'tls221_inpadoc_prs_gazette_date')
DROP INDEX [tls221_inpadoc_prs_gazette_date] ON [dbo].[tls221_inpadoc_prs] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [tls221_inpadoc_prs_gazette_date] ON [dbo].[tls221_inpadoc_prs] 
(
	[prs_gazette_date] ASC,
	[appln_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = OFF) ON [PRIMARY]
GO

IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tls221_inpadoc_prs]') AND name = N'tls221_inpadoc_prs_lec_id')
DROP INDEX [tls221_inpadoc_prs_lec_id] ON [dbo].[tls221_inpadoc_prs] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [tls221_inpadoc_prs_lec_id] ON [dbo].[tls221_inpadoc_prs] 
(
	[lec_id] ASC,
	[appln_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = OFF) ON [PRIMARY]
GO

IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tls221_inpadoc_prs]') AND name = N'tls221_inpadoc_prs_prs_code')
DROP INDEX [tls221_inpadoc_prs_prs_code] ON [dbo].[tls221_inpadoc_prs] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [tls221_inpadoc_prs_prs_code] ON [dbo].[tls221_inpadoc_prs] 
(
	[prs_code] ASC,
	[appln_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = OFF) ON [PRIMARY]
GO

