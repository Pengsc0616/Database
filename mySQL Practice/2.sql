SELECT COUNT(DISTINCT result.run) as cnt
FROM(
  SELECT substring_index(M.version,'.',2) as run
  FROM match_info M
  GROUP BY run
) as result;