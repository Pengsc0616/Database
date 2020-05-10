SELECT DISTINCT C.champion_name
FROM champ C
WHERE C.champion_name NOT IN(SELECT C.champion_name
                             FROM match_info M, teamban T, champ C
                             WHERE M.match_id = T.match_id
                             AND C.champion_id = T.champion_id
                             AND substring_index(M.version,'.',2)=7.7)
ORDER BY C.champion_name ASC;
