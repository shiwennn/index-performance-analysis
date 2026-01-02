-- No Index
DECLARE
    start_time NUMBER;
    end_time NUMBER;
    exec_time NUMBER;
BEGIN
    -- Aggregation Query Example
    start_time := DBMS_UTILITY.get_time;

    FOR rec IN (
        SELECT region_id, SUM(total_amount) AS total_sales
        FROM sales_fact
        GROUP BY region_id
    ) LOOP
        NULL;
    END LOOP;

    end_time := DBMS_UTILITY.get_time;
    exec_time := (end_time - start_time)/100; -- seconds
    DBMS_OUTPUT.PUT_LINE('Baseline Aggregation Time: ' || exec_time || ' seconds');
    
    -- Filtering Query Example
    start_time := DBMS_UTILITY.get_time;

    FOR rec IN (
        SELECT * FROM sales_fact
        WHERE total_amount > 5000
    ) LOOP
        NULL;
    END LOOP;

    end_time := DBMS_UTILITY.get_time;
    exec_time := (end_time - start_time)/100;
    DBMS_OUTPUT.PUT_LINE('Baseline Filtering Time: ' || exec_time || ' seconds');

    -- Join Query Example
    start_time := DBMS_UTILITY.get_time;

    FOR rec IN (
        SELECT r.region_name, SUM(f.total_amount) AS total_sales
        FROM sales_fact f
        JOIN dim_region r ON f.region_id = r.region_id
        JOIN dim_product p ON f.product_id = p.product_id
        WHERE p.product_category = 'Electronics'
        GROUP BY r.region_name
    ) LOOP
        NULL;
    END LOOP;

    end_time := DBMS_UTILITY.get_time;
    exec_time := (end_time - start_time)/100;
    DBMS_OUTPUT.PUT_LINE('Baseline Join Time: ' || exec_time || ' seconds');
END;
/

-- Btree 
-- Create Index
CREATE INDEX IDX_BTREE_TOTAL_AMOUNT ON sales_fact(total_amount);
CREATE INDEX IDX_BTREE_SALES_DATE   ON sales_fact(sales_date);
CREATE INDEX IDX_BTREE_CHANNEL_ID   ON sales_fact(channel_id);
CREATE INDEX IDX_BTREE_REGION_ID    ON sales_fact(region_id);

DECLARE
    start_time NUMBER;
    end_time NUMBER;
    exec_time NUMBER;
BEGIN
    -- Aggregation Query Example
    start_time := DBMS_UTILITY.get_time;

    FOR rec IN (
        SELECT region_id, SUM(total_amount) AS total_sales
        FROM sales_fact
        GROUP BY region_id
    ) LOOP
        NULL;
    END LOOP;

    end_time := DBMS_UTILITY.get_time;
    exec_time := (end_time - start_time)/100; -- seconds
    DBMS_OUTPUT.PUT_LINE('Btree Aggregation Time: ' || exec_time || ' seconds');
    
    -- Filtering Query Example
    start_time := DBMS_UTILITY.get_time;

    FOR rec IN (
        SELECT * FROM sales_fact
        WHERE total_amount > 5000
    ) LOOP
        NULL;
    END LOOP;

    end_time := DBMS_UTILITY.get_time;
    exec_time := (end_time - start_time)/100;
    DBMS_OUTPUT.PUT_LINE('Btree Filtering Time: ' || exec_time || ' seconds');

    -- Join Query Example
    start_time := DBMS_UTILITY.get_time;

    FOR rec IN (
        SELECT r.region_name, SUM(f.total_amount) AS total_sales
        FROM sales_fact f
        JOIN dim_region r ON f.region_id = r.region_id
        JOIN dim_product p ON f.product_id = p.product_id
        WHERE p.product_category = 'Electronics'
        GROUP BY r.region_name
    ) LOOP
        NULL;
    END LOOP;

    end_time := DBMS_UTILITY.get_time;
    exec_time := (end_time - start_time)/100;
    DBMS_OUTPUT.PUT_LINE('Btree Join Time: ' || exec_time || ' seconds');
END;
/

--Drop Btree Index
DROP INDEX IDX_BTREE_TOTAL_AMOUNT;
DROP INDEX IDX_BTREE_SALES_DATE;
DROP INDEX IDX_BTREE_CHANNEL_ID;
DROP INDEX IDX_BTREE_REGION_ID;

-- Bitmap
-- Create Index
CREATE BITMAP INDEX IDX_BITMAP_TOTAL_AMOUNT ON sales_fact(total_amount);
CREATE BITMAP INDEX IDX_BITMAP_SALES_DATE   ON sales_fact(sales_date);
CREATE BITMAP INDEX IDX_BITMAP_CHANNEL_ID   ON sales_fact(channel_id);
CREATE BITMAP INDEX IDX_BITMAP_REGION_ID    ON sales_fact(region_id);

DECLARE
    start_time NUMBER;
    end_time NUMBER;
    exec_time NUMBER;
BEGIN
    -- Aggregation Query Example
    start_time := DBMS_UTILITY.get_time;

    FOR rec IN (
        SELECT region_id, SUM(total_amount) AS total_sales
        FROM sales_fact
        GROUP BY region_id
    ) LOOP
        NULL;
    END LOOP;

    end_time := DBMS_UTILITY.get_time;
    exec_time := (end_time - start_time)/100; -- seconds
    DBMS_OUTPUT.PUT_LINE('Bitmap Aggregation Time: ' || exec_time || ' seconds');
    
    -- Filtering Query Example
    start_time := DBMS_UTILITY.get_time;

    FOR rec IN (
        SELECT * FROM sales_fact
        WHERE total_amount > 5000
    ) LOOP
        NULL;
    END LOOP;

    end_time := DBMS_UTILITY.get_time;
    exec_time := (end_time - start_time)/100;
    DBMS_OUTPUT.PUT_LINE('Bitmap Filtering Time: ' || exec_time || ' seconds');

    -- Join Query Example
    start_time := DBMS_UTILITY.get_time;

    FOR rec IN (
        SELECT r.region_name, SUM(f.total_amount) AS total_sales
        FROM sales_fact f
        JOIN dim_region r ON f.region_id = r.region_id
        JOIN dim_product p ON f.product_id = p.product_id
        WHERE p.product_category = 'Electronics'
        GROUP BY r.region_name
    ) LOOP
        NULL;
    END LOOP;

    end_time := DBMS_UTILITY.get_time;
    exec_time := (end_time - start_time)/100;
    DBMS_OUTPUT.PUT_LINE('Bitmap Join Time: ' || exec_time || ' seconds');
END;
/

--Drop Bitmap Index
DROP INDEX IDX_BITMAP_TOTAL_AMOUNT;
DROP INDEX IDX_ BITMAP_SALES_DATE;
DROP INDEX IDX_ BITMAP_CHANNEL_ID;
DROP INDEX IDX_ BITMAP_REGION_ID;
