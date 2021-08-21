-- Name of projects with more than 2 developers assigned, ordered by project name
select p.pname
from project p, developer d, devassignments da
where p.pname = da.pname and da.employeeid = d.employeeid
group by p.pname
having count(*) > 2
order by pname
;