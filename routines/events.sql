USE bikestores;

-- CREATE EVENTS

-- Schedule an event to update the data warehouse every day at 6 am
DROP EVENT IF EXISTS update_data_warehouse_daily;

DELIMITER $$

CREATE EVENT update_data_warehouse_daily
ON SCHEDULE EVERY 1 DAY
STARTS CURRENT_DATE + INTERVAL 6 HOUR -- every day at 6 am
DO
BEGIN
    CALL create_product_sales();
END $$

DELIMITER;

-- Schedule an event to update the geographical sales materialized view every day at 6 am, 12 pm, and 5 pm

DROP EVENT IF EXISTS refresh_geographical_sales;

DELIMITER $$

CREATE EVENT refresh_geographical_sales
ON SCHEDULE EVERY 1 HOUR
STARTS CURRENT_DATE
ON COMPLETION PRESERVE
DO
BEGIN
    -- Run the recreation logic at 6 AM, 12 PM, and 5 PM
    IF HOUR(CURRENT_TIME()) IN (6, 12, 17) THEN
        CALL create_geographical_sales_materialized();
    END IF;
END $$

DELIMITER ;
