-- Number of projects where developer with id 93401 has an associated document
select count(distinct p.pname) as numprojects
from project p, developer d, documentauthors da, document doc
where d.employeeid = 93401 and d.employeeid = da.employeeid and da.documentid = doc.documentid and doc.pname = p.pname
;