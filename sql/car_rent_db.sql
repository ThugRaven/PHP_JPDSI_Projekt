-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema car_rent_db
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `car_rent_db` ;

-- -----------------------------------------------------
-- Schema car_rent_db
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `car_rent_db` DEFAULT CHARACTER SET utf8 COLLATE utf8_polish_ci ;
USE `car_rent_db` ;

-- -----------------------------------------------------
-- Table `car_rent_db`.`role`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `car_rent_db`.`role` ;

CREATE TABLE IF NOT EXISTS `car_rent_db`.`role` (
  `id_role` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  PRIMARY KEY (`id_role`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `car_rent_db`.`user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `car_rent_db`.`user` ;

CREATE TABLE IF NOT EXISTS `car_rent_db`.`user` (
  `id_user` INT NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(255) NOT NULL,
  `password` CHAR(60) NOT NULL,
  `id_role` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `surname` VARCHAR(45) NOT NULL,
  `phone_number` VARCHAR(45) NOT NULL,
  `verified` TINYINT(1) NOT NULL,
  `birth_date` DATE NOT NULL,
  `create_time` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_user`, `id_role`),
  CONSTRAINT `fk_user_role`
    FOREIGN KEY (`id_role`)
    REFERENCES `car_rent_db`.`role` (`id_role`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_user_role_idx` ON `car_rent_db`.`user` (`id_role` ASC);


-- -----------------------------------------------------
-- Table `car_rent_db`.`car_price`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `car_rent_db`.`car_price` ;

CREATE TABLE IF NOT EXISTS `car_rent_db`.`car_price` (
  `id_car_price` INT NOT NULL AUTO_INCREMENT,
  `price_deposit` TINYINT(5) NOT NULL,
  `price_no_deposit` TINYINT(5) NOT NULL,
  `multiplier` FLOAT NOT NULL,
  `km_limit` TINYINT(5) NOT NULL,
  `deposit` TINYINT(5) NOT NULL,
  `additional_km` TINYINT(1) NOT NULL,
  PRIMARY KEY (`id_car_price`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `car_rent_db`.`car`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `car_rent_db`.`car` ;

CREATE TABLE IF NOT EXISTS `car_rent_db`.`car` (
  `id_car` INT NOT NULL AUTO_INCREMENT,
  `id_car_price` INT NOT NULL,
  `license_plate` VARCHAR(15) NOT NULL,
  `mileage` INT NOT NULL,
  `brand` VARCHAR(45) NOT NULL,
  `model` VARCHAR(45) NOT NULL,
  `production_year` YEAR(4) NOT NULL,
  `eng_power` INT NOT NULL,
  `eng_torque` INT NOT NULL,
  `eng_type` VARCHAR(45) NOT NULL,
  `eng_displacement` FLOAT NOT NULL,
  `drive` VARCHAR(10) NOT NULL,
  `100_time` FLOAT NULL,
  `top_speed` SMALLINT(3) NULL,
  `fuel_type` VARCHAR(5) NOT NULL,
  `transmission_type` VARCHAR(15) NOT NULL,
  `doors` TINYINT(1) NULL,
  `seats` TINYINT(1) NULL,
  `weight` INT NULL,
  `fuel_capacity` TINYINT(3) NULL,
  `fuel_consumption` FLOAT NULL,
  PRIMARY KEY (`id_car`, `id_car_price`),
  CONSTRAINT `fk_car_rent_price`
    FOREIGN KEY (`id_car_price`)
    REFERENCES `car_rent_db`.`car_price` (`id_car_price`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE UNIQUE INDEX `license_plate_UNIQUE` ON `car_rent_db`.`car` (`license_plate` ASC);

CREATE INDEX `fk_car_rent_price_idx` ON `car_rent_db`.`car` (`id_car_price` ASC);


-- -----------------------------------------------------
-- Table `car_rent_db`.`rent_status`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `car_rent_db`.`rent_status` ;

CREATE TABLE IF NOT EXISTS `car_rent_db`.`rent_status` (
  `id_rent_status` INT NOT NULL AUTO_INCREMENT,
  `status` VARCHAR(45) NULL,
  PRIMARY KEY (`id_rent_status`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `car_rent_db`.`rent`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `car_rent_db`.`rent` ;

CREATE TABLE IF NOT EXISTS `car_rent_db`.`rent` (
  `id_rent` INT NOT NULL AUTO_INCREMENT,
  `id_car` INT NOT NULL,
  `id_user` INT NOT NULL,
  `rent_start` DATETIME NULL,
  `rent_end` DATETIME NULL,
  `id_rent_status` INT NOT NULL,
  `total_price` INT NULL,
  PRIMARY KEY (`id_rent`, `id_car`, `id_user`, `id_rent_status`),
  CONSTRAINT `fk_rent_car`
    FOREIGN KEY (`id_car`)
    REFERENCES `car_rent_db`.`car` (`id_car`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_rent_user`
    FOREIGN KEY (`id_user`)
    REFERENCES `car_rent_db`.`user` (`id_user`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_rent_status`
    FOREIGN KEY (`id_rent_status`)
    REFERENCES `car_rent_db`.`rent_status` (`id_rent_status`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_rent_car_idx` ON `car_rent_db`.`rent` (`id_car` ASC);

CREATE INDEX `fk_rent_user_idx` ON `car_rent_db`.`rent` (`id_user` ASC);

CREATE INDEX `fk_rent_status_idx` ON `car_rent_db`.`rent` (`id_rent_status` ASC);


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
