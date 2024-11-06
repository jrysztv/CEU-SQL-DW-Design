USE bikestores;

-- CREATE ANALYTICAL VIEW
-- Aggregated Sales Performance
DROP VIEW IF EXISTS aggregated_sales_performance;

CREATE VIEW aggregated_sales_performance AS
SELECT
    product_id,
    product_name,
    YEAR(
        STR_TO_DATE(required_date, '%Y-%m-%d')
    ) AS year,
    category_name,
    brand_name,
    customer_zip_code, -- either geographical or yearly aggregates are possible
    model_year,
    COUNT(DISTINCT order_id) AS total_orders,
    SUM(
        list_price * quantity * (1 - discount)
    ) AS total_revenue,
    SUM(quantity) AS total_quantity,
    AVG(discount) AS average_discount,
    AVG(
        list_price * quantity * (1 - discount)
    ) AS average_order_value
FROM product_sales
GROUP BY
    product_id,
    product_name,
    category_name,
    brand_name,
    customer_zip_code,
    model_year,
    year;