-- Name and budget of all projects whose budge is > avg internal project budget, ordered by budget then name
select pname, budget
from project where budget > (
    select avg(budget)
    from project
    where ptype = 'internal'
    )
order by budget desc, pname
;