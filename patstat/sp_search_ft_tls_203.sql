drop PROCEDURE [dbo].[SP_SEARCH_FT_TLS_203] ;
go

-- =============================================
-- Author:		Константин Нагаев
-- Create date: 15.04.2014
-- Description:	Загрузка tls_203 Patstat
-- =============================================
create PROCEDURE [dbo].[SP_SEARCH_FT_TLS_203] 
	@cond varchar(max),
	@near_distance int = 0
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	declare @langs table(id int identity(1,1), lang varchar(10))

	insert into @langs (lang)
		select 'ar' union
		select 'bg' union
		select 'cs' union
		select 'da' union
		select 'de' union
		select 'el' union
		select 'en' union
		select 'es' union
		select 'et' union
		select 'fr' union
		select 'hr' union
		select 'it' union
		select 'ja' union
		select 'ko' union
		select 'lt' union
		select 'lv' union
		select 'nl' union
		select 'no' union
		select 'pl' union
		select 'pt' union
		select 'ro' union
		select 'ru' union
		select 'sh' union
		select 'sk' union
		select 'sl' union
		select 'sr' union
		select 'sv' union
		select 'tr' union
		select 'uk' union
		select 'zh'
	 
	declare @i int
	declare @cnt int
	declare @lang varchar(2)
	declare @union varchar(20) = ' union all ' 
	--declare @cond varchar(max)
	declare @sql varchar(max) = ''

	select @i = min(id) - 1, @cnt = max(id) from @langs

	--set @cond = '(laser, form, new)'
	if @near_distance = 0
		set @near_distance = (len(@cond) - len(replace(@cond, ',', ''))) * 3;

	while @i < @cnt
	begin
		 select @i = @i + 1
		 if @i = @cnt 
			select @union = '';
	 	 
		 select @lang = lang from @langs where id = @i

		 select @sql = @sql + 'SELECT [KEY]
	FROM CONTAINSTABLE(tls203_appln_abstr_' + @lang + ', appln_abstract,
	  ''NEAR((' + @cond + '), ' + cast(@near_distance as varchar) + ' , FALSE)'' )' + @union


	end

	--select @sql     
	execute(@sql)

END
