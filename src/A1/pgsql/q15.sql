-- Name, start date of youngest project (most recent start date) and number of developers assigned  ordered by project name
select project.pname, pstartdate, count(employeeid) as numdevs
from project, devassignments where (pstartdate in (
    select max(pstartdate)
    from project
    ) and project.pname = devassignments.pname)
group by project.pname, pstartdate
union (
    select project.pname, pstartdate, 0 as numdevs
    from project, devassignments where (pstartdate in (
        select max(pstartdate)
        from project
    )) and project.pname not in (
        select pname from devassignments
    )
 group by project.pname, pstartdate
)
order by pname
;

select * from devassignments;