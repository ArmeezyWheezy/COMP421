-- Names of internal projects and the number of associated documents
SELECT pname, COUNT(*) AS numdocs
FROM
    (
        SELECT p.pname
        FROM document d, project p
        WHERE d.pname = p.pname
          AND p.ptype = 'internal'
    ) t2
GROUP BY pname
union (
    select pname, 0 as numdocs
    from project
    where pname not in (select pname from document) and ptype = 'internal'
)
order by numdocs desc, pname
;

select * from project;