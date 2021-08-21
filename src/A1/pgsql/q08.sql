-- Names of projects where developer with ID 93401 has an associated document, ordered by project name
select distinct p.pname
from project p, developer d, document doc, documentauthors da
where doc.documentid = da.documentid and da.employeeid = d.employeeid and doc.pname = p.pname and d.employeeid = 93401
order by p.pname
;