USE bikestores;

SET GLOBAL event_scheduler = ON;

-- Creating the product_sales table outside the event for demonstration purposes
CALL create_product_sales ();

-- SIMULATED OPERATIONAL LAYER
CALL populate_database (
    -- Added existing category and brand.
    'Electra',
    'Children Bicycles',
    'John',
    'Doe',
    '1234567890',
    'john.doe@example.com',
    '123 Street',
    'CityName',
    'StateName',
    '12345',
    'ProductName',
    '2023',
    100.0,
    -- list price
    1,
    -- order status
    '2024-11-01',
    '2024-11-05',
    '2024-11-4',
    5,
    0.1
);

-- Now, the product_sales is already updated by the trigger. (Check for largest order_id)

-- Update the product_sales table after populating the database to reflect the changes
CALL create_product_sales ();

-- Creating materialized view for geographical sales performance outside the event for demonstration purposes
CALL create_geographical_sales_materialized ();

-- Aggregated Sales Performance View
-- no way to get around creating the view, the dump does not recreate the view sadly.

SELECT * FROM aggregated_sales_performance;

-- Geographical Sales Performance Materialized View
SELECT * FROM geographical_sales_materialized;