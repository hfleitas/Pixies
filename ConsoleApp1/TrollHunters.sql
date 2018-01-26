--  Troll Hunters: http://trollhunters.wikia.com/wiki/Trollhunters_Wiki , https://en.wikipedia.org/wiki/Trollhunters
--  :connect localhost
--  :connect TrollHunters
--  By: Hiram Fleitas, hiramfleitas@hotmail.com. Special thx to Andy and Dmitri.
go

--  +------+
--  | Lore |
--  +------+
if db_id(N'ᕙ༼,இܫஇ,༽ᕗ') is not null --drop/create db 
begin
	alter database [ᕙ༼,இܫஇ,༽ᕗ] set single_user with rollback immediate 
	drop database [ᕙ༼,இܫஇ,༽ᕗ] end
else begin 
	create database [ᕙ༼,இܫஇ,༽ᕗ]
	on primary (name='TrollHunters',filename='C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\TrollHunters.mdf', size=64MB, maxsize=unlimited, filegrowth=64MB) --S:\SQLDATA\, C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\
	log on (name='TrollHunters_log',filename='C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\TrollHunters_log.ldf', size=8MB, filegrowth=64MB) --L:\SQLLOGS\, C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\
end	
go

use [ᕙ༼,இܫஇ,༽ᕗ]
go 
create table [Character] ( 
	CharacterId		int identity(1,1)	not null,
    FullName		varchar(50)			not null,
	Affiliation		varchar(60)			null, 
	Category		varchar(10)			null, 
	Aka				varchar(300)		null, --*
	[Status]		varchar(35)			null,
	Race			varchar(50)			null,
	Age				int					null,
	Home			varchar(50)			null,
	Relatives		varchar(300)		null, --*
	Weapons			varchar(100)		null, --*
	EyeColor		varchar(20)			null,
	HairColor		varchar(50)			null,
	Minions			varchar(100)		null,
	VoicedBy		varchar(50)			null,
	constraint pk_Character primary key clustered (CharacterId asc));
go
create table [Locations] ( LocationId int identity(1,1) not null, LocationName varchar(50), CharacterId int foreign key references [Character](CharacterId), constraint pk_Locations primary key clustered (LocationId asc));
--create table Aka (AkaId int identity(1,1) not null, Aka varchar(50), CharacterId int foreign key references [Character](CharacterId), ByCharacterId int foreign key references [Character](CharacterId), constraint pk_Aka primary key clustered (AkaId asc));
--create table Relatives (RelativeId int identity(1,1) not null, CharacterId int foreign key references [Character](CharacterId), RelativeCharacterId int foreign key references [Character](CharacterId), Relation varchar(50), constraint pk_Relative primary key clustered (RelativeId asc));
--create table Weapons (WeaponId int identity(1,1) not null, CharacterId int foreign key references [Character](CharacterId), WeaponName varchar(50), [Type] varchar(20), Origin varchar(20), constraint pk_Weapons primary key clustered (WeaponId asc));
--create table WeaponUser (WeaponUserId int identity(1,1) not null, CharacterId int foreign key references [Character](CharacterId), Occurrance varchar(50), Victims varchar(50), constraint pk_WeaponUser primary key clustered (WeaponUserId asc)); 
go
create table [Episode] ( 
    CharacterId		int           not null,
    FullName		nvarchar(64)  not null,
    VoicedBy		nvarchar(64)  not null,
	BirthYear		int			  not null, 
	Category		nvarchar(64)  not null,
	[Status]		nvarchar(64)  not null,
    Age				int			  not null
    constraint PK_Episode primary key clustered (CharacterId asc));
go
set identity_insert [Character] on; --drop table [Character] 
	insert into [Character] (CharacterId, FullName, Affiliation, Category, Aka, [Status], Race, Age, Home, Relatives, Weapons, EyeColor, HairColor, Minions, VoicedBy) values 
	 (1,'Jim Lake Jr.','Good','Hero','Young Atlas, Jimbo, Master Jim, Fleshbag, Jim "Fake" Jr., Jimmy Jam, Little Gynt','Alive','Human',16,'Arcadia Oaks','Jim Lake Sr., Barbara Lake, Claire Nuñez','Sword of Daylight, Sword of Eclipse','Blue','Black','Toby Domzalski','Anton Yelchin')
	,(2,'Claire Maria Nuñez','Good (cursed by overpowering the shadow staff)','Hero','C-bomb, Shadowdancer','Alive','Human',15,'Arcadia','Mr. Nuñez, Mrs. Nuñez, Baby Enrique, Jim Lake Jr.','Shadow Staff','Brown','Black with white and purple streaks','NotEnrique','Lexi Medrano')
	,(3,'Gunmar the Black','Evil, Gumm-Gumm Army, The Janus Order','Villain','Dark Underlord, Skullcrusher','Alive','Gumm-Gumm',null,'Darklands, Trollmarket','Bular','Decimaar Blade','Blue','Black','Otto Scaarbach, Stricklander, Nomura, Gladys, NotEnrique, Stalklings, Various Changeling Trolls','Clancy Brown')
	,(4,'Ararghaumont','Gunmar, Heartstone Trollmarket, Trollhunters','Hero','AAARRRGGHH!!!, Wingman','Alive','Krubera Troll',null,'Deep Caverns, Heartstone Trollmarket',null,'Fists and Strength','Green','Dark green',null,'Fred Tatasciore')
	,(5,'Stricklander','Gunmar, The Janus Order, Bular, Barbara Lake, Jim','Villain','Strikler, Impure, Boss man','Alive','Changeling Troll',null,'Arcadia','Walter Strickler','Knives','Green','Black','NotEnrique, Angor Rot, Antamonstrum, Gladys, Goblins, Fragwa','Jonathan Hyde')
	,(6,'Angor Rot',null,'Villain',null,'Deceased','Troll',null,null,'his village','Shadow Staff, Creeper Sun Blade, Sword of Daylight','Yellow, White',null,'Pixies','Ike Amadi')
	,(7,'Zelda Nomura','The Janus Order, Gunmar, Bular, Stricklander','Villain','Impure, Nomura','Alive','Changeling',null,'Arcadia Oaks',null,'Dual-Khopesh','Green','Black',null,'Lauren Tom')
	,(8,'Draal the Deadly','Good','Hero',null,'Cursed by Gunmar''s Decimer Blade','Troll',null,'Heartstone Trollmarket','Kanjigar','Fists','Yellow and Red',null,null,'Matthew Waterson')
	,(9,'Morgana','Herself','Villain','Argante, Lady Pale, Eldritch Queen, Baba Yaga','Alive',null,null,'Forests of the Black Sea, Bulgaria',null,'Sorcery',null,'Gray','Angor Rot','Lena Headey')
	,(10,'Blinkous Galadrigal','Good','Hero','Blinky','Alive','Troll',600,'Heartstone Trollmarket','Dictatious Maximus Galadrigal',null,'Brown','Blue',null,'Kelsey Grammer')
	,(11,'Bular','Evil','Villain','Son of Gunmar','Deceased','Gumm-Gumm',null,'Darklands','Gunmar','Sword, Horns','Orange',null,'Changeling Trolls, NotEnrique, Nomura, Otto Scaarbach, Gladys, Customs Agent, Stalkling','Ron Perlman')
	,(12,'Dictatious Maximus Galadrigal','Bad','Villain',null,'Alive','Troll',4999,'Trollmarket, Darklands','Blinky',null,null,null,'Draal the Deadly (possessed by Gunmar), Gumm-Gumm Warriors, Krubera Warriors','Mark Hamill')
	,(13,'Tobias Domzalski','Good','Hero','Tobes, Toby-Pie, Wingman, T.P., Dumbzalski','Alive','Human',15,'Arcadia','Nana, Mr. Domzalski, Mrs. Domzalski','Warhammer, Glamour Mask','Green','Brown',null,'Charlie Saxton')
	,(14,'Usurna','Gumm-Gumm','Villain',null,'Alive','Krubera',null,null,null,'Poison Knives',null,null,'Krubera soldiers, Krax','Anjelica Huston')
	,(15,'Elijah Leslie Pepperjack','Good, Creepslayerz','Hero','Eli Pepperjack','Alive','Human',15,'Arcadia',null,'Mace, shurikens, umbrellas','Green','Black',null,'Cole Sand')
	,(16,'Steve Palchuk','Neutral, Good, Creepslayerz, The Trollhunters','Ally',null,'Alive','Human',16,'Arcadia',null,'His fists','Brown','Light brown','Various jocks','Steven Yeun')
	-- http://trollhunters.wikia.com/wiki/Category:Characters?page=2
	,(17,'Vendel','Good','Hero',null,'Deceased','Troll',9000,'Heartstone Trollmarket','Rundle, Kilfred','Staff','White','Grayish brown',null,'Victor Raider-Wexler')
	,(18,'Kanjigar the Courageous','Good','Hero',null,'Dead','Troll',null,'The Void, The Hero''s Forge', 'Draal','Sword of Daylight','Yellow',null,null,'James Purefoy')
	,(19,'Merlin','Good',null,null,null,'Wizard',null,'Camelot',null,'Sorcery',null,null,'Trollhunters','David Bradley')
	,(20,'Jim Lake Sr.',null,null,null,null,'Human',null,null,'Jim Lake Jr., Barbara Lake',null,'Green','Black',null,null)
	,(21,'Otto Scaarbach','Gunmar, The Janus Order','Villain','Otto, Mr. Evilman','Deceased','Changeling',null,null,null,'Polymorph abilities','Blue','Black','Goblins, Lower-ranking Changelings, NotEnrique','Tom Kenny')
	,(22,'Gladysgro','Gunmar, Bular, The Janus Order, Stricklander','Villain','Gladys','Deceased','Changeling',null,'Arcadia',null,'Dental tools','Blue','Brown',null,'Melanie Paxson')
	,(23,'Darci Scott','Good','Ally',null,'Alive','Human',15,'Arcadia',null,null,'Brown','Brown','Mary Wang','Yara Shahidi')
	,(24,'Mary J. Wang','Good','Hero','Maria, Mare','Alive','Human',15,'Arcadia',null,null,'Brown','Black',null,'Lauren Tom')
	,(25,'Deya the Deliverer','Good','Hero','Deya "The Deliverer"','Dead','Troll',null,'The Void, The Hero''s Forge',null,'Sword of Daylight',null,null,null,null)
	,(26,'Unkar the Unfortunate','Good','Hero',null,'Deceased','Troll',null,'The Void, The Hero''s Forge',null,'Sword of Daylight',null,null,null,'Wallace Shawn')
	,(27,'Barbara Lake','Good','Hero',null,'Alive','Human',null,'Arcadia Oaks','Jim Lake Jr.',null,'Blue','Brown',null,'Amy Landecker')
	,(28,'Enrique Nuñez','Good',null,'Baby Enrique','Alive','Human',1,'Arcadia Oaks, Darklands','Claire Nuñez, Mr. Nuñez, Mrs. Nuñez',null,null,'Blonde',null,null)
	,(29,'Gnome Chompsky','Good','Hero',null,'Alive','Gnome',null,'Hearstone Trollmarket, Toby''s dollhouse','Space Girldoll','Teeth',null,null,null,null)
	,(30,'Waltolemew Strickler','Good',null,'Baby Strickler','Alive','Human',1,'Darklands',null,null,'Green','Brown',null,null)
	,(31,'Goblins','Gumm-Gumm','Villain',null,'Alive','Trolls',null,'Arcadia','Large groups, Teeth',null,null,'Blue, Green',null,null)
	-- http://trollhunters.wikia.com/wiki/Category:Characters?page=3
	,(32,'Gatto','Neutral',null,null,'Alive','Volcanic Troll',null,'Argentina',null,'Lava, His Stomach',null,null,null,null)
	,(33,'Señor Uhl',null,'Teacher','Uhl the unforgiving','Alive','Human',38,'Arcadia',null,null,null,'Blonde',null,'Fred Tatasciore')
	,(34,'Shannon Longhannon','Good','Ally',null,'Alive','Human',15,'Arcadia',null,null,'Blue','Brown',null,'Bebe Wood')
	,(35,'Wumpa','Quagawumps','Ally',null,'Alive','Quagawump Troll',null,'Swamps of Florida','Blungo, Quagawumps','Spears','Green','Green','Quagawumps',null)
	,(36,'Nyarlagroth','Gumm-Gumm','Bad',null,'Deceased','Huge Black Snake',null,'Darklands',null,'Large horns, Thick scales, Teeth, Tongues',null,null,null,null)
	,(37,'Mrs. Nuñez',null,null,'Mom','Alive','Human',null,'Arcadia','Claire Nuñez, Enrique Nuñez, Mr. Nuñez','Politics, Soy Sausage','Brown','Black',null,'Andrea Navedo')
	,(38,'Mr. Nuñez',null,null,'Dad','Alive','Human',null,'Arcadia','Claire Nuñez, Enrique Nuñez, Mrs. Nuñez','BBQ','Brown','Black',null,'Tom Kenny')
	,(39,'Bagdwella','Good',null,null,'Alive','Troll',null,'Heartstone Trollmarket',null,null,'Orange','Red',null,'Fred Tatasciore')
	,(40,'Coach Lawrence',null,'Teacher','Coach','Alive','Human',56,'Arcadia',null,null,'Blue','Black',null,'Tom Wilson')
	,(41,'Gnomes','Thieves',null,'Scum of the earth','Alive','Gnome',null,'Hearstone Trollmarket',null,'Speed, Size, Teeth',null,null,null,null)
	,(42,'The Pixies','Bad',null,null,'Alive','Pixies',null,'Container',null,'Size, Speed, Hallucination',null,null,null,null)
	,(43,'Blood Goblins','Gumm-Gumm','Villain',null,'Alive','Trolls',null,'Draklands, Arcadia','Large groups, Teeth',null,null,'White',null,null)
	,(44,'Nana','Good',null,null,'Alive','Human',null,'Arcadia','Toby Domzalski','Lack of sight','Blue','Gray',null,null);
set identity_insert [Character] off;
go 
set identity_insert [Locations] on; --drop table [Locations] 
	insert into Locations (LocationId, LocationName, CharacterId) values
	(1,'Arcadia Oaks High', 5)
	,(2,'Arcadia Oaks High', 40)
	,(3,'Arcadia Oaks High', 33)
	,(4,'Arcadia Oaks High', 1)
	,(5,'Arcadia Oaks High', 13)
	,(6,'Arcadia Oaks High', 2)
	,(7,'Arcadia Oaks High', 16)
	,(8,'Arcadia Oaks High', 15)
	,(9,'Arcadia Oaks High', 24)
	,(10,'Arcadia Oaks High', 23)
	,(11,'Arcadia Oaks High', 34);
set identity_insert Locations off;
go 
insert	[Episode] --drop table [Episode] 
select	c.CharacterId, FullName, VoicedBy, year(dateadd(year,-age,getdate())), Category, [Status], Age 
from	[Character] c 
join	[Locations] l on c.CharacterId=l.CharacterId 
and		c.Race='Human'
and		l.LocationName='Arcadia Oaks High'
order by c.CharacterId;
go

--  +-----------------------------+------------------------------------------------+
--  | Angor spies on Trollhunters | Summon SHARK ! Kernel prevents local-to-local. |
--  +-----------------------------+------------------------------------------------+
--  :connect TrollHunters
select	'Angor spies on Jim and friends', getdate(), * 
from	dbo.[Character] c 
join	[Locations] l on c.CharacterId=l.CharacterId 
and		c.Race='Human'
and		l.LocationName='Arcadia Oaks High';
go

--  +---------------------------------------------+-------------------------------------------------------------------------------+
--  | Angor releases Pixies, goes in for the kill | Release Pixies c# console app. 1101100000111011000010000001100011100111001000 |
--  +---------------------------------------------+-------------------------------------------------------------------------------+
--  :connect Pixes10101
use [ᕙ༼,இܫஇ,༽ᕗ];
select 'Angor releases the Pixies', getdate(), * from dbo.Episode;
go
select 'Angor goes in for the kill', getdate(), * 
from	dbo.[Character] c 
join	Locations l on c.CharacterId=l.CharacterId 
and		c.Race='Human'
and		l.LocationName='Arcadia Oaks High';
go

--  +----------------+
--  | Toby saves Jim |
--  +----------------+
--  Turn on Force Encryption, with Certificate. Restart mssql svc.
--  no more hallucinations. Jim and Toby kick Angor's butt and save Arcadia.
--  :connect Pixes10101
drop login angor
go

--  +----------+
--  | Lore DDM |
--  +----------+
--  :connect localhost
use [ᕙ༼,இܫஇ,༽ᕗ]
go 
-- add users with select
declare @sql nvarchar(max), @count int
select @count = count(*) from [Character] c inner join sysusers su on c.FullName = su.name where Race = 'Human';
while @count < 17
begin
	select top 1 @sql = 'create user ['+FullName+'] without login; grant select on [Character] to ['+FullName+'];' 
	from [Character] where FullName not in (select name from sysusers) and Race = 'Human';
	exec sp_executesql @sql;
	select @count = count(*) from [Character] c inner join sysusers su on c.FullName = su.name where Race = 'Human';
end	
go
select name from sysusers su inner join [Character] c on c.FullName = su.name;
go
--drop users 
/*
use [ᕙ༼,இܫஇ,༽ᕗ]
go 
declare @sql nvarchar(max), @count int
select @count = count(*) from [Character] c inner join sysusers su on c.FullName = su.name where Race = 'Human';
while @count between 1 and 17 
begin
	select top 1 @sql = 'drop user if exists ['+FullName+'] ;' from [Character] where FullName in (select name from sysusers) and Race = 'Human';
	exec sp_executesql @sql;
	select @count = count(*) from [Character] c inner join sysusers su on c.FullName = su.name where Race = 'Human';
end	
go*/
-- Mask the Agent column with DDM.
go

--  +------------------+
--  | Killahead Bridge |
--  +------------------+
alter table [Character] alter column FullName	add masked with (function = 'Partial(0, "---", 0)');
alter table [Character] alter column Aka		add masked with (function = 'Partial(0, "---", 0)');
alter table [Character] alter column Race		add masked with (function = 'Partial(0, "---", 0)');
alter table [Character] alter column Age		add masked with (function = 'default()'); --random(0,0)
alter table [Character] alter column Relatives	add masked with (function = 'Partial(0, "---", 0)');
alter table [Character] alter column EyeColor	add masked with (function = 'Partial(0, "---", 0)');
alter table [Character] alter column HairColor	add masked with (function = 'Partial(0, "---", 0)');
alter table [Character] alter column Minions	add masked with (function = 'Partial(0, "---", 0)');
go 

--  +-------------------------------------------------------+
--  | For the glory of Merlin, Daylight is mine to command! |
--  +-------------------------------------------------------+
grant unmask to [Jim Lake Jr.];
go

--  +-----------------------------+
--  | Jim becomes the Trollhunter |
--  +-----------------------------+
execute as user = 'Jim Lake Jr.';
	select 'Seen as Jim' as Person, * from [Character]; 
revert;
go
-- Mom doesn't know.
execute as user = 'Barbara Lake';
	select 'Seen as Barbara' as Person, * from [Character]; 
revert;
go
-- Mom senses something's up.
execute as user = 'Barbara Lake';
	select 'Seen as Barbara' as Person, *
	from [Character]
	where FullName like '%Jim%' 
revert;
go

--  +---------------+
--  | Mom finds out |
--  +---------------+
create table Letters (
	Letter 	varchar(1) 	not null,
	constraint PK_Letters primary key clustered (Letter asc));
go --drop table letters
insert Letters (Letter) values
 ('A'),('B'),('C'),('D'),('E'),('F'),('G')
,('H'),('I'),('J'),('K'),('L'),('M'),('N'),('Ñ'),('O'),('P')
,('Q'),('R'),('S')
,('T'),('U'),('V')
,('W'),('X'),('Y'),('Z')
,(' '),('.');
go
grant select on Letters to [Barbara Lake]; 
go
execute as user = 'Barbara Lake';
	select 	'Seen as Barbara' as Person
	,c.FullName
	,L01.Letter as L01	,L02.Letter as L02	,L03.Letter as L03	,L04.Letter as L04
	,L05.Letter as L05	,L06.Letter as L06	,L07.Letter as L07	,L08.Letter as L08
	,L09.Letter as L09	,L10.Letter as L10	,L11.Letter as L11	,L12.Letter as L12
	,L13.Letter as L13	,L14.Letter as L14	,L15.Letter as L15	,L16.Letter as L16
	,L17.Letter as L17	,L18.Letter as L18	,L19.Letter as L19	,L20.Letter as L20
	,L21.Letter as L21	,L22.Letter as L22	,L23.Letter as L23	,L24.Letter as L24
	,L25.Letter as L25	,L26.Letter as L26	,L27.Letter as L27	,L28.Letter as L28
	,L29.Letter as L29
	from 	[Character] c
	inner join Letters L01 on (L01.Letter = substring(c.FullName,01,1))
	inner join Letters L02 on (L02.Letter = substring(c.FullName,02,1))
	inner join Letters L03 on (L03.Letter = substring(c.FullName,03,1))
	inner join Letters L04 on (L04.Letter = substring(c.FullName,04,1))
	inner join Letters L05 on (L05.Letter = substring(c.FullName,05,1))
	inner join Letters L06 on (L06.Letter = substring(c.FullName,06,1))
	inner join Letters L07 on (L07.Letter = substring(c.FullName,07,1))
	inner join Letters L08 on (L08.Letter = substring(c.FullName,08,1))
	inner join Letters L09 on (L09.Letter = substring(c.FullName,09,1))
	inner join Letters L10 on (L10.Letter = substring(c.FullName,10,1))
	inner join Letters L11 on (L11.Letter = substring(c.FullName,11,1))
	inner join Letters L12 on (L12.Letter = substring(c.FullName,12,1))
	inner join Letters L13 on (L13.Letter = substring(c.FullName,13,1))
	inner join Letters L14 on (L14.Letter = substring(c.FullName,14,1))
	inner join Letters L15 on (L15.Letter = substring(c.FullName,15,1))
	inner join Letters L16 on (L16.Letter = substring(c.FullName,16,1))
	inner join Letters L17 on (L17.Letter = substring(c.FullName,17,1))
	inner join Letters L18 on (L18.Letter = substring(c.FullName,18,1))
	inner join Letters L19 on (L19.Letter = substring(c.FullName,19,1))
	inner join Letters L20 on (L20.Letter = substring(c.FullName,20,1))
	inner join Letters L21 on (L21.Letter = substring(c.FullName,21,1))
	inner join Letters L22 on (L22.Letter = substring(c.FullName,22,1))
	inner join Letters L23 on (L23.Letter = substring(c.FullName,23,1))
	inner join Letters L24 on (L24.Letter = substring(c.FullName,24,1))
	inner join Letters L25 on (L25.Letter = substring(c.FullName,25,1))
	inner join Letters L26 on (L26.Letter = substring(c.FullName,26,1))
	inner join Letters L27 on (L27.Letter = substring(c.FullName,27,1))
	inner join Letters L28 on (L28.Letter = substring(c.FullName,28,1))
	inner join Letters L29 on (L29.Letter = substring(c.FullName,29,1))
revert;
go

--  +--------------------------+
--  | Killahead Bridge Dropped |
--  +--------------------------+
alter table [Character] alter column FullName	drop masked ;
alter table [Character] alter column Aka		drop masked ;
alter table [Character] alter column Race		drop masked ;
alter table [Character] alter column Age		drop masked ;
alter table [Character] alter column Relatives	drop masked ;
alter table [Character] alter column EyeColor	drop masked ;
alter table [Character] alter column HairColor	drop masked ;
alter table [Character] alter column Minions	drop masked ;
go 

--  +----------+
--  | Lore RLS |
--  +----------+
--  :connect localhost
--  add users with select. lines 172-181.
drop security policy if exists PortalPolicy;
drop function if exists Portal.fn_PortalAccess;
drop schema if exists Portal;
drop view if exists [Humans];
go
create view [Humans] as 
	select	FullName, [Status], Age, Home, Relatives, EyeColor, HairColor
	from	[Character]
	where	( FullName = user_name() or Relatives like '%'+user_name()+'%' )
	or		user_name()='Jim Lake Jr.';
go
--  Everyone in Arcadia knows eachother.
declare @sql nvarchar(max)=null, @count int = null;
select @count = count(*) from sys.database_permissions where permission_name = 'select' and object_name(major_id) = 'Humans' and user_name(grantee_principal_id) in (select FullName from [Character] where Race = 'Human')
while @count < 17
begin
	select top 1 @sql = 'grant select on [Humans] to ['+FullName+'];'
	from [Character] where FullName in (select name from sysusers) and Race = 'Human' 
	and FullName not in (select user_name(grantee_principal_id) from sys.database_permissions where permission_name = 'select' and object_name(major_id) = 'Humans');
	exec sp_executesql @sql;
	select @count = count(*) from sys.database_permissions where permission_name = 'select' and object_name(major_id) = 'Humans' and user_name(grantee_principal_id) in (select FullName from [Character] where Race = 'Human')
end	
go
select	user_name(grantee_principal_id) as [User], permission_name, object_name(major_id) as [OnObject] 
from	sys.database_permissions 
where	permission_name = 'select' 
and		object_name(major_id) = 'Humans' 
and		user_name(grantee_principal_id) in (select	FullName 
											from	[Character] 
											where	Race = 'Human')
go
--  Mom doesn't know about the Trolls.
execute as user = 'Barbara Lake';
	select 'Seen as Barbara' as Person, * from [Humans]; 
revert;
go
--  By the glory of Merlin, Daylight is mine to command!
execute as user = 'Jim Lake Jr.';
	select 'Seen as Jim' as Person, * from [Humans]; 
revert;
go
--  Only the heartstone can open the portal to Trollmarkert.
create schema Portal; 
go
create function Portal.fn_PortalAccess (@FullName as sysname, @Relatives as sysname) 
returns table with schemabinding as
return	select	1 as PortalAccess 
		where	( @FullName = user_name() or @Relatives like '%'+user_name()+'%' )
		or		user_name() = 'Jim Lake Jr.';
go 
create security policy PortalPolicy
add filter predicate Portal.fn_PortalAccess (FullName, Relatives) on dbo.[Character] with (state = on);
go 
--  Trollhunters check if an RLS enchantment exists.
select object_name(object_id) as ObjectName, * from sys.security_policies;
select object_name(object_id) as ObjectName, * from sys.security_predicates;
go
--  Mom doesn't know about the Trolls.
execute as user = 'Barbara Lake';
	select 'Seen as Barbara' as Person, * from [Character]; 
revert;
go
--  By the glory of Merlin, Daylight is mine to command!
execute as user = 'Jim Lake Jr.';
	select 'Seen as Jim' as Person, * from [Character]; 
revert;
go
--  Gunmar gets the heartstone.
alter security policy PortalPolicy with (state = off);
go
--  Trollhunters check if an RLS enchantment exists.
select object_name(object_id) as ObjectName, * from sys.security_policies;
select object_name(object_id) as ObjectName, * from sys.security_predicates;
go
--  Mom learns the trolls when Gunmar attacked Arcadia.
execute as user = 'Barbara Lake';
	select 'Seen as Barbara' as Person, * from [Character]; 
revert; 
go
--  Mom helps the trollhunters save Arcadia from the Gum-Gum army.
execute as user = 'Barbara Lake';
	select * from sys.partitions where object_id = object_id('dbo.Character');
revert;
go
execute as user = 'Barbara Lake';
    select 'Seen as Barbara' as Person, 1 / (Age - 16), * from [Character]; --Divide by zero error encountered.
revert;
go
--Jim and the trollhunters fight the gum-gum army.
alter security policy PortalPolicy with (state = on); --Command(s) completed successfully.
go
--  Mom continues to help Jim save Arcadia.
execute as user = 'Barbara Lake';
    select 'Seen as Barbara' as Person, 1 / (Age - 16), * from [Character]; --Patched error in SQL2016 CUs. SQL2017 RTM still occurs.
revert;
go
execute as user = 'Barbara Lake';
    select 'Seen as Barbara' as Person, * from [Character]
	where 1 = 1 / (Age - 16); --Divide by zero error encountered. 
revert; --9000, 4999, 600, 56, 38, 16, 15, 1
go
execute as user = 'Barbara Lake';
	exec sp_columns [Character]; 
	exec sp_pkeys [Character]; 
	exec sp_fkeys [Character];
revert;
go

--  +--------------------------------------------------------------------+
--  | Barbara can brute-force devide by 0 to identify every integer.     |
--  | Barbara can use the DDM letters table to identify every character. |
--  | When all seems lost, our hero...									 |
--	| Jim the Trollhunter has the Amulet Of Daylight!					 |
--  +--------------------------------------------------------------------+
