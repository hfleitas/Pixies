--  Troll Hunters: http://trollhunters.wikia.com/wiki/Trollhunters_Wiki , https://en.wikipedia.org/wiki/Trollhunters
--  :connect localhost
--  By: Hiram Fleitas, hiramfleitas@hotmail.com. Special thx to Lowell Izaguirre for xevent.
go

--  +-------+
--  | Armor |
--  +-------+
if not exists (select * from [sys].[server_event_sessions] where [name] = 'AmuletOfDaylight')
begin
	create event session [AmuletOfDaylight] on server
		add event sqlserver.error_reported(
			action(  package0.event_sequence
					,package0.last_error
					,sqlserver.client_app_name
					,sqlserver.client_pid
					,sqlserver.client_hostname
					,sqlserver.database_id
					,sqlserver.database_name
					,sqlserver.nt_username
					,sqlserver.plan_handle
					,sqlserver.query_hash
					,sqlserver.query_plan_hash
					,sqlserver.session_id
					,sqlserver.session_nt_username
					,sqlserver.sql_text
					,sqlserver.username )
			where ([package0].[greater_than_equal_int64]([severity],(14)))
			)
		add target package0.event_file(set filename = N'AmuletOfDaylight.xel'
										  ,max_file_size=(5) --5MB
										  ,max_rollover_files=(5))
		with (max_memory = 5120 KB
			 ,event_retention_mode = allow_single_event_loss
			 ,max_dispatch_latency = 30 seconds
			 ,max_event_size = 0 KB
			 ,memory_partition_mode = none
			 ,track_causality = on
			 ,startup_state = on)
end
go --drop event session [AmuletOfDaylight] on server
alter event session [AmuletOfDaylight] on server state = start --stop
go

--  +---------+
--  | Defense |
--  +---------+
--  SQL Job to kill evil trolls and alert. Run every <=5 minutes.
declare  @count smallint
		,@body nvarchar(max)
		,@crlf char(2) = char(13)+char(10)
		,@username nvarchar(128)
		,@sqltext nvarchar(max)
		,@spid smallint = null
		,@clienthost nvarchar(128)
		,@kill nvarchar(max) = ''
		,@db nvarchar(128);
set nocount, quoted_identifier, ansi_nulls on;

if object_id('tempdb..#xeAppErrors') is not null drop table #xeAppErrors;

select	data = cast(event_data as xml)
into	#xeAppErrors
from	sys.fn_xe_file_target_read_file('AmuletOfDaylight*xel','AmuletOfDaylight*xem',null,null)
where	cast(event_data as xml).value('(event/data[@name="error_number"]/value)[1]', 'int') = 8134
and		cast(event_data as xml).value('(event/@timestamp)[1]','datetime') > dateadd(mi,-5,getutcdate());
			
select	@count = count(*) from	#xeAppErrors;
select	top 1 	
		@spid		= data.value('(event/action[@name="session_id"]/value)[1]', 'smallint')
	   ,@username	= data.value('(event/action[@name="username"]/value)[1]', 'nvarchar(128)')
	   ,@clienthost	= data.value('(event/action[@name="client_hostname"]/value)[1]', 'nvarchar(128)')
	   ,@db			= data.value('(event/action[@name="database_name"]/value)[1]', 'nvarchar(128)')
	   ,@sqltext	= data.value('(event/action[@name="sql_text"]/value)[1]', 'nvarchar(max)')
from	#xeAppErrors 
where	data.value('(event/data[@name="error_number"]/value)[1]', 'int') = 8134
and		data.value('(event/@timestamp)[1]','datetime') > dateadd(mi,-5,getutcdate());

--  +-----------------------------+	
--  | How many hits can you take? |
--  +-----------------------------+
if @count > 10 and @spid > 50 
begin
	if exists(select session_id from sys.dm_exec_sessions where session_id=@spid) 
	begin 
		select @kill =	@kill + 'kill ' + convert(varchar(5), @spid) + ';';
		--exec sp_executesql @kill;
		print @kill
	end

	select @body = 
	N'svr: '	+ @@servername	+ @crlf +
	N'run: '	+ @kill			+ @crlf + 
	N'host: '	+ @clienthost	+ @crlf + 
	N'user: '	+ @username		+ @crlf + 
	N'db: '		+ @db			+ @crlf + 
	N't-sql: '	+ @sqltext		+ @crlf 

	exec msdb.dbo.sp_send_dbmail @recipients ='hf0524@universalproperty.com' --input your own email!
		,@subject = 'Trolls are attacking' --Alert: Divide by zero attack.
		,@body = @body;
end
else begin print 'Coast is clear.' end
go
if object_id('tempdb..#xeAppErrors') is not null drop table #xeAppErrors
go
