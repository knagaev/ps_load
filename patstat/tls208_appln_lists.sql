--Таблица tls208_appln_lists (раньше называлась tls208_appln_lists_new1) используется для выдачи пользователю списка найденных документов 
-- с краткой библиографией для каждого из них (номер заявки, дата подачи заявки, базовая публикация, МПК, CPC, 
--перечень авторов и заявителей, название изобретения). 
-- Нигде кроме выдачи хит-листа и добавления в неё записей при загрузке новых документов эта таблица не используется.
 
--Формируется она с помощью представлений v_tls208_appln_lists и v_tls208_appln_title:
 
CREATE VIEW [dbo].[v_tls208_appln_lists]
AS
      SELECT appln_id, 
            dbo.IPC_list(appln_id) AS IPC, 
            dbo.CPC_list(appln_id) AS CPC, 
            dbo.applicants_list(appln_id) AS applicants, 
            dbo.inventors_list(appln_id) AS inventors, 

            dbo.base_publn_auth(appln_id) AS base_publn_auth, 
            dbo.base_publn_nr(appln_id) AS base_publn_nr, 
            dbo.base_publn_kind(appln_id) AS base_publn_kind, 

            dbo.base_publn_date(appln_id) AS base_publn_date, 
            dbo.base_pat_publn_id(appln_id) AS base_pat_publn_date, 
            appln_auth, 
            appln_nr, 
            appln_kind, 
            appln_filing_date, 
            '' AS appln_title ---- временно название изобретения делаем пустым, потом его заполним, 
                              -- т.к. нам нужны ВСЕ заявки из таблицы tls201_appln вне зависимости 
                              -- от наличия или отсутствия названия изобретения в таблице tls202_appln_title
                              ---- (INNER JOIN не годится), а использование LEFT JOIN сильно тормозит
      FROM dbo.tls201_appln
GO
 
 
CREATE VIEW [dbo].[v_tls208_appln_title]
AS
      SELECT dbo.tls202_appln_title.appln_id, 
             dbo.tls208_appln_lists_new1.appln_title AS appln_title_dest, 
             dbo.tls202_appln_title.appln_title AS appln_title_source
      FROM dbo.tls208_appln_lists_new1 
            INNER JOIN dbo.tls202_appln_title 
                  ON dbo.tls208_appln_lists_new1.appln_id = dbo.tls202_appln_title.appln_id
 
GO
 
 
 
 
insert into tls208_appln_lists select * from [dbo].[v_tls208_appln_lists]
GO
 
update [dbo].[v_tls208_appln_title] set appln_title_dest=appln_title_source
 
GO
 
 
 
 
 
-- В принципе, её в виде таблицы можно и не создавать, а использовать представление, если бы не требование к производительности.
 
-- Функции, используемые здесь, привожу ниже (они формируют списки МПК, CPC, авторов и заявителей, 
-- а также определяют базовую публикацию - последнюю по дате для российских документов и первую для иностранных).
 
/****************************************************************************/

select appln_id, IPC = stuff((select '; ' + ipc_class_symbol as [text()]
            from tls209_appln_ipc xt
            where xt.appln_id = t.appln_id order by ipc_position desc
            for xml path('') ), 1, 2, '')
      from tls209_appln_ipc t
      group by t.appln_id

CREATE function [dbo].[IPC_list](@appln_id int) returns varchar(MAX)
as begin
       declare @result varchar(MAX)
       set @result=''
       declare c cursor for select ipc_class_symbol, ipc_position from tls209_appln_ipc where appln_id=@appln_id order by ipc_position asc
       declare @ipc_class_symbol varchar(15), @ipc_position char(1)
 
 
       open c
 
       
       fetch next from c into @ipc_class_symbol, @ipc_position
       while @@FETCH_STATUS=0
       begin
 
                    
             
             set @result=@result+replace(@ipc_class_symbol,' ','')
             +'; '
             fetch next from c into @ipc_class_symbol, @ipc_position     
       end
       close c deallocate c
       
       if @result like '%; ' set @result=left(@result, len(@result)-1)
       
 
       return @result
 
end
 
 
go
 
 
 
/****************************************************************************/

select appln_id, CPC = stuff((select '; ' + cpc_class_symbol as [text()]
            from tls224_appln_cpc xt
            where xt.appln_id = t.appln_id order by cpc_position desc
            for xml path('') ), 1, 2, '')
      from tls224_appln_cpc t
      group by t.appln_id
 
CREATE function [dbo].[CPC_list](@appln_id int) returns varchar(MAX)
as begin
       declare @result varchar(MAX)
       set @result=''
       declare c cursor for select cpc_class_symbol, cpc_position from tls224_appln_cpc where appln_id=@appln_id order by cpc_position asc
       declare @cpc_class_symbol varchar(15), @cpc_position char(1)
 
 
       open c
 
       
       fetch next from c into @cpc_class_symbol, @cpc_position
       while @@FETCH_STATUS=0
       begin
 
                    
             
             set @result=@result+replace(@cpc_class_symbol,' ','')+
             +'; '
             fetch next from c into @cpc_class_symbol, @cpc_position     
       end
       close c deallocate c
       
       if @result like '%; ' set @result=left(@result, len(@result)-1)
       
 
       return @result
 
end
 
 
GO
 
 
/****************************************************************************/

select appln_id, 
        applicants = stuff((select '; ' + person_name as [text()]
          from tls206_person xt
          where xt.person_id = t.person_id order by applt_seq_nr desc
          for xml path('') ), 1, 2, '')
from tls207_pers_appln t
  inner join tls206_person p
    on t.person_id = p.person_id
where t.applt_seq_nr > 0
group by t.appln_id
 
CREATE function [dbo].[applicants_list](@appln_id int) returns varchar(MAX)
as begin
       declare @result varchar(MAX)
       set @result=''
       declare c cursor for select person_id from tls207_pers_appln where appln_id=@appln_id and applt_seq_nr>0  order by applt_seq_nr
 
       open c
 
       declare @person_id int
       fetch next from c into @person_id
       while @@FETCH_STATUS=0
       begin
             set @result=@result+(select person_name from tls206_person where person_id=@person_id)+'; '
             fetch next from c into @person_id 
       end
       close c deallocate c
       set @result=rtrim(@result)
       if @result like '%;' set @result=left(@result, len(@result)-1)
       
 
       return @result
 
end
 
 
GO
 
/****************************************************************************/

select appln_id, 
        applicants = stuff((select '; ' + person_name as [text()]
          from tls206_person xt
          where xt.person_id = t.person_id order by invt_seq_nr desc
          for xml path('') ), 1, 2, '')
from tls207_pers_appln t
  inner join tls206_person p
    on t.person_id = p.person_id
where t.invt_seq_nr > 0
group by t.appln_id
 
 
CREATE function [dbo].[inventors_list](@appln_id int) returns varchar(MAX)
as begin
       declare @result varchar(MAX)
       set @result=''
       declare c cursor for select person_id from tls207_pers_appln where appln_id=@appln_id and invt_seq_nr>0  order by invt_seq_nr
 
       open c
 
       declare @person_id int
       fetch next from c into @person_id
       while @@FETCH_STATUS=0
       begin
             set @result=@result+(select person_name from tls206_person where person_id=@person_id)+'; '
             fetch next from c into @person_id 
       end
       close c deallocate c
       set @result=rtrim(@result)
       if @result like '%;' set @result=left(@result, len(@result)-1)
       
 
       return @result
 
end
 
 
GO
 
/****************************************************************************/
 
select max(publn_date)
from tls211_pat_publn
where publn_date <> '9999-12-31'
group by appln_id

create function [dbo].[last_Publn_date](@appln_id int) returns date as begin
return (select top 1 publn_date from tls211_pat_publn where appln_id=@appln_id 
       
       
       and publn_date<>'9999-12-31'  ---- чтобы исключить "фиктивные записи" с пустой (NOT NULL по умолчанию 9999-12-31) датой в случае, если есть нефиктивные
       
       
       order by publn_date desc)
end
 
 
GO
/****************************************************************************/
 
 
create function [dbo].[last_Publn_id](@appln_id int) returns int as begin
return (select top 1 pat_publn_id from tls211_pat_publn where appln_id=@appln_id 
       
       
       and publn_date<>'9999-12-31'  ---- чтобы исключить "фиктивные записи" с пустой (NOT NULL по умолчанию 9999-12-31) датой в случае, если есть нефиктивные
       
       
       order by publn_date desc)
end
 
GO
