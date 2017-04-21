USE patscape
GO

/****** Object:  Table [dbo].[tls222_appln_jp_class]    Script Date: 07/07/2015 04:32:25 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tls222_appln_jp_class](
	[appln_id] [int] NOT NULL DEFAULT ('0'),
	[jp_class_scheme] [varchar](5) NOT NULL DEFAULT (''),
	[jp_class_symbol] [varchar](50) NOT NULL DEFAULT (''),
PRIMARY KEY CLUSTERED 
(
	[appln_id] ASC,
	[jp_class_scheme] ASC,
	[jp_class_symbol] ASC
)WITH (IGNORE_DUP_KEY = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


BULK INSERT [dbo].[tls222_appln_jp_class]
		FROM 'C:\PLR\Patstat\tls\processed\tls222.txt'
		WITH
		(
		BATCHSIZE = 20000, 
		DATAFILETYPE = 'char',
		ERRORFILE = 'C:\PLR\Patstat\tls\bad_tls222.txt',
		FORMATFILE = 'C:\PLR\ps_load\patstat\fmt\tls222.fmt'
		)
GO

IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tls222_appln_jp_class]') AND name = N'tls222_appln_jp_class_XLS222C1')
DROP INDEX [tls222_appln_jp_class_XLS222C1] ON [dbo].[tls222_appln_jp_class] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [tls222_appln_jp_class_XLS222C1] ON [dbo].[tls222_appln_jp_class] 
(
	[jp_class_symbol] ASC,
	[jp_class_scheme] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = OFF) ON [PRIMARY]
GO


