SELECT result.position, result.champion_name, result.up/result.down as kda
FROM(
  SELECT P.position, C.champion_name, AVG(S.kills)+AVG(S.assists) as up, AVG(S.deaths) as down
  FROM champ C, participant P, stat S
  WHERE C.champion_id = P.champion_id
  AND P.player_id = S.player_id
  AND ( P.position='DUO_CARRY' OR P.position='DUO_SUPPORT' 
  OR P.position='JUNGLE' OR P.position='MID' 
  OR P.position='TOP' )
  GROUP BY P.position,C.champion_name
) result
WHERE NOT EXISTS (
  SELECT yummy.position, yummy.champion_name, yummy.up/yummy.down as kda
  FROM(
    SELECT P.position, C.champion_name, AVG(S.kills)+AVG(S.assists) as up, AVG(S.deaths) as down
    FROM champ C, participant P, stat S
    WHERE C.champion_id = P.champion_id
    AND P.player_id = S.player_id
    AND ( P.position='DUO_CARRY' OR P.position='DUO_SUPPORT' 
    OR P.position='JUNGLE' OR P.position='MID' 
    OR P.position='TOP' )
    GROUP BY P.position,C.champion_name
  ) yummy
  WHERE result.position = yummy.position
  AND yummy.up/yummy.down > result.up/result.down
  AND yummy.down>0)
AND result.down>0
ORDER BY result.position ASC;
