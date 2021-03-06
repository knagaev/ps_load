USE patscape
GO
/****** Object:  Table [dbo].[tls209_appln_ipc]    Script Date: 07/07/2015 08:19:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tls209_appln_ipc](
	[appln_id] [int] NOT NULL DEFAULT ('0'),
	[ipc_class_symbol] [varchar](15) NOT NULL DEFAULT (''),
	[ipc_class_level] [char](1) NOT NULL DEFAULT (''),
	[ipc_version] [date] NOT NULL DEFAULT ('9999-12-31'),
	[ipc_value] [char](1) NOT NULL DEFAULT (''),
	[ipc_position] [char](1) NOT NULL DEFAULT (''),
	[ipc_gener_auth] [char](2) NOT NULL DEFAULT (''),
PRIMARY KEY CLUSTERED 
(
	[appln_id] ASC,
	[ipc_class_symbol] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

BULK INSERT [dbo].[tls209_appln_ipc]
		FROM 'C:\PLR\Patstat\tls\processed\tls209.txt'
		WITH
		(
		BATCHSIZE = 100000, 
		DATAFILETYPE = 'char',
		FORMATFILE = 'C:\PLR\ps_load\patstat\fmt\tls209.fmt'
		)
GO

IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tls209_appln_ipc]') AND name = N'tls209_appl_ipc_XLS209M1')
DROP INDEX [tls209_appl_ipc_XLS209M1] ON [dbo].[tls209_appln_ipc] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [tls209_appl_ipc_XLS209M1] ON [dbo].[tls209_appln_ipc] 
(
	[ipc_class_symbol] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = OFF) ON [PRIMARY]
GO
