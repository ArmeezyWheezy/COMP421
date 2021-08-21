-- Name of project where budget/numdev (devcost) is highest, ordered by project name
-- not including projects with no developers
select pname, devcost
from (
         select project.pname, (project.budget / count(employeeid)) as devcost
         from project,
              devassignments
         where project.pname = devassignments.pname
         group by project.pname
     ) t3
where devcost in (
    select Max(t2.devcost) as devcost
    from (
             select (project.budget / count(employeeid)) as devcost
             from project,
                  devassignments
             where project.pname = devassignments.pname
             group by project.pname
         ) t2
)
order by pname
;