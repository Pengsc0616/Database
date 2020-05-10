SELECT result.position, result.champion_name
FROM(
  SELECT P.position, C.champion_name, COUNT(*) cnt
  FROM champ C, participant P, match_info M
  WHERE C.champion_id = P.champion_id
  AND M.match_id = P.match_id
  AND M.duration BETWEEN 2400 AND 3000
  GROUP BY P.position,C.champion_name
) result
WHERE NOT EXISTS (
  SELECT *
  FROM(
    SELECT P.position, C.champion_name, COUNT(*) cnt
    FROM champ C, participant P, match_info M
    WHERE C.champion_id = P.champion_id
    AND M.match_id = P.match_id
    AND M.duration BETWEEN 2400 AND 3000
    GROUP BY P.position,C.champion_name
  ) yummy
  WHERE result.position = yummy.position
  AND yummy.cnt > result.cnt) 
  AND ( result.position='DUO_CARRY' OR result.position='DUO_SUPPORT' 
  OR result.position='JUNGLE' OR result.position='MID' 
  OR result.position='TOP' )
ORDER BY result.position ASC;