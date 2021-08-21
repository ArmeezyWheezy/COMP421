-- Name of projects with 2 or less developers assigned to it, ordered by project name
select p.pname
from project p, developer d, devassignments da
where p.pname = da.pname and da.employeeid = d.employeeid
group by p.pname
having count(*) <= 2
union (
    select project.pname from project except(
        select project.pname from project join devassignments d on project.pname = d.pname)
    order by pname
)
order by pname
;