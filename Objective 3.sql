-- To check the index creation time

--Btree 
CREATE INDEX IDX_BTREE_TOTAL_AMOUNT ON sales_fact(total_amount);
CREATE INDEX IDX_BTREE_SALES_DATE   ON sales_fact(sales_date);
CREATE INDEX IDX_BTREE_CHANNEL_ID   ON sales_fact(channel_id);
CREATE INDEX IDX_BTREE_REGION_ID    ON sales_fact(region_id);

DROP INDEX IDX_BTREE_TOTAL_AMOUNT;
DROP INDEX IDX_BTREE_SALES_DATE;
DROP INDEX IDX_BTREE_CHANNEL_ID;
DROP INDEX IDX_BTREE_REGION_ID;

--Bitmap
CREATE BITMAP INDEX IDX_BITMAP_TOTAL_AMOUNT ON sales_fact(total_amount);
CREATE BITMAP INDEX IDX_BITMAP_SALES_DATE   ON sales_fact(sales_date);
CREATE BITMAP INDEX IDX_BITMAP_CHANNEL_ID   ON sales_fact(channel_id);
CREATE BITMAP INDEX IDX_BITMAP_REGION_ID    ON sales_fact(region_id);

DROP INDEX IDX_BITMAP_TOTAL_AMOUNT;
DROP INDEX IDX_ BITMAP_SALES_DATE;
DROP INDEX IDX_ BITMAP_CHANNEL_ID;
DROP INDEX IDX_ BITMAP_REGION_ID;


-- To measure the Index Storage Requirement
--Btree 
CREATE INDEX IDX_BTREE_TOTAL_AMOUNT ON sales_fact(total_amount);
CREATE INDEX IDX_BTREE_SALES_DATE   ON sales_fact(sales_date);
CREATE INDEX IDX_BTREE_CHANNEL_ID   ON sales_fact(channel_id);
CREATE INDEX IDX_BTREE_REGION_ID    ON sales_fact(region_id);

SELECT index_name,
       index_type,          -- This will show 'BITMAP' or 'NORMAL' (B-Tree)
       table_name,
       bytes/1024/1024 AS size_mb
FROM user_segments s
JOIN user_indexes i ON s.segment_name = i.index_name
WHERE s.segment_type = 'INDEX';

DROP INDEX IDX_BTREE_TOTAL_AMOUNT;
DROP INDEX IDX_BTREE_SALES_DATE;
DROP INDEX IDX_BTREE_CHANNEL_ID;
DROP INDEX IDX_BTREE_REGION_ID;

--Bitmap
CREATE BITMAP INDEX IDX_BITMAP_TOTAL_AMOUNT ON sales_fact(total_amount);
CREATE BITMAP INDEX IDX_BITMAP_SALES_DATE   ON sales_fact(sales_date);
CREATE BITMAP INDEX IDX_BITMAP_CHANNEL_ID   ON sales_fact(channel_id);
CREATE BITMAP INDEX IDX_BITMAP_REGION_ID    ON sales_fact(region_id);

SELECT index_name,
       index_type,          -- This will show 'BITMAP' or 'NORMAL' (B-Tree)
       table_name,
       bytes/1024/1024 AS size_mb
FROM user_segments s
JOIN user_indexes i ON s.segment_name = i.index_name
WHERE s.segment_type = 'INDEX';

DROP INDEX IDX_BITMAP_TOTAL_AMOUNT;
DROP INDEX IDX_ BITMAP_SALES_DATE;
DROP INDEX IDX_ BITMAP_CHANNEL_ID;
DROP INDEX IDX_ BITMAP_REGION_ID;


