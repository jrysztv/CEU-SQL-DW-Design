USE bikestores;

-- Create a trigger to insert a new row into product_sales after a new order is inserted
-- The trigger will insert a new row into product_sales for each new row in order_items
-- An event is scheduled to recreate the product_sales table every day at 6 am to ensure reliability
DROP TRIGGER IF EXISTS after_order_item_insert;

DELIMITER $$

CREATE TRIGGER after_order_item_insert
AFTER INSERT ON order_items
FOR EACH ROW
BEGIN
    INSERT INTO product_sales (
        order_id,
        product_id,
        customer_id,
        category_id,
        order_status,
        required_date,
        shipped_date,
        list_price,
        quantity,
        discount,
        product_name,
        model_year,
        customer_first_name,
        customer_last_name,
        customer_zip_code,
        category_name,
        brand_name
    )
    SELECT 
        o.order_id,
        NEW.product_id,
        o.customer_id,
        p.category_id,
        o.order_status,
        o.required_date,
        o.shipped_date,
        NEW.list_price,
        NEW.quantity,
        NEW.discount,
        p.product_name,
        p.model_year,
        cu.first_name,
        cu.last_name,
        cu.zip_code,
        ca.category_name,
        b.brand_name
    FROM
        orders o
        JOIN products p ON NEW.product_id = p.product_id
        JOIN customers cu ON o.customer_id = cu.customer_id
        JOIN categories ca ON p.category_id = ca.category_id
        JOIN brands b ON p.brand_id = b.brand_id
    WHERE
        o.order_id = NEW.order_id;
END $$

DELIMITER;
