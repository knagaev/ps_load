use patscape

-- 1
select appln_year, count(*)
from 
appln_search aps
where
aps.appln_id in (select appln_id from FN_SEARCH_FORMSOF_FT_TLS_203 (N'красный, лазер', N'and'))
--or aps.appln_id in (select appln_id from FN_SEARCH_FORMSOF_FT_TLS_203 (N'шлифовальная, машина', N'and'))
--or aps.appln_id in (select appln_id from FN_SEARCH_FORMSOF_FT_TLS_203 (N'умный, дом', N'and'))
group by appln_year
order by appln_year;

-- 2
select appln_auth, count(*)
from 
appln_search aps
where 
(aps.appln_id in (select appln_id from FN_SEARCH_FORMSOF_FT_TLS_203 (N'красный, лазер', N'and'))
--or aps.appln_id in (select appln_id from FN_SEARCH_FORMSOF_FT_TLS_203 (N'шлифовальная, машина', N'and'))
--or aps.appln_id in (select appln_id from FN_SEARCH_FORMSOF_FT_TLS_203 (N'умный, дом', N'and'))
)
--and appln_year in ('2011', '1996', '2007')
and appln_year in ('2011')
group by appln_auth
order by appln_auth;

-- 3
select aps.appln_id, IPC_brief--, count(*)
from 
appln_search aps inner join ipc_brief_search ibs ON ibs.appln_id=aps.appln_id
where
(aps.appln_id in (select appln_id from FN_SEARCH_FORMSOF_FT_TLS_203 (N'красный, лазер', N'and'))
--or aps.appln_id in (select appln_id from FN_SEARCH_FORMSOF_FT_TLS_203 (N'шлифовальная, машина', N'and'))
--or aps.appln_id in (select appln_id from FN_SEARCH_FORMSOF_FT_TLS_203 (N'умный, дом', N'and'))
)
--and appln_year in ('2011', '1996', '2007') AND appln_auth in ('RU','UA')
and appln_year in ('2011') AND appln_auth in ('RU')
group by IPC_brief
order by count(*) desc;

select CPC_brief, count(*)
from 
appln_search aps inner join cpc_brief_search ibs ON ibs.appln_id=aps.appln_id
where
(aps.appln_id in (select appln_id from FN_SEARCH_FORMSOF_FT_TLS_203 (N'красный, лазер', N'and'))
--or aps.appln_id in (select appln_id from FN_SEARCH_FORMSOF_FT_TLS_203 (N'шлифовальная, машина', N'and'))
--or aps.appln_id in (select appln_id from FN_SEARCH_FORMSOF_FT_TLS_203 (N'умный, дом', N'and'))
)
--and appln_year in ('2011', '1996', '2007') AND appln_auth in ('RU','UA')
and appln_year in ('2011') AND appln_auth in ('RU')
group by CPC_brief
order by count(*) desc;

select * from tls207_pers_appln where appln_id = 375902491;
--4
select DISTINCT
      totalResults=COUNT(t208.appln_id) OVER()
      ,t208.appln_id AS id
      ,t208.base_publn_auth AS strana
      ,t208.base_publn_nr AS PubN
      ,t208.base_publn_kind AS objectType
      ,t208.appln_title AS title
      ,t208.base_publn_date AS date
      ,t208.appln_nr AS ApplNum
      ,t208.IPC AS IPC
      ,t208.CPC AS CPC
      ,t208.applicants AS applicants
      ,t208.inventors AS inventors
    ,(select appln_abstract from all_abstracts where appln_id = t208.appln_id) as abstract
from 
appln_search aps inner join ipc_brief_search ibs ON ibs.appln_id=aps.appln_id
inner join tls208_appln_lists t208 ON t208.appln_id=aps.appln_id
where
(aps.appln_id in (select appln_id from FN_SEARCH_FORMSOF_FT_TLS_203 (N'красный, лазер', N'and'))
--or aps.appln_id in (select appln_id from FN_SEARCH_FORMSOF_FT_TLS_203 (N'шлифовальная, машина', N'and'))
--or aps.appln_id in (select appln_id from FN_SEARCH_FORMSOF_FT_TLS_203 (N'умный, дом', N'and'))
)
--and appln_year in ('2011', '1996', '2007') AND aps.appln_auth in ('RU','UA') AND IPC_brief in ('B24B','B02B')
and appln_year in ('2011') AND aps.appln_auth in ('RU') AND IPC_brief in ('F03G')
ORDER BY PubN ASC OFFSET 0 ROWS FETCH NEXT 50 ROWS ONLY;


select DISTINCT
      totalResults=COUNT(t208.appln_id) OVER()
      ,t208.appln_id AS id
      ,t208.base_publn_auth AS strana
      ,t208.base_publn_nr AS PubN
      ,t208.base_publn_kind AS objectType
      ,t208.appln_title AS title
      ,t208.base_publn_date AS date
      ,t208.appln_nr AS ApplNum
      ,t208.IPC AS IPC
      ,t208.CPC AS CPC
      ,t208.applicants AS applicants
      ,t208.inventors AS inventors
    ,(select appln_abstract from all_abstracts where appln_id = t208.appln_id) as abstract
from 
tls208_appln_lists t208 inner JOIN tls211_pat_publn t211 ON t208.appln_id=t211.appln_id
where t211.publn_nr='2540382'
ORDER BY PubN ASC OFFSET 0 ROWS FETCH NEXT 50 ROWS ONLY

