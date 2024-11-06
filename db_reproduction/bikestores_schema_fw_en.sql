-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema bikestores
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema bikestores
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `bikestores` DEFAULT CHARACTER SET utf8mb3 ;
USE `bikestores` ;

-- -----------------------------------------------------
-- Table `bikestores`.`brands`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bikestores`.`brands` ;

CREATE TABLE IF NOT EXISTS `bikestores`.`brands` (
  `brand_id` INT NOT NULL AUTO_INCREMENT,
  `brand_name` VARCHAR(256) NOT NULL,
  PRIMARY KEY (`brand_id`),
  UNIQUE INDEX `brand_name_UNIQUE` (`brand_name` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 13
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `bikestores`.`categories`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bikestores`.`categories` ;

CREATE TABLE IF NOT EXISTS `bikestores`.`categories` (
  `category_id` INT NOT NULL AUTO_INCREMENT,
  `category_name` VARCHAR(256) NOT NULL,
  PRIMARY KEY (`category_id`),
  UNIQUE INDEX `category_name_UNIQUE` (`category_name` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 11
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `bikestores`.`customers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bikestores`.`customers` ;

CREATE TABLE IF NOT EXISTS `bikestores`.`customers` (
  `customer_id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(256) NULL DEFAULT NULL,
  `last_name` VARCHAR(256) NULL DEFAULT NULL,
  `phone` VARCHAR(256) NULL DEFAULT NULL,
  `email` VARCHAR(256) NULL DEFAULT NULL,
  `street` VARCHAR(256) NULL DEFAULT NULL,
  `city` VARCHAR(256) NULL DEFAULT NULL,
  `state` VARCHAR(256) NULL DEFAULT NULL,
  `zip_code` VARCHAR(256) NULL DEFAULT NULL,
  PRIMARY KEY (`customer_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 1448
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `bikestores`.`geographical_sales_materialized`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bikestores`.`geographical_sales_materialized` ;

CREATE TABLE IF NOT EXISTS `bikestores`.`geographical_sales_materialized` (
  `customer_zip_code` VARCHAR(256) NULL DEFAULT NULL,
  `category_name` VARCHAR(256) NOT NULL,
  `year` INT NULL DEFAULT NULL,
  `total_orders` BIGINT NOT NULL DEFAULT '0',
  `total_revenue` DOUBLE NULL DEFAULT NULL,
  `average_order_value` DOUBLE NULL DEFAULT NULL)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `bikestores`.`stores`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bikestores`.`stores` ;

CREATE TABLE IF NOT EXISTS `bikestores`.`stores` (
  `store_id` INT NOT NULL AUTO_INCREMENT,
  `store_name` VARCHAR(256) NULL DEFAULT NULL,
  `phone` VARCHAR(256) NULL DEFAULT NULL,
  `email` VARCHAR(256) NULL DEFAULT NULL,
  `street` VARCHAR(256) NULL DEFAULT NULL,
  `city` VARCHAR(256) NULL DEFAULT NULL,
  `state` VARCHAR(256) NULL DEFAULT NULL,
  `zip_code` INT NULL DEFAULT NULL,
  PRIMARY KEY (`store_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `bikestores`.`staffs`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bikestores`.`staffs` ;

CREATE TABLE IF NOT EXISTS `bikestores`.`staffs` (
  `staff_id` INT NOT NULL AUTO_INCREMENT,
  `store_id` INT NULL DEFAULT NULL,
  `manager_id` INT NULL DEFAULT NULL,
  `first_name` VARCHAR(256) NULL DEFAULT NULL,
  `last_name` VARCHAR(256) NULL DEFAULT NULL,
  `email` VARCHAR(256) NULL DEFAULT NULL,
  `phone` VARCHAR(256) NULL DEFAULT NULL,
  `active` VARCHAR(256) NULL DEFAULT NULL,
  PRIMARY KEY (`staff_id`),
  INDEX `fk_staffs_stores1_idx` (`store_id` ASC) VISIBLE,
  INDEX `fk_staffs_staffs1_idx` (`manager_id` ASC) VISIBLE,
  CONSTRAINT `fk_staffs_staffs1`
    FOREIGN KEY (`manager_id`)
    REFERENCES `bikestores`.`staffs` (`staff_id`),
  CONSTRAINT `fk_staffs_stores1`
    FOREIGN KEY (`store_id`)
    REFERENCES `bikestores`.`stores` (`store_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 11
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `bikestores`.`orders`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bikestores`.`orders` ;

CREATE TABLE IF NOT EXISTS `bikestores`.`orders` (
  `order_id` INT NOT NULL AUTO_INCREMENT,
  `customer_id` INT NULL DEFAULT NULL,
  `staff_id` INT NULL DEFAULT NULL,
  `store_id` INT NULL DEFAULT NULL,
  `order_status` INT NULL DEFAULT NULL,
  `order_date` VARCHAR(256) NULL DEFAULT NULL,
  `required_date` VARCHAR(256) NULL DEFAULT NULL,
  `shipped_date` VARCHAR(256) NULL DEFAULT NULL,
  PRIMARY KEY (`order_id`),
  INDEX `fk_orders_customers_idx` (`customer_id` ASC) VISIBLE,
  INDEX `fk_orders_staffs1_idx` (`staff_id` ASC) VISIBLE,
  INDEX `fk_orders_stores1_idx` (`store_id` ASC) VISIBLE,
  CONSTRAINT `fk_orders_customers`
    FOREIGN KEY (`customer_id`)
    REFERENCES `bikestores`.`customers` (`customer_id`),
  CONSTRAINT `fk_orders_staffs1`
    FOREIGN KEY (`staff_id`)
    REFERENCES `bikestores`.`staffs` (`staff_id`),
  CONSTRAINT `fk_orders_stores1`
    FOREIGN KEY (`store_id`)
    REFERENCES `bikestores`.`stores` (`store_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 1621
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `bikestores`.`products`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bikestores`.`products` ;

CREATE TABLE IF NOT EXISTS `bikestores`.`products` (
  `product_id` INT NOT NULL AUTO_INCREMENT,
  `category_id` INT NULL DEFAULT NULL,
  `brand_id` INT NULL DEFAULT NULL,
  `product_name` VARCHAR(256) NULL DEFAULT NULL,
  `model_year` VARCHAR(256) NULL DEFAULT NULL,
  `list_price` FLOAT NULL DEFAULT NULL,
  PRIMARY KEY (`product_id`),
  INDEX `fk_products_categories1_idx` (`category_id` ASC) VISIBLE,
  INDEX `fk_products_brands1_idx` (`brand_id` ASC) VISIBLE,
  CONSTRAINT `fk_products_brands1`
    FOREIGN KEY (`brand_id`)
    REFERENCES `bikestores`.`brands` (`brand_id`),
  CONSTRAINT `fk_products_categories1`
    FOREIGN KEY (`category_id`)
    REFERENCES `bikestores`.`categories` (`category_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 324
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `bikestores`.`order_items`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bikestores`.`order_items` ;

CREATE TABLE IF NOT EXISTS `bikestores`.`order_items` (
  `item_id` INT NOT NULL AUTO_INCREMENT,
  `order_id` INT NOT NULL,
  `product_id` INT NULL DEFAULT NULL,
  `quantity` INT NULL DEFAULT NULL,
  `list_price` FLOAT NULL DEFAULT NULL,
  `discount` FLOAT NULL DEFAULT NULL,
  PRIMARY KEY (`item_id`, `order_id`),
  INDEX `fk_order_items_orders1_idx` (`order_id` ASC) VISIBLE,
  INDEX `fk_order_items_products1_idx` (`product_id` ASC) VISIBLE,
  CONSTRAINT `fk_order_items_orders1`
    FOREIGN KEY (`order_id`)
    REFERENCES `bikestores`.`orders` (`order_id`),
  CONSTRAINT `fk_order_items_products1`
    FOREIGN KEY (`product_id`)
    REFERENCES `bikestores`.`products` (`product_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 11
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `bikestores`.`product_sales`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bikestores`.`product_sales` ;

CREATE TABLE IF NOT EXISTS `bikestores`.`product_sales` (
  `order_id` INT NOT NULL DEFAULT '0',
  `product_id` INT NOT NULL DEFAULT '0',
  `customer_id` INT NOT NULL DEFAULT '0',
  `category_id` INT NOT NULL DEFAULT '0',
  `order_status` INT NULL DEFAULT NULL,
  `required_date` VARCHAR(256) NULL DEFAULT NULL,
  `shipped_date` VARCHAR(256) NULL DEFAULT NULL,
  `list_price` FLOAT NULL DEFAULT NULL,
  `quantity` INT NULL DEFAULT NULL,
  `discount` FLOAT NULL DEFAULT NULL,
  `product_name` VARCHAR(256) NULL DEFAULT NULL,
  `model_year` VARCHAR(256) NULL DEFAULT NULL,
  `customer_first_name` VARCHAR(256) NULL DEFAULT NULL,
  `customer_last_name` VARCHAR(256) NULL DEFAULT NULL,
  `customer_zip_code` VARCHAR(256) NULL DEFAULT NULL,
  `category_name` VARCHAR(256) NOT NULL,
  `brand_name` VARCHAR(256) NOT NULL)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `bikestores`.`stocks`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bikestores`.`stocks` ;

CREATE TABLE IF NOT EXISTS `bikestores`.`stocks` (
  `store_id` INT NOT NULL AUTO_INCREMENT,
  `product_id` INT NOT NULL,
  `quantity` INT NULL DEFAULT NULL,
  PRIMARY KEY (`store_id`, `product_id`),
  INDEX `fk_stocks_stores1_idx` (`store_id` ASC) VISIBLE,
  INDEX `fk_stocks_products1_idx` (`product_id` ASC) VISIBLE,
  CONSTRAINT `fk_stocks_products1`
    FOREIGN KEY (`product_id`)
    REFERENCES `bikestores`.`products` (`product_id`),
  CONSTRAINT `fk_stocks_stores1`
    FOREIGN KEY (`store_id`)
    REFERENCES `bikestores`.`stores` (`store_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8mb3;

USE `bikestores` ;

-- -----------------------------------------------------
-- Placeholder table for view `bikestores`.`aggregated_sales_performance`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bikestores`.`aggregated_sales_performance` (`product_id` INT, `product_name` INT, `year` INT, `category_name` INT, `brand_name` INT, `customer_zip_code` INT, `model_year` INT, `total_orders` INT, `total_revenue` INT, `total_quantity` INT, `average_discount` INT, `average_order_value` INT);

-- -----------------------------------------------------
-- procedure create_geographical_sales_materialized
-- -----------------------------------------------------

USE `bikestores`;
DROP procedure IF EXISTS `bikestores`.`create_geographical_sales_materialized`;

DELIMITER $$
USE `bikestores`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `create_geographical_sales_materialized`()
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
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure create_product_sales
-- -----------------------------------------------------

USE `bikestores`;
DROP procedure IF EXISTS `bikestores`.`create_product_sales`;

DELIMITER $$
USE `bikestores`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `create_product_sales`()
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
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure populate_database
-- -----------------------------------------------------

USE `bikestores`;
DROP procedure IF EXISTS `bikestores`.`populate_database`;

DELIMITER $$
USE `bikestores`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `populate_database`(
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
END$$

DELIMITER ;

-- -----------------------------------------------------
-- View `bikestores`.`aggregated_sales_performance`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bikestores`.`aggregated_sales_performance`;
DROP VIEW IF EXISTS `bikestores`.`aggregated_sales_performance` ;
USE `bikestores`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `bikestores`.`aggregated_sales_performance` AS select `bikestores`.`product_sales`.`product_id` AS `product_id`,`bikestores`.`product_sales`.`product_name` AS `product_name`,year(str_to_date(`bikestores`.`product_sales`.`required_date`,'%Y-%m-%d')) AS `year`,`bikestores`.`product_sales`.`category_name` AS `category_name`,`bikestores`.`product_sales`.`brand_name` AS `brand_name`,`bikestores`.`product_sales`.`customer_zip_code` AS `customer_zip_code`,`bikestores`.`product_sales`.`model_year` AS `model_year`,count(distinct `bikestores`.`product_sales`.`order_id`) AS `total_orders`,sum(((`bikestores`.`product_sales`.`list_price` * `bikestores`.`product_sales`.`quantity`) * (1 - `bikestores`.`product_sales`.`discount`))) AS `total_revenue`,sum(`bikestores`.`product_sales`.`quantity`) AS `total_quantity`,avg(`bikestores`.`product_sales`.`discount`) AS `average_discount`,avg(((`bikestores`.`product_sales`.`list_price` * `bikestores`.`product_sales`.`quantity`) * (1 - `bikestores`.`product_sales`.`discount`))) AS `average_order_value` from `bikestores`.`product_sales` group by `bikestores`.`product_sales`.`product_id`,`bikestores`.`product_sales`.`product_name`,`bikestores`.`product_sales`.`category_name`,`bikestores`.`product_sales`.`brand_name`,`bikestores`.`product_sales`.`customer_zip_code`,`bikestores`.`product_sales`.`model_year`,`year`;
USE `bikestores`;

DELIMITER $$

USE `bikestores`$$
DROP TRIGGER IF EXISTS `bikestores`.`after_order_item_insert` $$
USE `bikestores`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `bikestores`.`after_order_item_insert`
AFTER INSERT ON `bikestores`.`order_items`
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
END$$


DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
