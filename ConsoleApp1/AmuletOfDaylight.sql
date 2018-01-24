--  Troll Hunters: http://trollhunters.wikia.com/wiki/Trollhunters_Wiki , https://en.wikipedia.org/wiki/Trollhunters
--  :connect localhost
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

--  +---------+
--  | Defense |
--  +---------+
--  SQL Job to kill evil trolls and alert. 
--  Run every 5 minutes or less.
declare @count smallint, @msg nvarchar(max)
declare @username varchar(max), @sqltext nvarchar(max), @spid int, @clienthost nvarchar(max), @kill nvarchar(max) = '', @db nvarchar(50)

if object_id('tempdb..#xeAppErrors') is not null drop table #xeAppErrors

select data = convert(xml, event_data) 
into #xeAppErrors
from sys.fn_xe_file_target_read_file('xeAppErrors*xel','xeAppErrors*xem',null,null)
where event_data like '%"error_number"%>8134<%'
			
select	@count = count(*)
from	#xeAppErrors 
where	data.value('(event/@timestamp)[1]','datetime') > dateadd(mi,-5,getutcdate())

if @spid>50 --is_user_process
begin 
	select @kill = @kill + 'kill ' + convert(varchar(5), @spid) + ';'
	exec sp_executesql @kill
end

--  +-----------------------------+	
--  | How many hits can you take? |
--  +-----------------------------+
if @count>10
begin
	select	@username = data.value('(event/action[@name="username"]/value)[1]', 'varchar(max)') 
		   ,@sqltext = data.value('(event/action[@name="sql_text"]/value)[1]', 'nvarchar(max)') 
		   ,@spid = data.value('(event/action[@name="session_id"]/value)[1]', 'nvarchar(max)')
   		   ,@clienthost = data.value('(event/action[@name="client_hostname"]/value)[1]', 'nvarchar(max)')
		   ,@db = event_data.value('(event/data[@name="database_name"]/value)[1]', 'nvarchar(50)')
	from	#xeAppErrors 
	where	data.value('(event/@timestamp)[1]','datetime') > dateadd(mi,-5,getutcdate())

	set	@msg =	@@Servername	+char(13)+ 
				@kill			+char(13)+ 
				@db				+char(13)+ 
				@username		+char(13)+ 
				@clienthost		+char(13)+ 
				@sqltext
			
	exec msdb.dbo.sp_send_dbmail @recipients ='trollhunters@arcadia.net' --input your own email!
		,@subject = 'Trolls are attacking' --Alert: Divide by zero attack.
		,@body_format = 'html'
		,@body = @msg
end
else begin print 'Coast is clear.' end
go