SELECT result.self_champ_name, result.win_ratio,  result.up2/result.down2 as self_kda,
result.self_avg_gold, result.enemy_champ_name,  result.up1/result.down1 as enemy_kda,
result.enemy_avg_gold, result.battle_record
FROM ( SELECT C2.champion_name as self_champ_name, SUM(S2.win)/COUNT(*) as win_ratio,
  AVG(S2.kills)+AVG(S2.assists) as up2, AVG(S2.deaths) as down2,
  AVG(S2.goldearned) as self_avg_gold,
  C1.champion_name as enemy_champ_name,
  AVG(S1.kills)+AVG(S1.assists) as up1, AVG(S1.deaths) as down1,
  AVG(S1.goldearned) as enemy_avg_gold,
  COUNT(*) as battle_record
  FROM match_info M, participant P1, champ C1, stat S1,
  participant P2, champ C2, stat S2
  WHERE M.match_id=P1.match_id AND M.match_id=P2.match_id
  AND P1.champion_id=58 
  AND P1.champion_id = C1.champion_id
  AND P1.player_id = S1.player_id
  AND P2.champion_id = C2.champion_id 
  AND P2.player_id = S2.player_id
  AND ((P1.player>5 AND P2.player<=5) OR (P1.player<=5 AND P2.player>5))
  AND P1.position='TOP'
  AND P2.position='TOP'
  GROUP BY C2.champion_name ) as result
WHERE result.battle_record>100
AND result.down2>0
AND result.down1>0
ORDER BY result.win_ratio DESC
LIMIT 5;