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


update tls208_appln_lists
  set appln_title = (select apt from 
      (
      select appln_id, appln_title collate DATABASE_DEFAULT apt from tls202_appln_title_ar union  
      select appln_id, appln_title collate DATABASE_DEFAULT apt from tls202_appln_title_bg union  
      select appln_id, appln_title collate DATABASE_DEFAULT apt from tls202_appln_title_cs union  
      select appln_id, appln_title collate DATABASE_DEFAULT apt from tls202_appln_title_da union  
      select appln_id, appln_title collate DATABASE_DEFAULT apt from tls202_appln_title_de union  
      select appln_id, appln_title collate DATABASE_DEFAULT apt from tls202_appln_title_el union  
      select appln_id, appln_title collate DATABASE_DEFAULT apt from tls202_appln_title_en union  
      select appln_id, appln_title collate DATABASE_DEFAULT apt from tls202_appln_title_es union  
      select appln_id, appln_title collate DATABASE_DEFAULT apt from tls202_appln_title_et union  
      select appln_id, appln_title collate DATABASE_DEFAULT apt from tls202_appln_title_fr union  
      select appln_id, appln_title collate DATABASE_DEFAULT apt from tls202_appln_title_hr union  
      select appln_id, appln_title collate DATABASE_DEFAULT apt from tls202_appln_title_it union  
      select appln_id, appln_title collate DATABASE_DEFAULT apt from tls202_appln_title_ja union  
      select appln_id, appln_title collate DATABASE_DEFAULT apt from tls202_appln_title_ko union  
      select appln_id, appln_title collate DATABASE_DEFAULT apt from tls202_appln_title_lt union  
      select appln_id, appln_title collate DATABASE_DEFAULT apt from tls202_appln_title_lv union  
      select appln_id, appln_title collate DATABASE_DEFAULT apt from tls202_appln_title_nl union  
      select appln_id, appln_title collate DATABASE_DEFAULT apt from tls202_appln_title_no union  
      select appln_id, appln_title collate DATABASE_DEFAULT apt from tls202_appln_title_pl union  
      select appln_id, appln_title collate DATABASE_DEFAULT apt from tls202_appln_title_pt union  
      select appln_id, appln_title collate DATABASE_DEFAULT apt from tls202_appln_title_ro union  
      select appln_id, appln_title collate DATABASE_DEFAULT apt from tls202_appln_title_ru union  
      select appln_id, appln_title collate DATABASE_DEFAULT apt from tls202_appln_title_sh union  
      select appln_id, appln_title collate DATABASE_DEFAULT apt from tls202_appln_title_sk union  
      select appln_id, appln_title collate DATABASE_DEFAULT apt from tls202_appln_title_sl union  
      select appln_id, appln_title collate DATABASE_DEFAULT apt from tls202_appln_title_sr union  
      select appln_id, appln_title collate DATABASE_DEFAULT apt from tls202_appln_title_sv union  
      select appln_id, appln_title collate DATABASE_DEFAULT apt from tls202_appln_title_tr union  
      select appln_id, appln_title collate DATABASE_DEFAULT apt from tls202_appln_title_uk union  
      select appln_id, appln_title collate DATABASE_DEFAULT apt from tls202_appln_title_zh
      ) t202 where t202.appln_id = tls208_appln_lists.appln_id)
  ;

