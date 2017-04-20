USE [patscape]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Константин Нагаев
-- Create date: 15.04.2014
-- Description:	Загрузка tls_202 Patstat
-- =============================================
CREATE PROCEDURE SP_LOAD_TLS_202 
	@lang varchar(2),
	@datafile varchar(255) = 'C:\PLR\patstat\tls\processed\', 
	@formatfile varchar(255) = 'C:\PLR\ps_load\patstat\fmt\tls202.fmt' 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	--declare @datafile varchar(255)
	--set @datafile = 'G:\Patstat\Patstat Biblio\data_PATSTAT_Biblio_2016_Autumn\tls202\processed\'
	--declare @formatfile varchar(255)
	--set @formatfile = 'C:\PLR\R_catalys\patstat\tls202.fmt'


	DECLARE @SQLString VARCHAR(MAX)
	SET @SQLString = 'BULK INSERT [dbo].tls202_appln_title_' + @lang + '
		FROM ''' + @datafile + '\tls202_' + @lang + '.txt''
		WITH
		(
		BATCHSIZE = 20000, 
		DATAFILETYPE = ''char'',
		FORMATFILE = ''' + @formatfile + '''
		)
		';

	--select @SQLString
	exec (@SQLString) 

END
GO
