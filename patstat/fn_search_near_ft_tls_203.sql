USE [patscape]
GO
/****** Object:  StoredProcedure [dbo].[FN_SEARCH_NEAR_FT_TLS_203]    Script Date: 25.04.2017 17:16:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- DROP FUNCTION [dbo].[FN_SEARCH_NEAR_FT_TLS_203]
/*
-- =============================================
-- Author:		���������� ������
-- Create date: 15.04.2014
-- Description:	�������� tls_203 Patstat
-- =============================================
CREATE FUNCTION [dbo].[FN_SEARCH_NEAR_FT_TLS_203] (
	@cond nvarchar(max),
	@near_distance int = 0,
	@order nvarchar(10) = 'TRUE'
	)
RETURNS  @rtnTable TABLE 
(
    -- columns returned by the function
    appln_id int NOT NULL
)
AS
BEGIN

	if @near_distance = 0
		set @near_distance = (len(@cond) - len(replace(@cond, ',', ''))) * 3;

	declare @near nvarchar(4000) = N'NEAR((' + @cond + N'),  ' + cast(@near_distance as nvarchar) + N', ' + @order + N')';

	INSERT @rtnTable
	SELECT [KEY]
	FROM CONTAINSTABLE(tls203_appln_abstr_ar, appln_abstract,
	  @near ) union all SELECT [KEY]
	FROM CONTAINSTABLE(tls203_appln_abstr_bg, appln_abstract,
	  @near ) union all SELECT [KEY]
	FROM CONTAINSTABLE(tls203_appln_abstr_cs, appln_abstract,
	  @near ) union all SELECT [KEY]
	FROM CONTAINSTABLE(tls203_appln_abstr_da, appln_abstract,
	  @near ) union all SELECT [KEY]
	FROM CONTAINSTABLE(tls203_appln_abstr_de, appln_abstract,
	  @near ) union all SELECT [KEY]
	FROM CONTAINSTABLE(tls203_appln_abstr_el, appln_abstract,
	  @near ) union all SELECT [KEY]
	FROM CONTAINSTABLE(tls203_appln_abstr_en, appln_abstract,
	  @near ) union all SELECT [KEY]
	FROM CONTAINSTABLE(tls203_appln_abstr_es, appln_abstract,
	  @near ) union all SELECT [KEY]
	FROM CONTAINSTABLE(tls203_appln_abstr_et, appln_abstract,
	  @near ) union all SELECT [KEY]
	FROM CONTAINSTABLE(tls203_appln_abstr_fr, appln_abstract,
	  @near ) union all SELECT [KEY]
	FROM CONTAINSTABLE(tls203_appln_abstr_hr, appln_abstract,
	  @near ) union all SELECT [KEY]
	FROM CONTAINSTABLE(tls203_appln_abstr_it, appln_abstract,
	  @near ) union all SELECT [KEY]
	FROM CONTAINSTABLE(tls203_appln_abstr_ja, appln_abstract,
	  @near ) union all SELECT [KEY]
	FROM CONTAINSTABLE(tls203_appln_abstr_ko, appln_abstract,
	  @near ) union all SELECT [KEY]
	FROM CONTAINSTABLE(tls203_appln_abstr_lt, appln_abstract,
	  @near ) union all SELECT [KEY]
	FROM CONTAINSTABLE(tls203_appln_abstr_lv, appln_abstract,
	  @near ) union all SELECT [KEY]
	FROM CONTAINSTABLE(tls203_appln_abstr_nl, appln_abstract,
	  @near ) union all SELECT [KEY]
	FROM CONTAINSTABLE(tls203_appln_abstr_no, appln_abstract,
	  @near ) union all SELECT [KEY]
	FROM CONTAINSTABLE(tls203_appln_abstr_pl, appln_abstract,
	  @near ) union all SELECT [KEY]
	FROM CONTAINSTABLE(tls203_appln_abstr_pt, appln_abstract,
	  @near ) union all SELECT [KEY]
	FROM CONTAINSTABLE(tls203_appln_abstr_ro, appln_abstract,
	  @near ) union all SELECT [KEY]
	FROM CONTAINSTABLE(tls203_appln_abstr_ru, appln_abstract,
	  @near ) union all SELECT [KEY]
	FROM CONTAINSTABLE(tls203_appln_abstr_sh, appln_abstract,
	  @near ) union all SELECT [KEY]
	FROM CONTAINSTABLE(tls203_appln_abstr_sk, appln_abstract,
	  @near ) union all SELECT [KEY]
	FROM CONTAINSTABLE(tls203_appln_abstr_sl, appln_abstract,
	  @near ) union all SELECT [KEY]
	FROM CONTAINSTABLE(tls203_appln_abstr_sr, appln_abstract,
	  @near ) union all SELECT [KEY]
	FROM CONTAINSTABLE(tls203_appln_abstr_sv, appln_abstract,
	  @near ) union all SELECT [KEY]
	FROM CONTAINSTABLE(tls203_appln_abstr_tr, appln_abstract,
	  @near ) union all SELECT [KEY]
	FROM CONTAINSTABLE(tls203_appln_abstr_uk, appln_abstract,
	  @near ) union all SELECT [KEY]
	FROM CONTAINSTABLE(tls203_appln_abstr_zh, appln_abstract,
	  @near );
	  
	  
	  	return;
END
*/

select * from FN_SEARCH_NEAR_FT_TLS_203 (N'�����, ����������', default, 'FALSE');

select appln_year, count(*)
from 
FN_SEARCH_NEAR_FT_TLS_203 (N'�������, ����������', default, 'FALSE') KEYS
inner 
-- loop -- ����, � ��� � ���� ����� ������� ������� ���������� (������������ hash, merge), ����� ��� �������� 
join appln_search ayc
on ayc.appln_id = KEYS.appln_id
group by appln_year
order by count(*) desc;

-- ���������� ������������� ���������� � ���������� ������� �� ����� � �������
select appln_year, appln_auth, count(*)
from 
FN_SEARCH_NEAR_FT_TLS_203 (N'�������, ����������', default, 'FALSE') KEYS
inner 
-- loop -- ����, � ��� � ���� ����� ������� ������� ���������� (������������ hash, merge), ����� ��� �������� 
join appln_search ayc
on ayc.appln_id = KEYS.appln_id
group by appln_year, appln_auth
order by count(*) desc;

-- ���������� ������������� ���������� � ���������� ������� �� ����� � �������
select appln_auth, count(*)
from 
FN_SEARCH_NEAR_FT_TLS_203 (N'�������, ����������', default, 'FALSE') KEYS
inner 
-- loop -- ����, � ��� � ���� ����� ������� ������� ���������� (������������ hash, merge), ����� ��� �������� 
join appln_search ayc
on ayc.appln_id = KEYS.appln_id
where appln_year in ('2011', '1996', '2006')
group by appln_auth
order by count(*) desc;


