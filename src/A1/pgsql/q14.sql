-- Name and start date of the oldest project (based on start date), if multiple with same, order by project name
select pname, pstartdate
from project where pstartdate in (
    select min(pstartdate)
    from project
    )
order by pname
;