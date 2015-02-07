Use Test;

CREATE TABLE IF NOT EXISTS `test`.`Tree` 
(
  `treeID` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `treeName` VARCHAR(20),
  `privacy` Boolean
);



-- -----------------------------------------------------
-- Table `ohana`.`Member`
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS `test`.`Member` (
  `treeID` INT NULL,
  `memberID` INT NOT NULL,
  `firstName` VARCHAR(35) NULL,
  `lastName` VARCHAR(50) NULL,
  `dateOfBirth` DATE NULL,
  `countryOfBirth` VARCHAR(20) NULL,
  `gender` VARCHAR(1) NULL,
  PRIMARY KEY (`treeID`, `memberID`),
  INDEX `idx_tree_member_id` (`treeID`, `memberID` ASC),
  CONSTRAINT `fk_tree_id`
    FOREIGN KEY (`treeID`)
    REFERENCES `test`.`Tree` (`treeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ohana`.`Relation`
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS `test`.`Relation` (
  `treeID` INT NOT NULL,
  `memberID` INT NOT NULL,
  `fatherID` INT NOT NULL,
  `motherID` INT NOT NULL,
  `spouseID` INT NULL,
  `spouseTreeID` INT NULL,
  PRIMARY KEY (`treeID`,`memberID`,`fatherID`,`motherID`),
  INDEX `idx_tree_member_ID` (`treeID`, `memberID` ASC),
  CONSTRAINT `fk_tree_member`
    FOREIGN KEY (`treeID`, `memberID`)
    REFERENCES `test`.`Member` (`treeID`, `memberID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
)
ENGINE = InnoDB;








CREATE TABLE IF NOT EXISTS `test`.`Coordinates` (
  
  `memberID` INT Primary key,
  `x` int,
  `y` int,
  `verticalHierarchy` int
);


SET SQL_SAFE_UPDATES=0;
delete  from coordinates;