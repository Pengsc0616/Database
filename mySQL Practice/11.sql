SELECT SUM(result.FlashIgnite), SUM(result.FlashTeleport)
FROM(SELECT motor.champion_id, motor.win_ratio as FlashIgnite, cycle.win_ratio as FlashTeleport
  FROM(SELECT P.champion_id, SUM(S.win)/COUNT(*) as win_ratio
    FROM participant P, stat S
    WHERE P.player_id=S.player_id
    AND ((P.ss1='Flash' AND P.ss2='Ignite') OR (P.ss2='Flash' AND P.ss1='Ignite'))
    AND P.position='TOP'
    GROUP BY P.champion_id
  ) as motor, (SELECT P.champion_id, SUM(S.win)/COUNT(*) as win_ratio
    FROM participant P, stat S
    WHERE P.player_id=S.player_id
    AND ((P.ss1='Flash' AND P.ss2='Teleport') OR (P.ss2='Flash' AND P.ss1='Teleport'))
    AND P.position='TOP'
    GROUP BY P.champion_id
  ) as cycle
  WHERE motor.champion_id=cycle.champion_id
) as result;

SELECT SUM(motor.win_ratio>cycle.win_ratio) as FlashIgnite, SUM(motor.win_ratio<cycle.win_ratio) as FlashTeleport 
FROM(SELECT P.champion_id, SUM(S.win)/COUNT(*) as win_ratio
  FROM participant P, stat S
  WHERE P.player_id=S.player_id
  AND ((P.ss1='Flash' AND P.ss2='Ignite') OR (P.ss2='Flash' AND P.ss1='Ignite'))
  AND P.position='TOP'
  GROUP BY P.champion_id
) as motor, (SELECT P.champion_id, SUM(S.win)/COUNT(*) as win_ratio
  FROM participant P, stat S
  WHERE P.player_id=S.player_id
  AND ((P.ss1='Flash' AND P.ss2='Teleport') OR (P.ss2='Flash' AND P.ss1='Teleport'))
  AND P.position='TOP'
  GROUP BY P.champion_id
) as cycle
WHERE motor.champion_id=cycle.champion_id;
