USE [patscape]
GO

/****** Object:  View [dbo].[all_abstracts]    Script Date: 19.05.2017 16:00:32 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

  create view [dbo].[all_abstracts] as
select appln_id, 'ar' lng, cast(appln_abstract as nvarchar(max)) collate database_default appln_abstract from tls203_appln_abstr_ar union all  
select appln_id, 'bg' lng, cast(appln_abstract as nvarchar(max)) collate database_default appln_abstract from tls203_appln_abstr_bg union all  
select appln_id, 'cs' lng, cast(appln_abstract as nvarchar(max)) collate database_default appln_abstract from tls203_appln_abstr_cs union all  
select appln_id, 'da' lng, cast(appln_abstract as nvarchar(max)) collate database_default appln_abstract from tls203_appln_abstr_da union all  
select appln_id, 'de' lng, cast(appln_abstract as nvarchar(max)) collate database_default appln_abstract from tls203_appln_abstr_de union all  
select appln_id, 'el' lng, cast(appln_abstract as nvarchar(max)) collate database_default appln_abstract from tls203_appln_abstr_el union all  
select appln_id, 'en' lng, cast(appln_abstract as nvarchar(max)) collate database_default appln_abstract from tls203_appln_abstr_en where appln_id not in (select appln_id from tls203_appln_abstr_ru) union all  
select appln_id, 'es' lng, cast(appln_abstract as nvarchar(max)) collate database_default appln_abstract from tls203_appln_abstr_es union all  
select appln_id, 'et' lng, cast(appln_abstract as nvarchar(max)) collate database_default appln_abstract from tls203_appln_abstr_et union all  
select appln_id, 'fr' lng, cast(appln_abstract as nvarchar(max)) collate database_default appln_abstract from tls203_appln_abstr_fr union all  
select appln_id, 'hr' lng, cast(appln_abstract as nvarchar(max)) collate database_default appln_abstract from tls203_appln_abstr_hr union all  
select appln_id, 'it' lng, cast(appln_abstract as nvarchar(max)) collate database_default appln_abstract from tls203_appln_abstr_it union all  
select appln_id, 'ja' lng, cast(appln_abstract as nvarchar(max)) collate database_default appln_abstract from tls203_appln_abstr_ja union all  
select appln_id, 'ko' lng, cast(appln_abstract as nvarchar(max)) collate database_default appln_abstract from tls203_appln_abstr_ko union all  
select appln_id, 'lt' lng, cast(appln_abstract as nvarchar(max)) collate database_default appln_abstract from tls203_appln_abstr_lt union all  
select appln_id, 'lv' lng, cast(appln_abstract as nvarchar(max)) collate database_default appln_abstract from tls203_appln_abstr_lv union all  
select appln_id, 'nl' lng, cast(appln_abstract as nvarchar(max)) collate database_default appln_abstract from tls203_appln_abstr_nl union all  
select appln_id, 'no' lng, cast(appln_abstract as nvarchar(max)) collate database_default appln_abstract from tls203_appln_abstr_no union all  
select appln_id, 'pl' lng, cast(appln_abstract as nvarchar(max)) collate database_default appln_abstract from tls203_appln_abstr_pl union all  
select appln_id, 'pt' lng, cast(appln_abstract as nvarchar(max)) collate database_default appln_abstract from tls203_appln_abstr_pt union all  
select appln_id, 'ro' lng, cast(appln_abstract as nvarchar(max)) collate database_default appln_abstract from tls203_appln_abstr_ro union all  
select appln_id, 'ru' lng, cast(appln_abstract as nvarchar(max)) collate database_default appln_abstract from tls203_appln_abstr_ru union all  
select appln_id, 'sh' lng, cast(appln_abstract as nvarchar(max)) collate database_default appln_abstract from tls203_appln_abstr_sh union all  
select appln_id, 'sk' lng, cast(appln_abstract as nvarchar(max)) collate database_default appln_abstract from tls203_appln_abstr_sk union all  
select appln_id, 'sl' lng, cast(appln_abstract as nvarchar(max)) collate database_default appln_abstract from tls203_appln_abstr_sl union all  
select appln_id, 'sr' lng, cast(appln_abstract as nvarchar(max)) collate database_default appln_abstract from tls203_appln_abstr_sr union all  
select appln_id, 'sv' lng, cast(appln_abstract as nvarchar(max)) collate database_default appln_abstract from tls203_appln_abstr_sv union all  
select appln_id, 'tr' lng, cast(appln_abstract as nvarchar(max)) collate database_default appln_abstract from tls203_appln_abstr_tr union all  
select appln_id, 'uk' lng, cast(appln_abstract as nvarchar(max)) collate database_default appln_abstract from tls203_appln_abstr_uk union all  
select appln_id, 'zh' lng, cast(appln_abstract as nvarchar(max)) collate database_default appln_abstract from tls203_appln_abstr_zh

GO


