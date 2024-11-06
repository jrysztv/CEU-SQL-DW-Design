# Project Documentation

## Table of Contents
- [Purpose of the project](#purpose-of-the-project)
    - [What kind of questions can be answered from the Data Warehouse](#what-kind-of-questions-can-be-answered-from-the-data-warehouse)
- [Reproduction](#reproduction)
    - [Demonstrating database routines](#demonstrating-database-routines)
- [Initial Data Tables](#initial-data-tables)
    - [The project-relative paths of the source database](#the-project-relative-paths-of-the-source-database)
    - [The structure of the initial database - `bikestores`](#the-structure-of-the-initial-database---bikestores)
- [Schema diagram of bikestores database](#schema-diagram-of-bikestores-database)
- [The Data Warehouse Table - `product_sales`](#the-data-warehouse-table---product_sales)
- [Routines](#routines)
    - [Events](#events)
    - [Triggers](#triggers)
    - [Stored Procedures](#stored-procedures)
    - [Views](#views)
    - [Materialized Views](#materialized-views)


## Purpose of the project
This project demonstrates relational database management by:
- Designing a Data Warehouse structure for analytical purposes
- Implementing routines for database management and querying:
    - Views for analytical data subsets
    - Stored procedures for streamlined operations
    - Events to automate procedure execution

### Questions Answered by the Data Warehouse
The Data Warehouse supports analysis on sales, customer behavior, product performance, and geographical trends, particularly:
- **Aggregated Sales Performance**
    - Revenue and order volume for products, categories, and brands.
    - Sales metrics (total orders, quantity, average order value) by year and region.
    - Implemented as a view as `aggregated_sales_performance`

- **Yearly Geographical Sales Trends**
    - Top regions by annual sales volume.
    - Revenue variation by zip code, category, and brand.
    - Implemented as a materialized data table as geographical_sales_materialized

Other analyses:
- **Customer Insights**: Top customers by frequency and spend.
- **Product Popularity**: Popular products by region.
- **Order Fulfillment**: Average shipping times and delays.
- **Discount Effectiveness**: Revenue impact of discounts by region.
- **Time-Based Sales Trends**: Monthly and annual sales volume trends.

## Reproduction
- `db_reproduction` folder: Files for initial data and schema setup.
- `routines` folder: Files to reproduce routines (stored procedures, views, events, triggers).

### Demonstrating Database Routines
Due to MySQL import limitations, an SQL dump recreates the entire database (data and routines).
1. `bikestores_dump_data_routines.sql` - Sets up the database.
2. `call_routines.sql` - Calls stored procedures to examine views.

## Initial Data Tables
Description of source database tables: [Kaggle: Bike Store Database](https://www.kaggle.com/datasets/dillonmyrick/bike-store-sample-database).

### Source Database Paths
| Table           | File Path                                      |
|-----------------|------------------------------------------------|
| `brands`        | `db_reproduction/data/brands.csv`             |
| `categories`    | `db_reproduction/data/categories.csv`         |
| `customers`     | `db_reproduction/data/customers.csv`          |
| `order_items`   | `db_reproduction/data/order_items.csv`        |
| `orders`        | `db_reproduction/data/orders.csv`             |
| `products`      | `db_reproduction/data/products.csv`           |
| `staffs`        | `db_reproduction/data/staffs.csv`             |
| `stocks`        | `db_reproduction/data/stocks.csv`             |
| `stores`        | `db_reproduction/data/stores.csv`             |

### Database Structure - `bikestores`
| Table                          | Column               | Type            | Nullable | Key                 | Default     | Extra                     |
|--------------------------------|----------------------|-----------------|----------|---------------------|-------------|---------------------------|
| `brands`                       | `brand_id`          | INT             | NO       | PRIMARY, UNIQUE     |             | AUTO_INCREMENT            |
|                                | `brand_name`        | VARCHAR(256)    | NO       | UNIQUE              |             |                           |
| `categories`                   | `category_id`       | INT             | NO       | PRIMARY, UNIQUE     |             | AUTO_INCREMENT            |
|                                | `category_name`     | VARCHAR(256)    | NO       | UNIQUE              |             |                           |
| `customers`                    | `customer_id`       | INT             | NO       | PRIMARY             |             | AUTO_INCREMENT            |
|                                | `first_name`        | VARCHAR(256)    | YES      |                     | NULL        |                           |
|                                | `last_name`         | VARCHAR(256)    | YES      |                     | NULL        |                           |
|                                | `phone`             | VARCHAR(256)    | YES      |                     | NULL        |                           |
|                                | `email`             | VARCHAR(256)    | YES      |                     | NULL        |                           |
|                                | `street`            | VARCHAR(256)    | YES      |                     | NULL        |                           |
|                                | `city`              | VARCHAR(256)    | YES      |                     | NULL        |                           |
|                                | `state`             | VARCHAR(256)    | YES      |                     | NULL        |                           |
|                                | `zip_code`          | VARCHAR(256)    | YES      |                     | NULL        |                           |
| `stores`                       | `store_id`          | INT             | NO       | PRIMARY             |             | AUTO_INCREMENT            |
|                                | `store_name`        | VARCHAR(256)    | YES      |                     | NULL        |                           |
|                                | `phone`             | VARCHAR(256)    | YES      |                     | NULL        |                           |
|                                | `email`             | VARCHAR(256)    | YES      |                     | NULL        |                           |
|                                | `street`            | VARCHAR(256)    | YES      |                     | NULL        |                           |
|                                | `city`              | VARCHAR(256)    | YES      |                     | NULL        |                           |
|                                | `state`             | VARCHAR(256)    | YES      |                     | NULL        |                           |
|                                | `zip_code`          | INT             | YES      |                     | NULL        |                           |
| `staffs`                       | `staff_id`          | INT             | NO       | PRIMARY             |             | AUTO_INCREMENT            |
|                                | `store_id`          | INT             | YES      | FK - `stores`       | NULL        |                           |
|                                | `manager_id`        | INT             | YES      | FK - `staffs`       | NULL        |                           |
|                                | `first_name`        | VARCHAR(256)    | YES      |                     | NULL        |                           |
|                                | `last_name`         | VARCHAR(256)    | YES      |                     | NULL        |                           |
|                                | `email`             | VARCHAR(256)    | YES      |                     | NULL        |                           |
|                                | `phone`             | VARCHAR(256)    | YES      |                     | NULL        |                           |
|                                | `active`            | VARCHAR(256)    | YES      |                     | NULL        |                           |
| `orders`                       | `order_id`          | INT             | NO       | PRIMARY             |             | AUTO_INCREMENT            |
|                                | `customer_id`       | INT             | YES      | FK - `customers`    | NULL        |                           |
|                                | `staff_id`          | INT             | YES      | FK - `staffs`       | NULL        |                           |
|                                | `store_id`          | INT             | YES      | FK - `stores`       | NULL        |                           |
|                                | `order_status`      | INT             | YES      |                     | NULL        |                           |
|                                | `order_date`        | VARCHAR(256)    | YES      |                     | NULL        |                           |
|                                | `required_date`     | VARCHAR(256)    | YES      |                     | NULL        |                           |
|                                | `shipped_date`      | VARCHAR(256)    | YES      |                     | NULL        |                           |
| `products`                     | `product_id`        | INT             | NO       | PRIMARY             |             | AUTO_INCREMENT            |
|                                | `category_id`       | INT             | YES      | FK - `categories`   | NULL        |                           |
|                                | `brand_id`          | INT             | YES      | FK - `brands`       | NULL        |                           |
|                                | `product_name`      | VARCHAR(256)    | YES      |                     | NULL        |                           |
|                                | `model_year`        | VARCHAR(256)    | YES      |                     | NULL        |                           |
|                                | `list_price`        | FLOAT           | YES      |                     | NULL        |                           |
| `order_items`                  | `item_id`           | INT             | NO       | PRIMARY             |             | AUTO_INCREMENT            |
|                                | `order_id`          | INT             | NO       | FK - `orders`       |             |                           |
|                                | `product_id`        | INT             | YES      | FK - `products`     | NULL        |                           |
|                                | `quantity`          | INT             | YES      |                     | NULL        |                           |
|                                | `list_price`        | FLOAT           | YES      |                     | NULL        |                           |
|                                | `discount`          | FLOAT           | YES      |                     | NULL        |                           |
| `stocks`                       | `store_id`          | INT             | NO       | FK - `stores`       |             |                           |
|                                | `product_id`        | INT             | NO       | FK - `products`     |             |                           |
|                                | `quantity`          | INT             | YES      |                     | NULL        |                           |
---

### Database Schema Diagram
![Database Schema](images\bikestores_db_schema_diagram.png)
- `geographical_sales_materialized` and `product_sales` are also visible as disjointed tables
- `aggregated_sales_performance` view is also mentioned.

## Data Warehouse Table - `product_sales`
Generated and re-generated via `create_product_sales()`, this table consolidates data from various sources for a unified view of sales. It is updated by:
- Trigger: `after_order_item_insert` - adds new order data.
- Event: `update_data_warehouse_daily` - runs daily at 6 AM.
The `create_product_sales()` procedure performs the following actions:
1. Drops the existing `product_sales` table if it exists, ensuring a fresh start.
2. Creates a new `product_sales` table using a `SELECT` statement that joins data from multiple source tables: `orders`, `order_items`, `products`, `customers`, `categories`, and `brands`.
3. Orders the results by `required_date` and `customer_last_name` to facilitate time-series and customer-based analyses.

**Key Columns and Data Sources**
- **Order Data (`orders` table)**:
    - `order_id`: Unique identifier for each order.
    - `order_status`: Status of the order.
    - `required_date`, `shipped_date`: Delivery and shipping dates for tracking fulfillment times.

- **Product Information (`products` table)**:
    - `product_id`: Unique identifier for each product.
    - `product_name`, `model_year`: Name and model year for product lifecycle analysis.

- **Order Item Details (`order_items` table)**:
    - `list_price`, `quantity`, `discount`: Price, quantity, and any discount applied, allowing revenue and discount analysis.

- **Customer Information (`customers` table)**:
    - `customer_id`: Unique identifier for each customer.
    - `customer_first_name`, `customer_last_name`, `customer_zip_code`: Customer demographics for regional and personalized insights.

- **Category and Brand (`categories` and `brands` tables)**:
    - `category_id`, `category_name`: Product category, enabling category-level performance analysis.
    - `brand_name`: Brand name, facilitating brand-level trend analysis.

### Summary
| Column                  | Type           | Nullable | Description                                  |
|-------------------------|----------------|----------|----------------------------------------------|
| `order_id`              | INT            | NO       | Identifier for the order                     |
| `product_id`            | INT            | NO       | Identifier for the product                   |
| `customer_id`           | INT            | NO       | Identifier for the customer                  |
| `category_id`           | INT            | NO       | Identifier for the product category          |
| `order_status`          | INT            | YES      | Status of the order                          |
| `required_date`         | VARCHAR(256)   | YES      | Date the order is required                   |
| `shipped_date`          | VARCHAR(256)   | YES      | Date the order was shipped                   |
| `list_price`            | FLOAT          | YES      | Listed price of the product                  |
| `quantity`              | INT            | YES      | Quantity ordered                             |
| `discount`              | FLOAT          | YES      | Discount applied to the product              |
| `product_name`          | VARCHAR(256)   | YES      | Name of the product                          |
| `model_year`            | VARCHAR(256)   | YES      | Model year of the product                    |
| `customer_first_name`   | VARCHAR(256)   | YES      | First name of the customer                   |
| `customer_last_name`    | VARCHAR(256)   | YES      | Last name of the customer                    |
| `customer_zip_code`     | VARCHAR(256)   | YES      | Zip code of the customer                     |
| `category_name`         | VARCHAR(256)   | YES      | Name of the product category                 |
| `brand_name`            | VARCHAR(256)   | YES      | Name of the product brand                    |

## Routines
Below are mentioned the descriptions of Routines. The table `geographical_sales_materialized` is mentioned here, since it serves as a materialized view.
The relative path of the reproductive code is also mentioned.

### Events
- `update_data_warehouse_daily`: Updates the data warehouse every day at 6 am. (`routines\events.sql`)
- `refresh_geographical_sales`: Updates the geographical sales materialized view every day at 6 am, 12 pm, and 5 pm. (`routines\events.sql`)

### Triggers
- Trigger to update `product_sales` table when new orders are inserted. (`routines\triggers.sql`)

### Stored Procedures
- `populate_database`: Populates the database with initial data. (`routines\stored_procedures.sql`)
- `create_product_sales`: Creates the `product_sales` table with aggregated data. (`routines\stored_procedures.sql`)
- `create_geographical_sales_materialized`: Creates the `geographical_sales_materialized` table with aggregated data. (`routines\materialized_views_procedures.sql`)

### Views
- `aggregated_sales_performance`: Aggregated sales performance view. (`routines\views.sql`)

### Materialized Views
- `geographical_sales_materialized`: Geographical sales performance materialized view. created by `create_geographical_sales_materialized`. (`routines\materialized_views_procedures.sql`)