-- Employee ID and name of all authors of the document with ID 22, ordered by employee ID
select developer.employeeid, ename
from developer, documentauthors
where developer.employeeid = documentauthors.employeeid and documentauthors.documentid = 22
order by employeeid
;