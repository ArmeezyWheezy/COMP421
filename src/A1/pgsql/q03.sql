-- Names and employee IDs of developers on Kodiak that haven't authored a document associated
select distinct d.ename, d.employeeid
from developer d, documentauthors da, devassignments devas
where d.employeeid = devas.employeeid and devas.pname = 'Kodiak'
except (
    select d.ename, d.employeeid
    from developer d, documentauthors da, document doc
    where d.employeeid = da.employeeid and da.documentid = doc.documentid and doc.pname = 'Kodiak'
)
order by employeeid
;