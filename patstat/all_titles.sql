USE [patscape]
GO

/****** Object:  View [dbo].[all_titles]    Script Date: 19.05.2017 16:00:32 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

  create view [dbo].[all_titles] as
select appln_id, 'ar' lng, cast(appln_title as nvarchar(max)) collate database_default appln_title from tls202_appln_title_ar union all  
select appln_id, 'bg' lng, cast(appln_title as nvarchar(max)) collate database_default appln_title from tls202_appln_title_bg union all  
select appln_id, 'cs' lng, cast(appln_title as nvarchar(max)) collate database_default appln_title from tls202_appln_title_cs union all  
select appln_id, 'da' lng, cast(appln_title as nvarchar(max)) collate database_default appln_title from tls202_appln_title_da union all  
select appln_id, 'de' lng, cast(appln_title as nvarchar(max)) collate database_default appln_title from tls202_appln_title_de union all  
select appln_id, 'el' lng, cast(appln_title as nvarchar(max)) collate database_default appln_title from tls202_appln_title_el union all  
select appln_id, 'en' lng, cast(appln_title as nvarchar(max)) collate database_default appln_title from tls202_appln_title_en where appln_id not in (select appln_id from tls202_appln_title_ru) union all  
select appln_id, 'es' lng, cast(appln_title as nvarchar(max)) collate database_default appln_title from tls202_appln_title_es union all  
select appln_id, 'et' lng, cast(appln_title as nvarchar(max)) collate database_default appln_title from tls202_appln_title_et union all  
select appln_id, 'fr' lng, cast(appln_title as nvarchar(max)) collate database_default appln_title from tls202_appln_title_fr union all  
select appln_id, 'hr' lng, cast(appln_title as nvarchar(max)) collate database_default appln_title from tls202_appln_title_hr union all  
select appln_id, 'it' lng, cast(appln_title as nvarchar(max)) collate database_default appln_title from tls202_appln_title_it union all  
select appln_id, 'ja' lng, cast(appln_title as nvarchar(max)) collate database_default appln_title from tls202_appln_title_ja union all  
select appln_id, 'ko' lng, cast(appln_title as nvarchar(max)) collate database_default appln_title from tls202_appln_title_ko union all  
select appln_id, 'lt' lng, cast(appln_title as nvarchar(max)) collate database_default appln_title from tls202_appln_title_lt union all  
select appln_id, 'lv' lng, cast(appln_title as nvarchar(max)) collate database_default appln_title from tls202_appln_title_lv union all  
select appln_id, 'nl' lng, cast(appln_title as nvarchar(max)) collate database_default appln_title from tls202_appln_title_nl union all  
select appln_id, 'no' lng, cast(appln_title as nvarchar(max)) collate database_default appln_title from tls202_appln_title_no union all  
select appln_id, 'pl' lng, cast(appln_title as nvarchar(max)) collate database_default appln_title from tls202_appln_title_pl union all  
select appln_id, 'pt' lng, cast(appln_title as nvarchar(max)) collate database_default appln_title from tls202_appln_title_pt union all  
select appln_id, 'ro' lng, cast(appln_title as nvarchar(max)) collate database_default appln_title from tls202_appln_title_ro union all  
select appln_id, 'ru' lng, cast(appln_title as nvarchar(max)) collate database_default appln_title from tls202_appln_title_ru union all  
select appln_id, 'sh' lng, cast(appln_title as nvarchar(max)) collate database_default appln_title from tls202_appln_title_sh union all  
select appln_id, 'sk' lng, cast(appln_title as nvarchar(max)) collate database_default appln_title from tls202_appln_title_sk union all  
select appln_id, 'sl' lng, cast(appln_title as nvarchar(max)) collate database_default appln_title from tls202_appln_title_sl union all  
select appln_id, 'sr' lng, cast(appln_title as nvarchar(max)) collate database_default appln_title from tls202_appln_title_sr union all  
select appln_id, 'sv' lng, cast(appln_title as nvarchar(max)) collate database_default appln_title from tls202_appln_title_sv union all  
select appln_id, 'tr' lng, cast(appln_title as nvarchar(max)) collate database_default appln_title from tls202_appln_title_tr union all  
select appln_id, 'uk' lng, cast(appln_title as nvarchar(max)) collate database_default appln_title from tls202_appln_title_uk union all  
select appln_id, 'zh' lng, cast(appln_title as nvarchar(max)) collate database_default appln_title from tls202_appln_title_zh

GO


