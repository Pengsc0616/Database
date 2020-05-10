SELECT M.match_id as match_id, SEC_TO_TIME(M.duration) as time
FROM match_info M
ORDER BY time DESC
LIMIT 5;
