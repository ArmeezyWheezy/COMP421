-- Names and employee ID of developers on Kodiak OR associated with document in kodiak, ordered by employee ID
select ename, developer.employeeid
from developer
join devassignments on developer.employeeid = devassignments.employeeid
where devassignments.pname = 'Kodiak'
union (
    select d.ename, d.employeeid
    from developer d, document doc, documentauthors da
    where d.employeeid = da.employeeid and da.documentid = doc.documentid and doc.pname = 'Kodiak'
)
order by employeeid
;