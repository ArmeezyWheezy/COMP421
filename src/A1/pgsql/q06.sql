-- Name and employee ID of developer on at least 1 internal project but not on an external project, ordered by employee ID
select d.ename, d.employeeid
from developer d, project p, devassignments devas
where d.employeeid = devas.employeeid and devas.pname = p.pname and p.ptype = 'internal'
group by d.employeeid, d.ename
having count(*) >= 1
except (
    select d.ename, d.employeeid
    from developer d, project p, devassignments devas
    where d.employeeid = devas.employeeid and devas.pname = p.pname and p.ptype = 'external'
    )
order by employeeid
;

delete from devassignments where pname = 'otters 2';