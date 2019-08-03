--  +---------+
--  | rockon! | 1sec
--  +---------+	
select Band, Album, sum(Cost) as TotalCost
from Song s
inner join Band b on s.BandId=b.BandId
group by Band, Album 
order by TotalCost desc;
go --00:00:01.153

select * from song