use patscape
go

select appln_id, IPC = stuff((select '; ' + replace(ipc_class_symbol, ' ', '') as [text()]
							from tls209_appln_ipc xt
							where xt.appln_id = t.appln_id order by ipc_position asc
							for xml path('') ), 1, 2, '')
					into tmp_ipcs
					  from tls209_appln_ipc t
					  group by t.appln_id;
go

create unique index ndx_tmp_ipcs on tmp_ipcs(appln_id);
go

select appln_id, CPC = stuff((select '; ' + replace(cpc_class_symbol, ' ', '') as [text()]
						from tls224_appln_cpc xt
						where xt.appln_id = t.appln_id order by cpc_position asc
						for xml path('') ), 1, 2, '')
					into tmp_cpcs
				  from tls224_appln_cpc t
				  group by t.appln_id;
go

create unique index ndx_tmp_cpcs on tmp_cpcs(appln_id);
go

select appln_id, 
        applicants = stuff((select '; ' + person_name as [text()]
          from tls206_person p inner join tls207_pers_appln xt on xt.person_id = p.person_id
          where t.appln_id = xt.appln_id and xt.applt_seq_nr > 0 order by applt_seq_nr asc
          for xml path('') ), 1, 2, '')
		into tmp_applicants
from tls207_pers_appln t
group by t.appln_id
;
go

create unique index ndx_tmp_applicants on tmp_applicants(appln_id);
go

select appln_id, 
        inventors = stuff((select '; ' + person_name as [text()]
          from tls206_person p inner join tls207_pers_appln xt on xt.person_id = p.person_id
          where t.appln_id = xt.appln_id and xt.invt_seq_nr > 0 order by invt_seq_nr asc
          for xml path('') ), 1, 2, '')
		into tmp_inventors
from tls207_pers_appln t
group by t.appln_id
;
go

create unique index ndx_tmp_inventors on tmp_inventors(appln_id);
go

SELECT t201.appln_id,
  CASE 
    WHEN t201.appln_auth in ('RU','SU') THEN t211rusu.publn_date
    ELSE t201.earliest_publn_date
  end AS base_publn_date
into tmp_base_publn_dates
FROM tls201_appln t201
  LEFT JOIN (SELECT t211.appln_id, t211.publn_date 
              FROM 
              (SELECT appln_id, publn_date, ROW_NUMBER() OVER (PARTITION BY appln_id ORDER BY publn_date DESC) rn 
                FROM tls211_pat_publn WHERE publn_date <> '9999-12-31') t211
              WHERE t211.rn = 1) t211rusu ON t211rusu.appln_id = t201.appln_id AND t201.appln_auth in ('RU','SU')
;
go

create index ndx_tmp_base_publn_dates on tmp_base_publn_dates(appln_id, base_publn_date);
go
--drop table tmp_base_publn_auths
SELECT t201.appln_id,
  CASE 
    WHEN t201.appln_auth in ('RU','SU') THEN t211rusu.publn_auth
    ELSE (select publn_auth from tls211_pat_publn t211 where t211.pat_publn_id = t201.earliest_pat_publn_id)
  end AS base_publn_auth,
  CASE 
    WHEN t201.appln_auth in ('RU','SU') THEN t211rusu.publn_nr
    ELSE (select publn_nr from tls211_pat_publn t211 where t211.pat_publn_id = t201.earliest_pat_publn_id)
  end AS base_publn_nr,
  CASE 
    WHEN t201.appln_auth in ('RU','SU') THEN t211rusu.publn_kind
    ELSE (select publn_kind from tls211_pat_publn t211 where t211.pat_publn_id = t201.earliest_pat_publn_id)
  end AS base_publn_kind

into tmp_base_publn_auths
FROM tls201_appln t201 
  LEFT JOIN (SELECT t211.appln_id, t211.publn_auth, t211.publn_nr, t211.publn_kind
              FROM 
              (SELECT appln_id, publn_auth, publn_nr, publn_kind, ROW_NUMBER() OVER (PARTITION BY appln_id ORDER BY publn_date DESC) rn 
                FROM tls211_pat_publn WHERE publn_date <> '9999-12-31') t211
              WHERE t211.rn = 1) t211rusu ON t211rusu.appln_id = t201.appln_id AND t201.appln_auth in ('RU','SU')
;
go

create index ndx_tmp_base_publn_auths on tmp_base_publn_auths(appln_id, base_publn_auth);
go


SELECT t201.appln_id,
  CASE 
    WHEN t201.appln_auth in ('RU','SU') THEN t211rusu.pat_publn_id
    ELSE t201.earliest_pat_publn_id
  end AS base_pat_publn_id
into tmp_base_pat_publn_ids
FROM tls201_appln t201
  LEFT JOIN (SELECT t211.appln_id, t211.pat_publn_id 
              FROM 
              (SELECT appln_id, pat_publn_id, ROW_NUMBER() OVER (PARTITION BY appln_id ORDER BY publn_date DESC) rn 
                FROM tls211_pat_publn WHERE publn_date <> '9999-12-31') t211
              WHERE t211.rn = 1) t211rusu ON t211rusu.appln_id = t201.appln_id AND t201.appln_auth in ('RU','SU')
;
go

create index ndx_tmp_base_pat_publn_ids on tmp_base_pat_publn_ids(appln_id, base_pat_publn_id);
go


select t.appln_id, IPC, CPC, applicants, inventors, base_publn_date, YEAR(base_publn_date) base_publn_year, base_pat_publn_id, '' appln_title
into tls208_appln_lists
from tls201_appln t
inner join tmp_ipcs i on t.appln_id = i.appln_id
inner join tmp_cpcs ñ on t.appln_id = ñ.appln_id
inner join tmp_applicants apl on t.appln_id = apl.appln_id
inner join tmp_inventors inv on t.appln_id = inv.appln_id
inner join tmp_base_publn_dates d on t.appln_id = d.appln_id
inner join tmp_base_pat_publn_ids p on t.appln_id = p.appln_id
--inner join tls202_appln_title at on t.appln_id = at.appln_id



go


  alter table tls208_appln_lists
add
  [appln_title] nvarchar(max),
  [appln_title_lg] varchar(2),
  [appln_title_en] nvarchar(max),
  [base_publn_auth] [char](2) NULL,
  [base_publn_nr] [varchar](20) NULL,
  [base_publn_kind] [char](2) NULL,
  [appln_auth] [char](2) NULL,
  [appln_nr] [varchar](20) NULL,
  [appln_kind] [char](2) NULL,
  [appln_date] [date] NULL
  ;

  UPDATE t208
  SET 
  t208.base_publn_auth = pba.base_publn_auth,
  t208.base_publn_nr = pba.base_publn_nr,
  t208.base_publn_kind = pba.base_publn_kind
  FROM tls208_appln_lists AS t208
  INNER JOIN tmp_base_publn_auths AS pba
  ON t208.appln_id = pba.appln_id
  ;

  UPDATE t208
  SET 
  t208.appln_auth = t201.appln_auth,
  t208.appln_nr = t201.appln_nr,
  t208.appln_kind = t201.appln_kind,
  t208.appln_date = t201.appln_filing_date
  FROM tls208_appln_lists AS t208
  INNER JOIN tls201_appln AS t201
  ON t208.appln_id = t201.appln_id
  ;

/*
UPDATE t208
  SET 
  t208.appln_title = t202.appln_title,
  t208.appln_title_lg = t202.lng
FROM tls208_appln_lists AS t208
INNER JOIN
(
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
 ) t202 
ON t208.appln_id = t202.appln_id
;
*/

/*
UPDATE t208 SET t208.appln_title = cast(t202.appln_title as nvarchar(max)) collate database_default, t208.appln_title_lg = 'ar' FROM tls208_appln_lists AS t208 INNER JOIN tls202_appln_title_ar t202 ON t208.appln_id = t202.appln_id;
go
UPDATE t208 SET t208.appln_title = cast(t202.appln_title as nvarchar(max)) collate database_default, t208.appln_title_lg = 'bg' FROM tls208_appln_lists AS t208 INNER JOIN tls202_appln_title_bg t202 ON t208.appln_id = t202.appln_id;
go
UPDATE t208 SET t208.appln_title = cast(t202.appln_title as nvarchar(max)) collate database_default, t208.appln_title_lg = 'cs' FROM tls208_appln_lists AS t208 INNER JOIN tls202_appln_title_cs t202 ON t208.appln_id = t202.appln_id;
go
UPDATE t208 SET t208.appln_title = cast(t202.appln_title as nvarchar(max)) collate database_default, t208.appln_title_lg = 'da' FROM tls208_appln_lists AS t208 INNER JOIN tls202_appln_title_da t202 ON t208.appln_id = t202.appln_id;
go
UPDATE t208 SET t208.appln_title = cast(t202.appln_title as nvarchar(max)) collate database_default, t208.appln_title_lg = 'de' FROM tls208_appln_lists AS t208 INNER JOIN tls202_appln_title_de t202 ON t208.appln_id = t202.appln_id;
go
UPDATE t208 SET t208.appln_title = cast(t202.appln_title as nvarchar(max)) collate database_default, t208.appln_title_lg = 'el' FROM tls208_appln_lists AS t208 INNER JOIN tls202_appln_title_el t202 ON t208.appln_id = t202.appln_id;
go
UPDATE t208 SET t208.appln_title = cast(t202.appln_title as nvarchar(max)) collate database_default, t208.appln_title_lg = 'en' FROM tls208_appln_lists AS t208 INNER JOIN tls202_appln_title_en t202 ON t208.appln_id = t202.appln_id where t202.appln_id not in (select appln_id from tls202_appln_title_ru) ;
go
UPDATE t208 SET t208.appln_title = cast(t202.appln_title as nvarchar(max)) collate database_default, t208.appln_title_lg = 'es' FROM tls208_appln_lists AS t208 INNER JOIN tls202_appln_title_es t202 ON t208.appln_id = t202.appln_id;
go
UPDATE t208 SET t208.appln_title = cast(t202.appln_title as nvarchar(max)) collate database_default, t208.appln_title_lg = 'et' FROM tls208_appln_lists AS t208 INNER JOIN tls202_appln_title_et t202 ON t208.appln_id = t202.appln_id;
go
UPDATE t208 SET t208.appln_title = cast(t202.appln_title as nvarchar(max)) collate database_default, t208.appln_title_lg = 'fr' FROM tls208_appln_lists AS t208 INNER JOIN tls202_appln_title_fr t202 ON t208.appln_id = t202.appln_id;
go
UPDATE t208 SET t208.appln_title = cast(t202.appln_title as nvarchar(max)) collate database_default, t208.appln_title_lg = 'hr' FROM tls208_appln_lists AS t208 INNER JOIN tls202_appln_title_hr t202 ON t208.appln_id = t202.appln_id;
go
UPDATE t208 SET t208.appln_title = cast(t202.appln_title as nvarchar(max)) collate database_default, t208.appln_title_lg = 'it' FROM tls208_appln_lists AS t208 INNER JOIN tls202_appln_title_it t202 ON t208.appln_id = t202.appln_id;
go
UPDATE t208 SET t208.appln_title = cast(t202.appln_title as nvarchar(max)) collate database_default, t208.appln_title_lg = 'ja' FROM tls208_appln_lists AS t208 INNER JOIN tls202_appln_title_ja t202 ON t208.appln_id = t202.appln_id;
go
UPDATE t208 SET t208.appln_title = cast(t202.appln_title as nvarchar(max)) collate database_default, t208.appln_title_lg = 'ko' FROM tls208_appln_lists AS t208 INNER JOIN tls202_appln_title_ko t202 ON t208.appln_id = t202.appln_id;
go
UPDATE t208 SET t208.appln_title = cast(t202.appln_title as nvarchar(max)) collate database_default, t208.appln_title_lg = 'lt' FROM tls208_appln_lists AS t208 INNER JOIN tls202_appln_title_lt t202 ON t208.appln_id = t202.appln_id;
go
UPDATE t208 SET t208.appln_title = cast(t202.appln_title as nvarchar(max)) collate database_default, t208.appln_title_lg = 'lv' FROM tls208_appln_lists AS t208 INNER JOIN tls202_appln_title_lv t202 ON t208.appln_id = t202.appln_id;
go
UPDATE t208 SET t208.appln_title = cast(t202.appln_title as nvarchar(max)) collate database_default, t208.appln_title_lg = 'nl' FROM tls208_appln_lists AS t208 INNER JOIN tls202_appln_title_nl t202 ON t208.appln_id = t202.appln_id;
go
UPDATE t208 SET t208.appln_title = cast(t202.appln_title as nvarchar(max)) collate database_default, t208.appln_title_lg = 'no' FROM tls208_appln_lists AS t208 INNER JOIN tls202_appln_title_no t202 ON t208.appln_id = t202.appln_id;
go
UPDATE t208 SET t208.appln_title = cast(t202.appln_title as nvarchar(max)) collate database_default, t208.appln_title_lg = 'pl' FROM tls208_appln_lists AS t208 INNER JOIN tls202_appln_title_pl t202 ON t208.appln_id = t202.appln_id;
go
UPDATE t208 SET t208.appln_title = cast(t202.appln_title as nvarchar(max)) collate database_default, t208.appln_title_lg = 'pt' FROM tls208_appln_lists AS t208 INNER JOIN tls202_appln_title_pt t202 ON t208.appln_id = t202.appln_id;
go
UPDATE t208 SET t208.appln_title = cast(t202.appln_title as nvarchar(max)) collate database_default, t208.appln_title_lg = 'ro' FROM tls208_appln_lists AS t208 INNER JOIN tls202_appln_title_ro t202 ON t208.appln_id = t202.appln_id;
go
UPDATE t208 SET t208.appln_title = cast(t202.appln_title as nvarchar(max)) collate database_default, t208.appln_title_lg = 'ru' FROM tls208_appln_lists AS t208 INNER JOIN tls202_appln_title_ru t202 ON t208.appln_id = t202.appln_id;
go
UPDATE t208 SET t208.appln_title = cast(t202.appln_title as nvarchar(max)) collate database_default, t208.appln_title_lg = 'sh' FROM tls208_appln_lists AS t208 INNER JOIN tls202_appln_title_sh t202 ON t208.appln_id = t202.appln_id;
go
UPDATE t208 SET t208.appln_title = cast(t202.appln_title as nvarchar(max)) collate database_default, t208.appln_title_lg = 'sk' FROM tls208_appln_lists AS t208 INNER JOIN tls202_appln_title_sk t202 ON t208.appln_id = t202.appln_id;
go
UPDATE t208 SET t208.appln_title = cast(t202.appln_title as nvarchar(max)) collate database_default, t208.appln_title_lg = 'sl' FROM tls208_appln_lists AS t208 INNER JOIN tls202_appln_title_sl t202 ON t208.appln_id = t202.appln_id;
go
UPDATE t208 SET t208.appln_title = cast(t202.appln_title as nvarchar(max)) collate database_default, t208.appln_title_lg = 'sr' FROM tls208_appln_lists AS t208 INNER JOIN tls202_appln_title_sr t202 ON t208.appln_id = t202.appln_id;
go
UPDATE t208 SET t208.appln_title = cast(t202.appln_title as nvarchar(max)) collate database_default, t208.appln_title_lg = 'sv' FROM tls208_appln_lists AS t208 INNER JOIN tls202_appln_title_sv t202 ON t208.appln_id = t202.appln_id;
go
UPDATE t208 SET t208.appln_title = cast(t202.appln_title as nvarchar(max)) collate database_default, t208.appln_title_lg = 'tr' FROM tls208_appln_lists AS t208 INNER JOIN tls202_appln_title_tr t202 ON t208.appln_id = t202.appln_id;
go
UPDATE t208 SET t208.appln_title = cast(t202.appln_title as nvarchar(max)) collate database_default, t208.appln_title_lg = 'uk' FROM tls208_appln_lists AS t208 INNER JOIN tls202_appln_title_uk t202 ON t208.appln_id = t202.appln_id;
go
UPDATE t208 SET t208.appln_title = cast(t202.appln_title as nvarchar(max)) collate database_default, t208.appln_title_lg = 'zh' FROM tls208_appln_lists AS t208 INNER JOIN tls202_appln_title_zh t202 ON t208.appln_id = t202.appln_id;
go
*/

UPDATE t208
  SET 
  t208.appln_title_en = cast(t202.appln_title as nvarchar(max)) collate database_default
FROM tls208_appln_lists AS t208
INNER JOIN tls202_appln_title_en t202
ON t208.appln_id = t202.appln_id
;

ALTER TABLE tls208_appln_lists    
ADD CONSTRAINT PK_tls208_appln_lists PRIMARY KEY CLUSTERED (appln_id); 
GO  


ALTER TABLE tls209_appln_ipc ADD ipc_brief AS left(ipc_class_symbol(4));
CREATE INDEX ndx_ipc_brief ON tls209_appln_ipc(ipc_brief);
go
create view ipc_brief_search as select appln_id, ipc_brief from tls209_appln_ipc;
go

ALTER TABLE tls224_appln_cpc ADD cpc_brief AS left(cpc_class_symbol(4));
CREATE INDEX ndx_cpc_brief ON tls224_appln_cpc(cpc_brief);
go
create view cpc_brief_search as select appln_id, cpc_brief from tls224_appln_cpc;
go
