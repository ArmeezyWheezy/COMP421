-- Project name and start date of those that started summer 2020, ordered by start date then name
select p.pname, p.pstartdate
from project p
where p.pstartdate >= date('2020-05-01') and p.pstartdate < date('2020-09-01')
order by p.pstartdate,p.pname
;