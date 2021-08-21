-- Project name and start date of all internal projects sorted by name
SELECT pname, pstartdate
FROM project
WHERE ptype = 'internal'
ORDER BY pname
;