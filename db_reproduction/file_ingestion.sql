-- Where can the data be ingested from?
SHOW VARIABLES LIKE 'secure_file_priv';
-- In my local environment, the data can be ingested from the directory: C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/
-- SQL dump is added in main/bikestores_dump.sql to possibly skip this step for reproducibility.

-- Disable foreign key checks for data ingestion
SET FOREIGN_KEY_CHECKS = 0;

-- Clean the tables before loading new data in dependency order
TRUNCATE TABLE bikestores.order_items;

TRUNCATE TABLE bikestores.orders;

TRUNCATE TABLE bikestores.stocks;

TRUNCATE TABLE bikestores.staffs;

TRUNCATE TABLE bikestores.products;

TRUNCATE TABLE bikestores.customers;

TRUNCATE TABLE bikestores.stores;

TRUNCATE TABLE bikestores.categories;

TRUNCATE TABLE bikestores.brands;

-- Load data into customers table
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/customers.csv' INTO
TABLE bikestores.customers FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n' IGNORE 1 ROWS (
    customer_id,
    first_name,
    last_name,
    phone,
    email,
    street,
    city,
    state,
    zip_code
);

-- Load data into stores table
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/stores.csv' INTO
TABLE bikestores.stores FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n' IGNORE 1 ROWS (
    store_id,
    store_name,
    phone,
    email,
    street,
    city,
    state,
    zip_code
);

-- Load data into staffs table with NULL handling for manager_id
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/staffs.csv' INTO
TABLE bikestores.staffs FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n' IGNORE 1 ROWS (
    staff_id,
    first_name,
    last_name,
    email,
    phone,
    active,
    store_id,
    manager_id
);

-- Load data into orders table with NULL handling for nullable fields
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/orders.csv' INTO
TABLE bikestores.orders FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n' IGNORE 1 ROWS (
    order_id,
    customer_id,
    order_status,
    order_date,
    required_date,
    shipped_date,
    @staff_id,
    store_id
)
SET
    staff_id = NULLIF(@staff_id, '');

-- Load data into order_items table
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/order_items.csv' INTO
TABLE bikestores.order_items FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n' IGNORE 1 ROWS (
    order_id,
    item_id,
    product_id,
    quantity,
    list_price,
    discount
);

-- Load data into categories table
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/categories.csv' INTO
TABLE bikestores.categories FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n' IGNORE 1 ROWS (category_id, category_name);

-- Load data into brands table
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/brands.csv' INTO
TABLE bikestores.brands FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n' IGNORE 1 ROWS (brand_id, brand_name);

-- Load data into products table
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/products.csv' INTO
TABLE bikestores.products FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n' IGNORE 1 ROWS (
    product_id,
    product_name,
    brand_id,
    category_id,
    model_year,
    list_price
);

-- Load data into stocks table
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/stocks.csv' INTO
TABLE bikestores.stocks FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n' IGNORE 1 ROWS (
    store_id,
    product_id,
    quantity
);

-- Enable foreign key checks after performing data ingestion
SET FOREIGN_KEY_CHECKS = 1;