--master
if exists (select 1 from sys.sql_logins where name='LoaderXL') drop login hiramXL;
create login hiramXL with password = '<redactted>'
alter login hiramXL enable
go 
drop user hiramXL;
go
create user hiramXL for login hiramXL
alter role dbmanager add member hiramXL

--hiramdw
drop user hiramXL;
create user hiramXL for login hiramXL
go
exec sp_addrolemember db_owner, hiramXL;
EXEC sp_addrolemember 'xlargerc', 'hiramXL'

grant view definition to public;
grant showplan to hiramXL;
grant connect to hiramXL
go 