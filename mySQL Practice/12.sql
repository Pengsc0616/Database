SELECT god.champion_name, COUNT(*) as finalcount
FROM(SELECT sky.newversion, C.champion_name
  FROM(SELECT substring_index(M.version,'.',2) as newversion, bird.champion_id,
      SUM(bird.wintimes)/SUM(bird.cnt) as win_ratio
    FROM(SELECT P.champion_id, P.match_id, SUM(S.win) wintimes, COUNT(*) cnt
      FROM participant P, stat S
      WHERE P.player_id=S.player_id
      GROUP BY P.champion_id, P.match_id
    ) as bird, match_info M
    WHERE bird.match_id=M.match_id
    GROUP BY newversion, bird.champion_id
  ) as sky, champ C
  WHERE NOT EXISTS (
    SELECT *
    FROM(SELECT substring_index(M.version,'.',2) as newversion, bird.champion_id,
        SUM(bird.wintimes)/SUM(bird.cnt) as win_ratio
      FROM(SELECT P.champion_id, P.match_id, SUM(S.win) wintimes, COUNT(*) cnt
        FROM participant P, stat S
        WHERE P.player_id=S.player_id
        GROUP BY P.champion_id, P.match_id
      ) as bird, match_info M
      WHERE bird.match_id=M.match_id
      GROUP BY newversion, bird.champion_id
    ) walker
    WHERE sky.newversion=walker.newversion
    AND walker.win_ratio > sky.win_ratio)
    AND sky.champion_id=C.champion_id
) as god
GROUP BY god.champion_name
ORDER BY finalcount DESC
LIMIT 20;