USE [patscape]
GO
/****** Object:  StoredProcedure [dbo].[FN_SEARCH_FORMSOF_FT_TLS_203]    Script Date: 25.04.2017 17:16:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
DROP FUNCTION splitstring
go

CREATE FUNCTION splitstring ( @stringToSplit NVARCHAR(MAX), @delim nvarchar(1) = N',' )
RETURNS
 @returnList TABLE ([Item] [nvarchar] (500))
AS
BEGIN

 DECLARE @name NVARCHAR(255)
 DECLARE @pos INT

 WHILE CHARINDEX(@delim, @stringToSplit) > 0
 BEGIN
  SELECT @pos  = CHARINDEX(@delim, @stringToSplit)  
  SELECT @name = SUBSTRING(@stringToSplit, 1, @pos-1)

  INSERT INTO @returnList 
  SELECT @name

  SELECT @stringToSplit = LTRIM(RTRIM(SUBSTRING(@stringToSplit, @pos+1, LEN(@stringToSplit)-@pos)))
 END

 INSERT INTO @returnList
 SELECT @stringToSplit

 RETURN
END
*/



/*
DROP FUNCTION [dbo].[FN_SEARCH_FORMSOF_FT_TLS_203]
GO
-- =============================================
-- Author:		Константин Нагаев
-- Create date: 15.04.2014
-- Description:	Загрузка tls_203 Patstat
-- =============================================
CREATE FUNCTION [dbo].[FN_SEARCH_FORMSOF_FT_TLS_203] (
	@cond nvarchar(max),
	@operator nvarchar(6) = 'AND'
	)
RETURNS  @rtnTable TABLE 
(
    -- columns returned by the function
    appln_id int NOT NULL
)
AS
BEGIN


	declare @formsof nvarchar(4000);
	
	select @formsof = SUBSTRING(
								(
								select N' ' + @operator + ' FORMSOF(INFLECTIONAL,"' + t1.Item + N'")' AS [text()]
											From splitstring(@cond, DEFAULT) t1
											For XML PATH ('')
								), LEN(@operator) + 2, 8000);

	INSERT @rtnTable
	SELECT [KEY]
	FROM CONTAINSTABLE(tls203_appln_abstr_ar, appln_abstract,
	  @formsof ) union all SELECT [KEY]
	FROM CONTAINSTABLE(tls203_appln_abstr_bg, appln_abstract,
	  @formsof ) union all SELECT [KEY]
	FROM CONTAINSTABLE(tls203_appln_abstr_cs, appln_abstract,
	  @formsof ) union all SELECT [KEY]
	FROM CONTAINSTABLE(tls203_appln_abstr_da, appln_abstract,
	  @formsof ) union all SELECT [KEY]
	FROM CONTAINSTABLE(tls203_appln_abstr_de, appln_abstract,
	  @formsof ) union all SELECT [KEY]
	FROM CONTAINSTABLE(tls203_appln_abstr_el, appln_abstract,
	  @formsof ) union all SELECT [KEY]
	FROM CONTAINSTABLE(tls203_appln_abstr_en, appln_abstract,
	  @formsof ) union all SELECT [KEY]
	FROM CONTAINSTABLE(tls203_appln_abstr_es, appln_abstract,
	  @formsof ) union all SELECT [KEY]
	FROM CONTAINSTABLE(tls203_appln_abstr_et, appln_abstract,
	  @formsof ) union all SELECT [KEY]
	FROM CONTAINSTABLE(tls203_appln_abstr_fr, appln_abstract,
	  @formsof ) union all SELECT [KEY]
	FROM CONTAINSTABLE(tls203_appln_abstr_hr, appln_abstract,
	  @formsof ) union all SELECT [KEY]
	FROM CONTAINSTABLE(tls203_appln_abstr_it, appln_abstract,
	  @formsof ) union all SELECT [KEY]
	FROM CONTAINSTABLE(tls203_appln_abstr_ja, appln_abstract,
	  @formsof ) union all SELECT [KEY]
	FROM CONTAINSTABLE(tls203_appln_abstr_ko, appln_abstract,
	  @formsof ) union all SELECT [KEY]
	FROM CONTAINSTABLE(tls203_appln_abstr_lt, appln_abstract,
	  @formsof ) union all SELECT [KEY]
	FROM CONTAINSTABLE(tls203_appln_abstr_lv, appln_abstract,
	  @formsof ) union all SELECT [KEY]
	FROM CONTAINSTABLE(tls203_appln_abstr_nl, appln_abstract,
	  @formsof ) union all SELECT [KEY]
	FROM CONTAINSTABLE(tls203_appln_abstr_no, appln_abstract,
	  @formsof ) union all SELECT [KEY]
	FROM CONTAINSTABLE(tls203_appln_abstr_pl, appln_abstract,
	  @formsof ) union all SELECT [KEY]
	FROM CONTAINSTABLE(tls203_appln_abstr_pt, appln_abstract,
	  @formsof ) union all SELECT [KEY]
	FROM CONTAINSTABLE(tls203_appln_abstr_ro, appln_abstract,
	  @formsof ) union all SELECT [KEY]
	FROM CONTAINSTABLE(tls203_appln_abstr_ru, appln_abstract,
	  @formsof ) union all SELECT [KEY]
	FROM CONTAINSTABLE(tls203_appln_abstr_sh, appln_abstract,
	  @formsof ) union all SELECT [KEY]
	FROM CONTAINSTABLE(tls203_appln_abstr_sk, appln_abstract,
	  @formsof ) union all SELECT [KEY]
	FROM CONTAINSTABLE(tls203_appln_abstr_sl, appln_abstract,
	  @formsof ) union all SELECT [KEY]
	FROM CONTAINSTABLE(tls203_appln_abstr_sr, appln_abstract,
	  @formsof ) union all SELECT [KEY]
	FROM CONTAINSTABLE(tls203_appln_abstr_sv, appln_abstract,
	  @formsof ) union all SELECT [KEY]
	FROM CONTAINSTABLE(tls203_appln_abstr_tr, appln_abstract,
	  @formsof ) union all SELECT [KEY]
	FROM CONTAINSTABLE(tls203_appln_abstr_uk, appln_abstract,
	  @formsof ) union all SELECT [KEY]
	FROM CONTAINSTABLE(tls203_appln_abstr_zh, appln_abstract,
	  @formsof );
	  
	  	return;
END
*/


select * from tls203_appln_abstr_bg where appln_id in(
select appln_id from FN_SEARCH_FORMSOF_FT_TLS_203 (N'метод, съединение'));

select appln_year, count(*)
from 
FN_SEARCH_FORMSOF_FT_TLS_203 (N'красный, лазер') KEYS
inner 
-- loop -- хинт, с ним у меня самые быстрые запросы получались (альтернатива hash, merge), можно его включить 
join appln_search ayc
on ayc.appln_id = KEYS.appln_id
group by appln_year
order by count(*) desc;

-- статистика распределения документов с требуемыми термами по годам и странам
select appln_year, appln_auth, count(*)
from 
FN_SEARCH_FORMSOF_FT_TLS_203 (N'красный, лазер') KEYS
inner 
-- loop -- хинт, с ним у меня самые быстрые запросы получались (альтернатива hash, merge), можно его включить 
join appln_search ayc
on ayc.appln_id = KEYS.appln_id
group by appln_year, appln_auth
order by count(*) desc;

-- статистика распределения документов с требуемыми термами по годам и странам
select appln_auth, count(*)
from 
FN_SEARCH_FORMSOF_FT_TLS_203 (N'красный, лазер') KEYS
inner 
-- loop -- хинт, с ним у меня самые быстрые запросы получались (альтернатива hash, merge), можно его включить 
join appln_search ayc
on ayc.appln_id = KEYS.appln_id
where appln_year in ('2011', '1996', '2007')
group by appln_auth
order by count(*) desc;

-- через OR
select appln_year, count(*)
from 
appln_search ayc
where 
ayc.appln_id in (select KEY from FN_SEARCH_FORMSOF_FT_TLS_203 (N'красный, лазер') 
or ayc.appln_id in (select KEY from FN_SEARCH_FORMSOF_FT_TLS_203 (N'синий, кубик')
or ayc.appln_id in (select KEY from FN_SEARCH_FORMSOF_FT_TLS_203 (N'белый, слон')
group by appln_year
order by appln_year;
