-- Name, assignment date, and type of the project that the developer with ID 82102 is assigned to, ordered by project name
select p.pname, devas.asgndate, p.ptype
from project p, devassignments devas
where p.pname = devas.pname and devas.employeeid = 82102
order by p.pname
;