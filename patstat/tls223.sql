USE patscape
GO

/****** Object:  Table [dbo].[tls223_appln_docus]    Script Date: 07/07/2015 04:32:25 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tls223_appln_docus](
	[appln_id] [int] NOT NULL DEFAULT ('0'),
	[docus_class_symbol] [varchar](50) NOT NULL DEFAULT (''),
PRIMARY KEY CLUSTERED 
(
	[appln_id] ASC,
	[docus_class_symbol] ASC
)WITH (IGNORE_DUP_KEY = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


BULK INSERT [dbo].[tls223_appln_docus]
		FROM 'C:\PLR\Patstat\tls\processed\tls223.txt'
		WITH
		(
		BATCHSIZE = 20000, 
		DATAFILETYPE = 'char',
		ERRORFILE = 'C:\PLR\Patstat\tls\bad_tls223.txt',
		FORMATFILE = 'C:\PLR\ps_load\patstat\fmt\tls223.fmt'
		)
GO

IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tls223_appln_docus]') AND name = N'tls223_appln_docus_XLS223C1')
DROP INDEX [tls223_appln_docus_XLS223C1] ON [dbo].[tls223_appln_docus] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [tls223_appln_docus_XLS223C1] ON [dbo].[tls223_appln_docus] 
(
	[docus_class_symbol] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = OFF) ON [PRIMARY]
GO

