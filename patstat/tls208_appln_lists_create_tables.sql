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

update tls208_appln_lists
  set appln_title = (select appln_title from 
      (
      select appln_id, appln_title from tls202_appln_title_ar union all 
      select appln_id, appln_title from tls202_appln_title_bg union all 
      select appln_id, appln_title from tls202_appln_title_cs union all 
      select appln_id, appln_title from tls202_appln_title_da union all 
      select appln_id, appln_title from tls202_appln_title_de union all 
      select appln_id, appln_title from tls202_appln_title_el union all 
      select appln_id, appln_title from tls202_appln_title_en union all 
      select appln_id, appln_title from tls202_appln_title_es union all 
      select appln_id, appln_title from tls202_appln_title_et union all 
      select appln_id, appln_title from tls202_appln_title_fr union all 
      select appln_id, appln_title from tls202_appln_title_hr union all 
      select appln_id, appln_title from tls202_appln_title_it union all 
      select appln_id, appln_title from tls202_appln_title_ja union all 
      select appln_id, appln_title from tls202_appln_title_ko union all 
      select appln_id, appln_title from tls202_appln_title_lt union all 
      select appln_id, appln_title from tls202_appln_title_lv union all 
      select appln_id, appln_title from tls202_appln_title_nl union all 
      select appln_id, appln_title from tls202_appln_title_no union all 
      select appln_id, appln_title from tls202_appln_title_pl union all 
      select appln_id, appln_title from tls202_appln_title_pt union all 
      select appln_id, appln_title from tls202_appln_title_ro union all 
      select appln_id, appln_title from tls202_appln_title_ru union all 
      select appln_id, appln_title from tls202_appln_title_sh union all 
      select appln_id, appln_title from tls202_appln_title_sk union all 
      select appln_id, appln_title from tls202_appln_title_sl union all 
      select appln_id, appln_title from tls202_appln_title_sr union all 
      select appln_id, appln_title from tls202_appln_title_sv union all 
      select appln_id, appln_title from tls202_appln_title_tr union all 
      select appln_id, appln_title from tls202_appln_title_uk union all 
      select appln_id, appln_title from tls202_appln_title_zh
      ) t202 where t202.appln_id = tls208_appln_lists.appln_id)
  ;
go