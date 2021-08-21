-- Project name and employee ID of developers who authored a document but are not associated with the project on that
-- document, ordered by project and then employeeID
select distinct p.pname, d.employeeid
from project p, developer d, documentauthors da, document doc
where d.employeeid = da.employeeid and da.documentid = doc.documentid and doc.pname = p.pname
except (
    select distinct p.pname, d.employeeid
    from project p, developer d, devassignments devas
    where d.employeeid = devas.employeeid and devas.pname= p.pname
)
order by pname, employeeid
;