-- Number of projects that started this year
select count(*) as numprojects
from project p
where date_part('year', p.pstartdate) = date_part('year', CURRENT_DATE);
;