SELECT substring_index(M.version,'.',2) as version, SUM(S.win) as win_cnt, COUNT(*)-SUM(S.win) as lose_cnt, SUM(S.win)/COUNT(*) as win_ratio
FROM match_info M, participant P1, champ C1, stat S,
  participant P2, champ C2
WHERE M.match_id=P1.match_id AND P1.champion_id=C1.champion_id
  AND M.match_id=P2.match_id AND P2.champion_id=C2.champion_id
  AND (C1.champion_name = 'Lee Sin' AND C2.champion_name = 'Teemo')
  AND P1.player_id=S.player_id
  AND ((P1.player>5 AND P2.player>5) OR (P1.player<=5 AND P2.player<=5))
GROUP BY substring_index(M.version,'.',2);