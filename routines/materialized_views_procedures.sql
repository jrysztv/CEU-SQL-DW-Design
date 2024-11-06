USE bikestores;

-- CREATE MATERIALIZED VIEWS
-- Geographical Sales Performance
DROP PROCEDURE IF EXISTS create_geographical_sales_materialized;

DELIMITER $$

CREATE PROCEDURE create_geographical_sales_materialized()
BEGIN
    -- Drop the table if it already exists
    DROP TABLE IF EXISTS geographical_sales_materialized;

    -- Create the materialized table with aggregated data
    CREATE TABLE geographical_sales_materialized AS
    SELECT 
        customer_zip_code,
        category_name,
        YEAR(STR_TO_DATE(shipped_date, '%Y-%m-%d')) AS year,
        COUNT(DISTINCT order_id) AS total_orders,
        SUM(list_price * quantity * (1 - discount)) AS total_revenue,
        AVG(list_price * quantity * (1 - discount)) AS average_order_value
    FROM product_sales
    WHERE YEAR(STR_TO_DATE(shipped_date, '%Y-%m-%d')) IS NOT NULL
    GROUP BY customer_zip_code, category_name, year
    ORDER BY year, category_name ASC;
END $$

DELIMITER;