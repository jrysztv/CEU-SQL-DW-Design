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
  `category_name` VARCHAR(256) NULL DEFAULT NULL,
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
AUTO_INCREMENT = 1619
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
AUTO_INCREMENT = 9
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
  `category_name` VARCHAR(256) NULL DEFAULT NULL,
  `brand_name` VARCHAR(256) NULL DEFAULT NULL)
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


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
