SELECT c.champion_name as champion_name, COUNT(*) as cnt
FROM champ as c, participant as p
WHERE c.champion_id = p.champion_id
AND p.position = 'JUNGLE'
GROUP BY c.champion_name
ORDER BY cnt DESC
LIMIT 3;