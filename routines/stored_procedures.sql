USE bikestores;

-- CREATING STORED PROCEDURES
-- STORED PROCEDURE TO POPULATE THE DATABASE
-- This simulates the operational layer. AI helped to generate the code.
-- Staff and stores are not updated for brevity. This serves as an example.
-- Procedure is not working properly: duplicate brand names, category names, and customer names are not handled, even if intended.
DROP PROCEDURE IF EXISTS populate_database;

DELIMITER $$

CREATE PROCEDURE populate_database(
    IN p_brand_name VARCHAR(256),
    IN p_category_name VARCHAR(256),
    IN p_customer_first_name VARCHAR(256),
    IN p_customer_last_name VARCHAR(256),
    IN p_phone VARCHAR(256),
    IN p_email VARCHAR(256),
    IN p_street VARCHAR(256),
    IN p_city VARCHAR(256),
    IN p_state VARCHAR(256),
    IN p_zip_code VARCHAR(256),
    IN p_product_name VARCHAR(256),
    IN p_model_year VARCHAR(256),
    IN p_list_price FLOAT,
    IN p_order_status INT,
    IN p_order_date VARCHAR(256),
    IN p_required_date VARCHAR(256),
    IN p_shipped_date VARCHAR(256),
    IN p_quantity INT,
    IN p_discount FLOAT
)
BEGIN
    DECLARE brandId INT DEFAULT NULL;
    DECLARE categoryId INT DEFAULT NULL;
    DECLARE customerId INT DEFAULT NULL;
    DECLARE productId INT DEFAULT NULL;

    -- Normalize input parameters for comparison
    SET @normalized_brand_name = LOWER(TRIM(p_brand_name));
    SET @normalized_category_name = LOWER(TRIM(p_category_name));
    SET @normalized_product_name = LOWER(TRIM(p_product_name));
    SET @normalized_customer_first_name = LOWER(TRIM(p_customer_first_name));
    SET @normalized_customer_last_name = LOWER(TRIM(p_customer_last_name));
    SET @normalized_email = LOWER(TRIM(p_email));

    -- Get or Insert Brand
    SELECT brand_id INTO brandId
    FROM brands
    WHERE LOWER(TRIM(brand_name)) = @normalized_brand_name
    LIMIT 1;

    IF brandId IS NULL THEN
        INSERT INTO brands (brand_name) VALUES (p_brand_name);
        SET brandId = LAST_INSERT_ID();
    END IF;

    -- Get or Insert Category
    SELECT category_id INTO categoryId
    FROM categories
    WHERE LOWER(TRIM(category_name)) = @normalized_category_name
    LIMIT 1;

    IF categoryId IS NULL THEN
        INSERT INTO categories (category_name) VALUES (p_category_name);
        SET categoryId = LAST_INSERT_ID();
    END IF;

    -- Get or Insert Customer
    SELECT customer_id INTO customerId
    FROM customers
    WHERE LOWER(TRIM(first_name)) = @normalized_customer_first_name
      AND LOWER(TRIM(last_name)) = @normalized_customer_last_name
      AND LOWER(TRIM(email)) = @normalized_email
    LIMIT 1;

    IF customerId IS NULL THEN
        INSERT INTO customers (
            first_name,
            last_name,
            phone,
            email,
            street,
            city,
            state,
            zip_code
        ) VALUES (
            p_customer_first_name,
            p_customer_last_name,
            p_phone,
            p_email,
            p_street,
            p_city,
            p_state,
            p_zip_code
        );
        SET customerId = LAST_INSERT_ID();
    END IF;

    -- Get or Insert Product
    SELECT product_id INTO productId
    FROM products
    WHERE LOWER(TRIM(product_name)) = @normalized_product_name
      AND model_year = p_model_year
    LIMIT 1;

    IF productId IS NULL THEN
        INSERT INTO products (
            product_name,
            model_year,
            list_price,
            category_id,
            brand_id
        ) VALUES (
            p_product_name,
            p_model_year,
            p_list_price,
            categoryId,
            brandId
        );
        SET productId = LAST_INSERT_ID();
    END IF;

    -- Insert Order
    INSERT INTO orders (
        customer_id,
        order_status,
        order_date,
        required_date,
        shipped_date
    ) VALUES (
        customerId,
        p_order_status,
        p_order_date,
        p_required_date,
        p_shipped_date
    );

    -- Insert Order Item
    INSERT INTO order_items (
        order_id,
        product_id,
        quantity,
        list_price,
        discount
    ) VALUES (
        LAST_INSERT_ID(),
        productId,
        p_quantity,
        p_list_price,
        p_discount
    );
END $$

DELIMITER;

-- STORE PROCEDURE TO CREATE ANALYTICAL DATA WAREHOUSE
DROP PROCEDURE IF EXISTS create_product_sales;

DELIMITER $$

CREATE PROCEDURE create_product_sales()
BEGIN
    DROP TABLE IF EXISTS product_sales;

    CREATE TABLE product_sales AS
    SELECT
        -- id columns
        o.order_id,
        p.product_id,
        cu.customer_id,
        ca.category_id,
        -- order table
        o.order_status,
        o.required_date,
        o.shipped_date,
        -- order_items table
        oi.list_price,
        oi.quantity,
        oi.discount,
        -- products table
        p.product_name,
        p.model_year,
        -- customers table
        cu.first_name customer_first_name,
        cu.last_name customer_last_name,
        cu.zip_code customer_zip_code,
        -- categories table
        ca.category_name,
        -- brands table
        b.brand_name
    FROM
        orders o
        JOIN order_items oi USING (order_id)
        JOIN products p USING (product_id)
        JOIN customers cu USING (customer_id)
        JOIN categories ca USING (category_id)
        JOIN brands b USING (brand_id)
    ORDER BY o.required_date, cu.last_name;
END $$

DELIMITER;
