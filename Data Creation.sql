BEGIN
  EXECUTE IMMEDIATE 'DROP TABLE sales_fact PURGE';
EXCEPTION
  WHEN OTHERS THEN
    IF SQLCODE != -942 THEN RAISE; END IF;
END;
/

BEGIN
  EXECUTE IMMEDIATE 'DROP TABLE dim_region PURGE';
EXCEPTION
  WHEN OTHERS THEN
    IF SQLCODE != -942 THEN RAISE; END IF;
END;
/

BEGIN
  EXECUTE IMMEDIATE 'DROP TABLE dim_product PURGE';
EXCEPTION
  WHEN OTHERS THEN
    IF SQLCODE != -942 THEN RAISE; END IF;
END;
/

BEGIN
  EXECUTE IMMEDIATE 'DROP TABLE dim_channel PURGE';
EXCEPTION
  WHEN OTHERS THEN
    IF SQLCODE != -942 THEN RAISE; END IF;
END;
/

BEGIN
   EXECUTE IMMEDIATE 'DROP SEQUENCE sales_seq';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE != -2289 THEN  -- 2289 = sequence does not exist
         RAISE;
      END IF;
END;
/

-- Fact table
CREATE TABLE sales_fact (
    sales_id NUMBER PRIMARY KEY,
    product_id NUMBER,
    region_id NUMBER,
    channel_id NUMBER,
    total_amount NUMBER,
    sales_date DATE
);

-- Dimension tables
CREATE TABLE dim_product (
    product_id NUMBER PRIMARY KEY,
    product_name VARCHAR2(50),
    product_category VARCHAR2(30)
);

CREATE TABLE dim_region (
    region_id NUMBER PRIMARY KEY,
    region_name VARCHAR2(50)
);

CREATE TABLE dim_channel (
    channel_id NUMBER PRIMARY KEY,
    channel_name VARCHAR2(50)
);

-- Example sequence for sales_id
CREATE SEQUENCE sales_seq START WITH 1 INCREMENT BY 1;

-- Products (10 rows)
INSERT INTO dim_product VALUES (1, 'Laptop', 'Electronics');
INSERT INTO dim_product VALUES (2, 'Smartphone', 'Electronics');
INSERT INTO dim_product VALUES (3, 'Tablet', 'Electronics');
INSERT INTO dim_product VALUES (4, 'Monitor', 'Electronics');
INSERT INTO dim_product VALUES (5, 'Keyboard', 'Electronics');
INSERT INTO dim_product VALUES (6, 'Chair', 'Furniture');
INSERT INTO dim_product VALUES (7, 'Table', 'Furniture');
INSERT INTO dim_product VALUES (8, 'Sofa', 'Furniture');
INSERT INTO dim_product VALUES (9, 'Bed', 'Furniture');
INSERT INTO dim_product VALUES (10, 'Wardrobe', 'Furniture');

-- Regions (10 rows)
INSERT INTO dim_region VALUES (1, 'Kuala Lumpur');
INSERT INTO dim_region VALUES (2, 'Penang');
INSERT INTO dim_region VALUES (3, 'Johor');
INSERT INTO dim_region VALUES (4, 'Selangor');
INSERT INTO dim_region VALUES (5, 'Melaka');
INSERT INTO dim_region VALUES (6, 'Negeri Sembilan');
INSERT INTO dim_region VALUES (7, 'Perak');
INSERT INTO dim_region VALUES (8, 'Sabah');
INSERT INTO dim_region VALUES (9, 'Sarawak');
INSERT INTO dim_region VALUES (10, 'Terengganu');

-- Channels (2 rows for simplicity)
INSERT INTO dim_channel VALUES (1, 'Online');
INSERT INTO dim_channel VALUES (2, 'Retail');


-- Generate 100,000 rows in sales_fact
BEGIN
  FOR i IN 1..100000 LOOP
    INSERT INTO sales_fact (
      sales_id,
      product_id,
      region_id,
      channel_id,
      total_amount,
      sales_date
    ) VALUES (
      sales_seq.NEXTVAL,
      -- Random product_id (for simplicity, you have only 1 product; can extend if more)
      1,
      -- Random region_id (for testing, can cycle 1-5)
      MOD(i, 5) + 1,
      -- Random channel_id (for testing, can cycle 1-3)
      MOD(i, 3) + 1,
      -- Random total_amount between 100 and 5000
      ROUND(DBMS_RANDOM.VALUE(100,5000),2),
      -- Random date in 2025
      DATE '2025-01-01' + TRUNC(DBMS_RANDOM.VALUE(0, 365))
    );
  END LOOP;
  COMMIT;
END;
/

