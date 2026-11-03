
SELECT State, RE_MW
FROM energy
WHERE FY_end = 2024
ORDER BY RE_MW DESC
LIMIT 10;

SELECT State , Round (RE_MW/ (NSDP/1000.0), 2) AS mw_per_1000cr
FROM energy
WHERE FY_end = 2024
ORDER BY mw_per_1000cr DESC
LIMIT 10;


WITH s AS (SELECT State, RE_MW AS mw12 FROM energy WHERE FY_end = 2012),
     e AS (SELECT State, RE_MW AS mw24 FROM energy WHERE FY_end = 2024)
SELECT s.State, mw12, mw24, mw24 - mw12 AS added_mw
FROM s JOIN e USING (State)
ORDER BY added_mw DESC
LIMIT 10;



SELECT FY_end, State, RE_MW,
       RANK() OVER (PARTITION BY FY_end ORDER BY RE_MW DESC) AS rank_in_year
FROM energy
WHERE State IN ('Rajasthan', 'Gujarat', 'Tamil Nadu', 'Karnataka', 'Maharashtra')
ORDER BY State, FY_end;