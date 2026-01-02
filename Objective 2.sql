
-- To check the cardinality of each attribute 
SELECT 'total_amount' AS attribute, COUNT(DISTINCT total_amount) AS distinct_count
FROM sales_fact
UNION ALL
SELECT 'sales_date', COUNT(DISTINCT sales_date)
FROM sales_fact
UNION ALL
SELECT 'channel_id', COUNT(DISTINCT channel_id)
FROM sales_fact
UNION ALL
SELECT 'region_id', COUNT(DISTINCT region_id)
FROM sales_fact;
