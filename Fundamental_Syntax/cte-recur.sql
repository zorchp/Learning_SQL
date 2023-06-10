WITH RECURSIVE cteSource (counter) AS ((SELECT 1)
                                       UNION ALL
                                       (SELECT counter + 1
                                        FROM cteSource
                                        WHERE counter < 10))
SELECT *
FROM cteSource;

WITH RECURSIVE cnt(x) AS (SELECT 1
                          UNION ALL
                          SELECT x + 1
                          FROM cnt
                          LIMIT 10)
SELECT x
FROM cnt;