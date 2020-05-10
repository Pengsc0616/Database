SELECT 
CASE
     WHEN result.hahawin=1 THEN 'win'
     ELSE 'lose'
END AS win_lose,COUNT(*) cnt
FROM(SELECT P.match_id as hahanum,
     S.win as hahawin,
     AVG(S.longesttimespentliving) as hahatime
     FROM participant P, stat S
     WHERE P.player_id = S.player_id
     GROUP BY hahanum, hahawin
) as result
WHERE result.hahatime>=1200
GROUP BY result.hahawin;