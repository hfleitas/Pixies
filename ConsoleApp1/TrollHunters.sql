--  Troll Hunters: http://trollhunters.wikia.com/wiki/Trollhunters_Wiki , https://en.wikipedia.org/wiki/Trollhunters
--  :connect localhost
--  :connect TrollHunters
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
--  +------+
--  | Lore |
--  +------+
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

--  +----------+
--  | Lore DDM |
--  +----------+
use [ᕙ༼,இܫஇ,༽ᕗ]
go 
declare @sql varchar(max), @count int
select @count = count(*) from [Character] c where c.FullName not in (select name from sysusers)
while @count>0
begin
	select top 1 @sql = 'create user ['+FullName+'] without login;' from [Character] where Race = 'Human';
	exec sp_executesql @sql
end	
go
