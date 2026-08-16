-- Find the rank of each score, ranking scores from highest to lowest. 
-- Tied scores should have the same rank with no gaps between ranks.
SELECT score,
       DENSE_RANK() OVER (ORDER BY score DESC) AS `rank`
FROM Scores
ORDER BY score DESC;