USE patscape
GO

/****** Object:  Table [dbo].[tls226_person_orig]    Script Date: 02/03/2016 04:32:25 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tls226_person_orig](
	[person_orig_id] [int] NOT NULL DEFAULT ('0'),
	[person_id] [int] NOT NULL DEFAULT ('0'),
	[source] [char](5) NOT NULL DEFAULT (''),
	[source_version] [varchar](10) NOT NULL DEFAULT (''),
	[name_freeform] [nvarchar](500) NOT NULL DEFAULT (''),
	[last_name] [nvarchar](500) NOT NULL DEFAULT (''),
	[first_name] [nvarchar](500) NOT NULL DEFAULT (''),
	[middle_name] [nvarchar](500) NOT NULL DEFAULT (''),
	[address_freeform] [nvarchar](1000) NOT NULL DEFAULT (''),
	[address_1] [nvarchar](500) NOT NULL DEFAULT (''),
	[address_2] [nvarchar](500) NOT NULL DEFAULT (''),
	[address_3] [nvarchar](500) NOT NULL DEFAULT (''),
	[address_4] [nvarchar](500) NOT NULL DEFAULT (''),
	[address_5] [nvarchar](500) NOT NULL DEFAULT (''),
	[street] [nvarchar](500) NOT NULL DEFAULT (''),
	[city] [nvarchar](200) NOT NULL DEFAULT (''),
  	[zip_code] [nvarchar](30) NOT NULL DEFAULT (''),
	[state] [char](2) NOT NULL DEFAULT (''),
	[person_ctry_code] [char](2) NOT NULL DEFAULT (''),
	[residence_ctry_code] [char](2) NOT NULL DEFAULT (''),
	[role] [varchar](2) NOT NULL DEFAULT (''),
PRIMARY KEY CLUSTERED 
(
	[person_orig_id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

GO

BULK INSERT [dbo].[tls226_person_orig]
		FROM 'C:\PLR\Patstat\tls\processed\tls226.txt'
		WITH
		(
		BATCHSIZE = 20000, 
		DATAFILETYPE = 'char',
		ERRORFILE = 'C:\PLR\Patstat\tls\bad_tls226.txt',
		FORMATFILE = 'C:\PLR\ps_load\patstat\fmt\tls226.fmt'
		)
GO

IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tls226_person_orig]') AND name = N'IX_tls206_person_cty')
DROP INDEX [IX_tls226_person_id] ON [dbo].[tls226_person_orig] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_tls226_person_id] ON [dbo].[tls226_person_orig] 
(
	[person_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO



