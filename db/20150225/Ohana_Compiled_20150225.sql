CREATE DATABASE  IF NOT EXISTS `ohana` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `ohana`;
-- MySQL dump 10.13  Distrib 5.6.17, for osx10.6 (i386)
--
-- Host: localhost    Database: ohana
-- ------------------------------------------------------
-- Server version	5.6.20

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `Coordinates`
--

DROP TABLE IF EXISTS `Coordinates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Coordinates` (
  `memberID` int(11) NOT NULL,
  `fatherID` int(11) DEFAULT NULL,
  `motherID` int(11) DEFAULT NULL,
  `spouseID` int(11) DEFAULT NULL,
  `x` int(11) DEFAULT NULL,
  `y` int(11) DEFAULT NULL,
  `treeID` int(11) DEFAULT NULL,
  `spouseTreeID` int(11) DEFAULT NULL,
  PRIMARY KEY (`memberID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Member`
--

DROP TABLE IF EXISTS `Member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Member` (
  `memberID` int(11) NOT NULL,
  `firstName` varchar(35) DEFAULT NULL,
  `lastName` varchar(50) DEFAULT NULL,
  `dateOfBirth` date DEFAULT NULL,
  `placeOfBirth` varchar(100) DEFAULT NULL,
  `gender` varchar(1) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `inviteStatus` varchar(10) DEFAULT NULL,
  `vitalStatus` tinyint(1) DEFAULT NULL,
  `treeID` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`memberID`,`treeID`),
  KEY `idx_tree_member_id` (`treeID`,`memberID`),
  KEY `fk_treeID_idx` (`treeID`),
  CONSTRAINT `treeID` FOREIGN KEY (`treeID`) REFERENCES `Tree` (`treeID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Member_Image`
--

DROP TABLE IF EXISTS `Member_Image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Member_Image` (
  `image` longblob,
  `type` varchar(20) DEFAULT NULL,
  `memberID` int(11) NOT NULL,
  `treeID` int(11) NOT NULL,
  PRIMARY KEY (`treeID`,`memberID`),
  KEY `fk_tree_member_img` (`memberID`,`treeID`),
  CONSTRAINT `fk_tree_member_img` FOREIGN KEY (`memberID`, `treeID`) REFERENCES `Member` (`memberID`, `treeID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Relation`
--

DROP TABLE IF EXISTS `Relation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Relation` (
  `treeID` int(11) NOT NULL,
  `memberID` int(11) NOT NULL,
  `fatherID` int(11) NOT NULL,
  `motherID` int(11) NOT NULL,
  `spouseID` int(11) DEFAULT NULL,
  `spouseTreeID` int(11) DEFAULT NULL,
  `spouseAliasID` int(11) DEFAULT NULL,
  PRIMARY KEY (`treeID`,`memberID`,`fatherID`,`motherID`),
  KEY `idx_tree_member_ID` (`treeID`,`memberID`),
  CONSTRAINT `fk_tree_member` FOREIGN KEY (`treeID`, `memberID`) REFERENCES `Member` (`treeID`, `memberID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Rememberance`
--

DROP TABLE IF EXISTS `Rememberance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Rememberance` (
  `rID` int(11) NOT NULL AUTO_INCREMENT,
  `rName` varchar(100) DEFAULT NULL,
  `rDate` date DEFAULT NULL,
  `file_dir` varchar(50) DEFAULT NULL COMMENT 'File Path',
  `file_tn_dir` varchar(50) DEFAULT NULL,
  `memberID` int(11) NOT NULL,
  `treeID` int(11) NOT NULL,
  PRIMARY KEY (`rID`,`memberID`,`treeID`),
  KEY `fk_tree_member_2` (`treeID`,`memberID`),
  CONSTRAINT `fk_tree_member_2` FOREIGN KEY (`treeID`, `memberID`) REFERENCES `Member` (`treeID`, `memberID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Tree`
--

DROP TABLE IF EXISTS `Tree`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Tree` (
  `treeID` int(11) NOT NULL AUTO_INCREMENT,
  `privacy` tinyint(1) DEFAULT NULL,
  `treeName` varchar(100) DEFAULT NULL,
  `userID` int(11) DEFAULT NULL,
  `createOn` date DEFAULT NULL,
  PRIMARY KEY (`treeID`),
  KEY `userID_idx` (`userID`),
  CONSTRAINT `userID` FOREIGN KEY (`userID`) REFERENCES `Users` (`uID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Tree_Share`
--

DROP TABLE IF EXISTS `Tree_Share`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Tree_Share` (
  `uID` int(11) NOT NULL,
  `treeID` int(11) NOT NULL,
  PRIMARY KEY (`uID`,`treeID`),
  KEY `fk_tree_share_treeid_idx` (`treeID`),
  CONSTRAINT `fk_tree_share_treeid` FOREIGN KEY (`treeID`) REFERENCES `Tree` (`treeID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tree_share_uid` FOREIGN KEY (`uID`) REFERENCES `Users` (`uID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Users`
--

DROP TABLE IF EXISTS `Users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Users` (
  `uID` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(100) DEFAULT NULL,
  `password` varchar(100) DEFAULT NULL,
  `firstName` varchar(50) DEFAULT NULL,
  `lastName` varchar(50) DEFAULT NULL,
  `fbID` bigint(20) DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `lastlogin` datetime DEFAULT NULL,
  PRIMARY KEY (`uID`),
  UNIQUE KEY `email_UNIQUE` (`email`),
  UNIQUE KEY `fbID_UNIQUE` (`fbID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping routines for database 'ohana'
--
/*!50003 DROP PROCEDURE IF EXISTS `SP_Add_Offspring` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_Add_Offspring`( 
     member_id int,
     offspring_fname varchar(35),
     offspring_lname varchar(50),
     offspring_dob date,
	 offspring_email varchar(50),
     offspring_cob varchar(100),
     offspring_gender varchar(1),
     offspring_vs tinyint(1),
     offspring_treeID tinyint(1)
 )
BEGIN
	
    DECLARE offspring_id INT unsigned DEFAULT 1;
    DECLARE spouse_id INT unsigned DEFAULT 1;
    DECLARE coor_x_sp INT unsigned DEFAULT 1;
    DECLARE coor_x INT unsigned DEFAULT 1;
    DECLARE coor_y INT unsigned DEFAULT 1;
    DECLARE record_count INT unsigned DEFAULT 1;
    DECLARE member_gender varchar(1);
    
    SET spouse_id = (SELECT spouseID FROM Relation WHERE memberID = member_id);
    
    SET member_gender = (select gender from member where memberID = member_id);
    
    IF (spouse_id is null) THEN
		IF member_gender = 'M' THEN
			CALL `SP_Add_Spouse`(member_id, '', '', NULL, NULL, NULL, 'F', 1, offspring_treeID);
		ELSE
			CALL `SP_Add_Spouse`(member_id, '', '', NULL, NULL, NULL, 'M', 1, offspring_treeID);
		END IF;
        
		SET spouse_id = (SELECT spouseID FROM Relation WHERE memberID = member_id);
	END IF;
    
    SET coor_y = (select y from coordinates where memberID = member_id);
    SET coor_x = (select x from coordinates where memberID = member_id);
    SET coor_x_sp = (select x from coordinates where memberID = spouse_id);
    
    SET offspring_id = (SELECT (memberID + 1) FROM Member ORDER BY memberID DESC LIMIT 1);
    
	INSERT INTO Member 
    Values (offspring_id, offspring_fname, offspring_lname, offspring_dob, offspring_cob, offspring_gender, offspring_email, null, offspring_vs, offspring_treeID);
    
    IF (coor_x < coor_x_sp) THEN
    BEGIN	
        
        INSERT INTO Relation values (offspring_treeID, offspring_id, member_id, spouse_id, NULL, NULL, NULL);
        
        IF (exists (select * from coordinates where fatherID = member_id)) THEN
			BEGIN
				SET record_count = (SELECT count(*) from coordinates where fatherID = member_id);
				
				IF (record_count = 1) THEN
					SET SQL_SAFE_UPDATES=0;
					UPDATE coordinates set x = (x + 30) WHERE x = coor_x and y = (coor_y + 30) and treeID = offspring_treeID;
                ELSE
					SET SQL_SAFE_UPDATES=0;
					UPDATE coordinates set x = (x + 30) WHERE x >= coor_x and y > coor_y and treeID = offspring_treeID or x > (coor_x + 30) and treeID = offspring_treeID;
                END IF;
			END;		
		END IF;
		INSERT INTO coordinates values (offspring_ID, member_id, spouse_ID, NULL, coor_x, coor_y + 30, offspring_treeID, NULL);	
	END;
    
	ELSE
		BEGIN 						
						
			INSERT INTO Relation values (offspring_treeID, offspring_id, spouse_id, member_id, NULL, NULL, NULL);
            SET record_count = (SELECT count(*) from coordinates where fatherID = spouse_id);
            
			IF (exists (select * from coordinates where fatherID = spouse_ID)) THEN
				
				IF record_count = 1 THEN
					SET SQL_SAFE_UPDATES=0;
					UPDATE coordinates set x = (x + 30) WHERE x = coor_x_sp and y = (coor_y + 30) and treeID = offspring_treeID;
                ELSE
					SET SQL_SAFE_UPDATES=0;
					UPDATE coordinates set x = (x + 30) WHERE x >= coor_x_sp and y > coor_y and treeID = offspring_treeID or x > coor_x_sp + 30 and treeID = offspring_treeID;
                END IF;
			END IF;
			INSERT INTO coordinates values (offspring_ID, spouse_ID, member_ID, NULL, coor_x_sp, coor_y + 30, offspring_treeID, NULL);	
		END;
    END IF;

	SELECT offspring_id AS offspring_id;
   
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SP_Add_Parent` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_Add_Parent`( 
	 member_ID int,
     father_fname varchar(35),
     father_lname varchar(50),
     father_dob date,
	 father_email varchar(50),
     father_cob varchar(100),
     father_vs tinyint(1),
     mother_fname varchar(35),
     mother_lname varchar(50),
     mother_dob date,
	 mother_email varchar(50),
     mother_cob varchar(100),
     mother_vs tinyint(1),
     tree_id int(11)
 )
BEGIN

	DECLARE father_id INT unsigned DEFAULT 1;
    DECLARE mother_id INT unsigned DEFAULT 1;
    DECLARE mem_sp_id INT unsigned DEFAULT 1;
	DECLARE member_x INT unsigned DEFAULT 1;
    DECLARE member_y INT unsigned DEFAULT 1;
    DECLARE member_sp_x INT unsigned DEFAULT 1;
    DECLARE member_sp_y INT unsigned DEFAULT 1;
    
    
    -- error handiling for sql errors
	-- DECLARE EXIT HANDLER FOR SQLEXCEPTION 
	-- SELECT 1 AS status;
    
    SET father_id = (SELECT fatherID FROM Relation WHERE memberID = member_ID);
    SET mother_id = (SELECT motherID FROM Relation WHERE memberID = member_ID);
    
    IF (father_id = 0 and mother_id = 0) THEN
    
		SET father_id = (SELECT (memberID + 1) FROM Member ORDER BY memberID DESC LIMIT 1);

		INSERT INTO Member 
		Values (father_id, father_fname, father_lname, father_dob, father_cob, 'M', father_email, null, father_vs, tree_id);
		
		SET mother_id = (SELECT (memberID + 1) FROM Member ORDER BY memberID DESC LIMIT 1);
		
		INSERT INTO Member 
		Values (mother_id, mother_fname, mother_lname, mother_dob, mother_cob, 'F', mother_email, null, mother_vs, tree_id);
		
		SET SQL_SAFE_UPDATES=0;
		UPDATE Relation SET fatherID = father_id, motherID = mother_id
		WHERE memberID = member_id;
		
		INSERT INTO Relation values (tree_id, father_id, 0, 0, mother_id, NULL, NULL);
		INSERT INTO Relation values (tree_id, mother_id, 0, 0, father_id, NULL, NULL);
		
		SET member_x = (select x from coordinates where memberID = member_ID);
		SET member_y = (select y from coordinates where memberID = member_ID);
		
		SET SQL_SAFE_UPDATES=0;
		update coordinates set y = (y + 30) where y >= member_y and treeID = tree_id;
		
		SET mem_sp_id = (SELECT spouseID FROM coordinates WHERE memberID = member_ID);
		
		IF (mem_sp_id is not null) THEN
			BEGIN
			
				SET member_sp_x = (select x from coordinates where memberID = mem_sp_id);
				SET member_sp_y = (select y from coordinates where memberID = mem_sp_id);

				IF (member_x < member_sp_x) THEN
					INSERT INTO Coordinates VALUES (father_id, 0, 0, mother_id, member_x, member_y, tree_id, null);
					INSERT INTO Coordinates VALUES (mother_id, 0, 0, father_id, (member_x + 30), member_y, tree_id, null);
				ELSE
					INSERT INTO Coordinates VALUES (father_id, 0, 0, mother_id, member_sp_x, member_y, tree_id, null);
					INSERT INTO Coordinates VALUES (mother_id, 0, 0, father_id, (member_sp_x + 30), member_y, tree_id, null);
				END IF;
				
			END;
		ELSE
			BEGIN
				INSERT INTO Coordinates VALUES (father_id, 0, 0, mother_id, member_x, member_y, tree_id, null);
				INSERT INTO Coordinates VALUES (mother_id, 0, 0, father_id, (member_x + 30), member_y, tree_id, null);
			END;
		END IF;
		
		SET SQL_SAFE_UPDATES=0;
		UPDATE coordinates SET fatherID = father_id, motherID = mother_id WHERE memberID = member_ID;
		UPDATE coordinates SET fatherID = father_id, motherID = mother_id WHERE memberID = mem_sp_id;
		
		SET SQL_SAFE_UPDATES=0;
		DELETE FROM Relation WHERE memberID = mem_sp_id;
		
        -- successful compilation
		SELECT 0 AS status;
    
    ELSE
		-- parent already exists
		SELECT 1 AS status;
    END IF;
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SP_Add_Sibling` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_Add_Sibling`( 
     member_id int, 
     sib_fname varchar(35),
     sib_lname varchar(50),
     sib_dob date,
	 sib_email varchar(50),
     sib_cob varchar(100),
     sib_gender varchar(1),
     sib_vs tinyint(1),
	 sib_treeID tinyint(1)
 )
BEGIN
	
    DECLARE sib_id INT unsigned DEFAULT 1;
    DECLARE father_id INT unsigned DEFAULT 1;
    DECLARE mother_id INT unsigned DEFAULT 1;
    DECLARE father_x INT unsigned DEFAULT 1;
    DECLARE father_y INT unsigned DEFAULT 1;
    DECLARE record_count INT unsigned DEFAULT 1;
    
    SET father_id = (SELECT fatherID from Relation WHERE memberID = member_id);
    SET mother_id = (SELECT motherID from Relation WHERE memberID = member_id);
    
    IF (father_id = 0 and mother_id = 0) THEN
	BEGIN
        CALL `SP_Add_Parent` (member_ID, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 1, sib_treeID);
		SET father_id = (SELECT fatherID from Relation WHERE memberID = member_id);
		SET mother_id = (SELECT motherID from Relation WHERE memberID = member_id);
        
    END;
    END IF;
    
    
    SET sib_id = (SELECT (memberID + 1) FROM Member ORDER BY memberID DESC LIMIT 1);
    
    SET SQL_SAFE_UPDATES=0;
    
	INSERT INTO Member 
    Values (sib_id, sib_fname, sib_lname, sib_dob, sib_cob, sib_gender, sib_email, null, sib_vs, sib_treeID);
    
	INSERT INTO Relation values (sib_treeID, sib_id, father_id, mother_id, NULL, NULL, NULL);
    
    SET father_x = (select x from coordinates where memberID = father_ID);
    SET father_y = (select y from coordinates where memberID = father_ID);
    
    
    IF (exists (select * from coordinates where fatherID = father_ID)) THEN
		BEGIN
            IF (exists (select * from coordinates where x = father_x and y = father_y + 30)) THEN
				SET record_count = (select count(*) from coordinates where fatherID = father_id and motherID = mother_id);
				
                IF record_count = 1 THEN
					SET SQL_SAFE_UPDATES=0;
					UPDATE coordinates set x = (x + 30) WHERE x = father_x and y = (father_y + 30) and treeID = sib_treeID;
                ELSE
					SET SQL_SAFE_UPDATES=0;
					UPDATE coordinates set x = (x + 30) WHERE x >= father_x and y > father_y and treeID = sib_treeID or x > father_x + 30 and treeID = sib_treeID;
                END IF;
				
            
            END IF;
		END;		
    END IF;
    INSERT INTO coordinates values (sib_id, father_ID, mother_ID, NULL, father_x, father_y + 30, sib_treeID, NULL);	

	SELECT sib_id As sibling_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SP_Add_Spouse` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_Add_Spouse`( 
	 member_id int,
     spouse_fname varchar(35),
     spouse_lname varchar(50),
     spouse_dob date,
	 spouse_email varchar(50),
     spouse_cob varchar(100),
     spouse_gender varchar(1),
     spouse_vs tinyint(1),
	 member_treeID int(11)
 )
BEGIN
	
	DECLARE member_x INT unsigned DEFAULT 1;
    DECLARE member_y INT unsigned DEFAULT 1;
    DECLARE father_id INT unsigned DEFAULT 1;
    DECLARE mother_id INT unsigned DEFAULT 1;
    DECLARE father_x INT unsigned DEFAULT 1;
    DECLARE spouse_id INT unsigned DEFAULT 1;
	DECLARE max_x INT unsigned DEFAULT 1;
    
    SET member_x = (select x from coordinates where memberID = member_id);
    SET member_y = (select y from coordinates where memberID = member_id);
    
    SET father_id = (select fatherID from relation where memberID = member_id);
    SET father_x = (select x from coordinates where memberID = father_id);
   
    SET mother_id = (select motherID from relation where memberID = member_id);
    
    SET spouse_id = (SELECT (memberID + 1) FROM Member ORDER BY memberID DESC LIMIT 1);
    
	INSERT INTO Member 
    Values (spouse_id, spouse_fname, spouse_lname, spouse_dob, spouse_cob, spouse_gender, spouse_email, null, spouse_vs, member_treeID);
 
    SET SQL_SAFE_UPDATES=0;
    UPDATE Relation SET spouseID = spouse_id WHERE memberID = member_id;
    
    
    SET max_x = (SELECT max(x) FROM coordinates where fatherID = father_id);
    
    IF (max_x >= (father_x + 30)) THEN
		BEGIN
			IF (member_x = father_x) THEN
				SET SQL_SAFE_UPDATES=0;
				UPDATE Coordinates SET x = (x + 30) WHERE x > (father_x + 30) and treeID = member_treeID;
				UPDATE Coordinates SET x = (x + 30) WHERE x = (father_x + 30) and y >= member_y and treeID = member_treeID;
            ELSE
				SET SQL_SAFE_UPDATES=0;
				UPDATE Coordinates SET x = (x + 30) WHERE x > member_x and y >= member_y and treeID = member_treeID or x >= (member_x+30) and treeID = member_treeID;
            END IF;	
        END;
	END IF;
    
    SET member_x = (select x from coordinates where memberID = member_id);
    SET member_y = (select y from coordinates where memberID = member_id);
    
    IF (spouse_gender = 'F') THEN
		INSERT INTO Coordinates VALUES (spouse_id, father_id, mother_id, member_id, (member_x + 30), member_y, member_treeID, NULL);
		
    ELSE
		SET SQL_SAFE_UPDATES=0;
		UPDATE Coordinates SET x = (x + 30) WHERE memberID = member_id and treeID = member_treeID;
		INSERT INTO Coordinates VALUES (spouse_id, father_id, mother_id, member_id, member_x, member_y, member_treeID, NULL);
    END IF;
    SET SQL_SAFE_UPDATES=0;
    UPDATE Relation SET spouseID = spouse_id where memberID = member_id;
    UPDATE Coordinates SET spouseID = spouse_id where memberID = member_id and treeID = member_treeID;

	SELECT spouse_id AS spouse_id;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SP_Delete_Member` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_Delete_Member`( 
	 member_id int
 )
BEGIN
	
    DECLARE coor_x INT unsigned DEFAULT 1;
    DECLARE coor_y INT unsigned DEFAULT 1;
    DECLARE father_id INT unsigned DEFAULT 1;
    DECLARE father_x INT unsigned DEFAULT 1;
    DECLARE spouse_id INT unsigned DEFAULT 1;
    DECLARE spouse_x INT unsigned DEFAULT 1;
    DECLARE record_count INT unsigned DEFAULT 1;
    DECLARE tree_id INT unsigned DEFAULT 1;
    
    -- count kids
    SET record_count = (SELECT count(*) FROM Coordinates WHERE fatherID = member_id or motherID = member_id);
    
	IF (record_count > 0) THEN
		SET SQL_SAFE_UPDATES=0;
		UPDATE Member SET firstName = '', lastName = '', dateOfBirth = NULL, placeOfBirth = NULL, vitalStatus = 1, email=NULL
        WHERE memberID = member_id;
        
    ELSE
    
		BEGIN
			SET coor_x = (SELECT x FROM coordinates WHERE memberId = member_id);
            SET coor_y = (SELECT y FROM coordinates WHERE memberID = member_id);
            SET father_id = (SELECT fatherID FROM coordinates WHERE memberID = member_id);
            SET father_x = (SELECT x FROM coordinates WHERE memberId = father_id);
            SET spouse_id = (SELECT spouseID FROM coordinates WHERE memberID = member_id);
            SET spouse_x = (SELECT x FROM coordinates WHERE memberId = spouse_id);
            SET tree_id = (SELECT treeID FROM coordinates WHERE memberID = member_id);
            
            IF (exists(SELECT * FROM Relation WHERE memberID = member_ID)) THEN
				SET SQL_SAFE_UPDATES=0;
				DELETE FROM coordinates WHERE memberID in (member_id, spouse_id);
				DELETE FROM relation WHERE memberID in (member_id, spouse_id);
				DELETE FROM member WHERE memberID in (member_id, spouse_id);
				
				IF spouse_id IS NOT NULL THEN
					IF (coor_x > spouse_x) THEN
						SET SQL_SAFE_UPDATES=0;
						UPDATE coordinates set x = (x - 60) WHERE x > spouse_x and y >= coor_y and treeID = tree_id or x > father_x + 30 and treeID = tree_id;
					ELSE
						SET SQL_SAFE_UPDATES=0;
						UPDATE coordinates set x = (x - 60) WHERE x > coor_x and y >= coor_y and treeID = tree_id or x > father_x + 30 and treeID = tree_id;
					END IF;
				ELSE
					SET SQL_SAFE_UPDATES=0;
					UPDATE coordinates set x = (x - 30) WHERE x > coor_x and y >= coor_y and treeID = tree_id or x > father_x + 30 and treeID = tree_id;
				END IF;
            
            ELSE
				SET SQL_SAFE_UPDATES=0;
				DELETE FROM coordinates WHERE memberID = member_id;
				DELETE FROM member WHERE memberID = member_id;
                UPDATE Relation SET spouseID = NULL WHERE memberID = spouse_id;
                UPDATE coordinates SET spouseID = NULL WHERE memberID = spouse_id;
                
                IF (coor_x > spouse_x) THEN
						SET SQL_SAFE_UPDATES=0;
						UPDATE coordinates set x = (x - 30) WHERE x > spouse_x and y >= coor_y and treeID = tree_id or x > father_x + 30 and treeID = tree_id;
					ELSE
						SET SQL_SAFE_UPDATES=0;
						UPDATE coordinates set x = (x - 30) WHERE x > coor_x and y >= coor_y and treeID = tree_id or x > father_x + 30 and treeID = tree_id;
					END IF;
            END IF;
            
            
        END;
    END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SP_DoCreateTreeShare` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_DoCreateTreeShare`(
	IN getMemberID INT(11), 
	IN getTreeID INT(11)
)
BEGIN

	-- error handiling for sql errors
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		SELECT 1 AS status;
		ROLLBACK;
	END;

	-- error handiling for duplicate email
	DECLARE EXIT HANDLER FOR 1062
	BEGIN
		SELECT 2 AS status;
		ROLLBACK;
	END;

	START TRANSACTION;
	
	INSERT INTO Tree_Share (uID, treeID)
	VALUES (getMemberID, getTreeID);

	COMMIT;

	SELECT 0 AS status;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SP_DoRegistration` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_DoRegistration`(
	IN fname VARCHAR(50), 
	lname VARCHAR(50), 
	getmail VARCHAR(50),
	gender VARCHAR(1),
	privacy TINYINT(1),
	pwd VARCHAR(35), 
	fb_id BIGINT(20))
BEGIN
	
	-- Declear Variables
	DECLARE user_id INT unsigned DEFAULT 1;
	DECLARE tree_id INT unsigned DEFAULT 1;
	DECLARE member_id INT unsigned DEFAULT 1;

	-- error handiling for sql errors
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		SELECT 1 AS status;
	 	ROLLBACK;
	END;

	-- error handiling for duplicate email
	DECLARE EXIT HANDLER FOR 1062
	BEGIN
	 	SELECT 2 AS status;
	 ROLLBACK;
	END;

	START TRANSACTION;
      
	-- Create User	
	INSERT INTO Users (firstname, lastname, email, password, fbID, created)
	VALUES (fname, lname, getmail, pwd, fb_id, NOW());
	SET user_id = (SELECT uID FROM Users WHERE email = getmail);	
	
	-- Create Tree
	INSERT INTO Tree (privacy, treeName, userID, createOn)
	VALUES (privacy, NULL, user_id, NOW());
	SET tree_id = (SELECT treeID FROM Tree WHERE userID = user_id);

	-- Create Member
	IF (SELECT COUNT(memberID) FROM Member) = 0 THEN
		SET member_id = 1;
		INSERT INTO Member 
		Values (member_id, fname, lname, NULL, NULL, gender, getmail, NULL, 1, tree_id);
	ELSE
		SET member_id = (SELECT (memberID + 1) FROM Member ORDER BY memberID DESC LIMIT 1);
		INSERT INTO Member 
		Values (member_id, fname, lname, NULL, NULL, gender, getmail, NULL, 1, tree_id);
	END IF;

	-- Create Coord
	INSERT INTO Relation 
	VALUES (tree_id, member_id, 0, 0, NULL, NULL, NULL);

	-- Create Relation
	INSERT INTO Coordinates 
	VALUES (member_id, 0, 0, NULL, 30, 10, tree_id, NULL);

	COMMIT;

	SELECT 0 AS status, u.uID, u.email, t.treeID
	FROM Users u
	INNER JOIN Tree t
	ON t.userID = u.uID
	WHERE email = getmail;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SP_DoUpdateMember` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_DoUpdateMember`(
	IN getmember_id INT(11),
	IN getfname VARCHAR(35),
	IN getlname VARCHAR(50),
	IN getdob DATE,
	IN getgender VARCHAR(1),
	IN getemail VARCHAR(50),
	IN getcob VARCHAR(100),
	IN getvs TINYINT(1)
)
BEGIN

	-- error handiling for sql errors
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		SELECT 1 AS status;
	 	ROLLBACK;
	END;

	START TRANSACTION;

	UPDATE Member 
	SET firstName = getfname,
	lastName = getlname,
	dateOfBirth = getdob,
	gender = getgender,
	email = getemail,
	placeOfBirth = getcob,
	vitalStatus = getvs
	WHERE memberID = getmember_id;

	COMMIT;

	SELECT 0 AS status;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SP_DoUploadProfilePic` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_DoUploadProfilePic`(
	IN getMemberID 
	INT(11), 
	IN getTreeID INT(11), 
	IN getData LONGBLOB, 
	IN getType VARCHAR(20))
BEGIN

	-- DECLARE EXIT HANDLER FOR SQLEXCEPTION SELECT 1 AS STATUS;

	SET @id = (SELECT memberID 
				FROM Member_Image 
				WHERE memberID = getMemberID);

	IF (@id IS NULL) THEN
		INSERT INTO Member_Image (memberID, treeID, image, type)
		VALUES (getMemberID, getTreeID, getData, getType);

	ELSE
		UPDATE Member_Image
		SET image = getData, type = getType
		WHERE memberID = getMemberID
		AND TreeID = getTreeID;

	END IF;

	SELECT 0 AS status;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SP_GetLogin` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_GetLogin`(IN getEmail varchar(50), pwd varchar(35), fb_id BIGINT(20))
BEGIN
	
	IF (fb_id IS NULL) THEN
		SELECT * 
		FROM Users INNER JOIN Tree
		ON Users.uid = Tree.userID
		WHERE Users.email = getEmail AND Users.password = pwd;
	ELSE
		SELECT * 
		FROM Users INNER JOIN Tree
		ON Users.uid = Tree.userID
		WHERE Users.email = getEmail AND Users.fbID = fb_id;
	END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SP_GetMember` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_GetMember`(IN getMemberID INT(11))
BEGIN

	-- error handiling for sql errors
	DECLARE EXIT HANDLER FOR SQLEXCEPTION 
	SELECT 1 AS status;

	SELECT * FROM Member WHERE memberID = getMemberID;


END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SP_GetMemberRelation` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_GetMemberRelation`(
	IN getMemberID INT(11)
)
BEGIN

	-- error handiling for sql errors
	DECLARE EXIT HANDLER FOR SQLEXCEPTION 
	SELECT 1 AS status;

	SELECT *, 0 AS status FROM Relation WHERE memberID = getMemberID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SP_GetMemberUser` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_GetMemberUser`(
	IN getMemberID INT(11)
)
BEGIN

	-- error handiling for sql errors
	-- DECLARE EXIT HANDLER FOR SQLEXCEPTION 
	-- SELECT 1 AS status;

	SELECT u.uID, m.firstName, m.lastName
	FROM Member m
	INNER JOIN Users u 
	ON m.email = u.email
	WHERE m.memberid = getMemberID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SP_GetTreeOwner` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_GetTreeOwner`(
	IN getTreeID INT(11)
)
BEGIN

	-- error handiling for sql errors
	DECLARE EXIT HANDLER FOR SQLEXCEPTION 
	SELECT 1 AS status;

	SELECT t.treeName, t.privacy, u.firstName, u.lastName, u.uid 
	FROM Tree t INNER JOIN Users u
	ON t.userID = u.uID
	WHERE t.treeID = getTreeID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SP_Search_Profile_By_Name` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_Search_Profile_By_Name`(
	keyword_firstName VARCHAR(35), 
    keyword_lastName VARCHAR(50)
)
BEGIN

	SELECT memberID, firstName, lastName
	FROM Member 
	WHERE firstName LIKE CONCAT('%', keyword_firstName, '%')  and lastName LIKE CONCAT('%', keyword_lastName, '%') 
	ORDER BY CASE 
				WHEN firstName = keyword_firstName and lastName = keyword_lastName THEN 0
                WHEN firstName = keyword_firstName and lastName LIKE CONCAT(keyword_lastName , '%') THEN 1
                WHEN firstName LIKE CONCAT(keyword_firstName , '%') and lastName = keyword_lastName THEN 2
                WHEN firstName = keyword_firstName and lastName LIKE CONCAT('%', keyword_lastName, '%') THEN 3
                WHEN firstName = keyword_firstName and lastName LIKE CONCAT('%', keyword_lastName) THEN 4
                WHEN firstName LIKE CONCAT('%', keyword_firstName, '%') and lastName = keyword_lastName THEN 5
                WHEN firstName LIKE CONCAT('%', keyword_firstName) and lastName = keyword_lastName THEN 6
                WHEN firstName LIKE CONCAT(keyword_firstName , '%') and lastName LIKE CONCAT(keyword_lastName , '%') THEN 7
                WHEN firstName LIKE CONCAT(keyword_firstName , '%') and lastName LIKE CONCAT('%', keyword_lastName, '%') THEN 8
                WHEN firstName LIKE CONCAT(keyword_firstName , '%') and lastName LIKE CONCAT('%', keyword_lastName) THEN 9
                WHEN firstName LIKE CONCAT('%', keyword_firstName, '%') and lastName LIKE CONCAT(keyword_lastName , '%') THEN 10
                WHEN firstName LIKE CONCAT('%', keyword_firstName, '%') and lastName LIKE CONCAT('%', keyword_lastName, '%') THEN 11
				WHEN firstName LIKE CONCAT('%', keyword_firstName) and lastName LIKE CONCAT(keyword_lastName , '%') THEN 12
                WHEN firstName LIKE CONCAT('%', keyword_firstName) and lastName LIKE CONCAT('%', keyword_lastName) THEN 13
                WHEN firstName LIKE CONCAT('%', keyword_firstName, '%') and lastName LIKE CONCAT('%', keyword_lastName) THEN 14
                WHEN firstName LIKE CONCAT('%', keyword_firstName) and lastName LIKE CONCAT('%', keyword_lastName, '%') THEN 15
				ELSE 16
              END,
              firstName, lastName ASC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SP_UpdateInviteStatus` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_UpdateInviteStatus`(
	IN getMemberID INT(11),
	IN getInviteStatus VARCHAR(10)
)
BEGIN

	-- error handiling for sql errors
	DECLARE EXIT HANDLER FOR SQLEXCEPTION 
	SELECT 1 AS status;

	UPDATE Member
	SET inviteStatus = getInviteStatus
	WHERE memberID = getMemberID;

	SELECT 0 AS status;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SP_UpdateInviteStatus` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER $$
DROP PROCEDURE IF EXISTS `SP_Show_Family`$$
CREATE PROCEDURE `SP_Show_Family`
( 
	member_ID int(11),
	tree_ID int(11)
)
BEGIN

	DECLARE father_ID, mother_ID, spouse_ID INT unsigned DEFAULT 1;
    DECLARE status INT unsigned DEFAULT 1;
    
    SET father_ID = (SELECT fatherID FROM Relation WHERE memberID = member_ID);
    SET mother_ID = (SELECT motherID FROM Relation WHERE memberID = member_ID);
    SET spouse_ID = (SELECT spouseID FROM Relation WHERE memberID = member_ID);
    
    IF (EXISTS (SELECT * FROM Relation WHERE MemberID = member_ID and TreeID = tree_ID)) THEN
		SET status = 0;
		SELECT * FROM Relation 
		WHERE fatherID = father_ID and motherID = mother_ID and treeID = tree_ID
		or fatherID = member_ID and treeID = tree_ID
		or motherID = member_ID and treeID = tree_ID
		order by fatherID;
	ELSE
		SELECT * FROM Relation 
		WHERE spouseID = member_id and treeID = tree_ID
		or fatherID = member_ID and treeID = tree_ID
		or motherID = member_ID and treeID = tree_ID
		order by fatherID;
	END IF;
END;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2015-02-25  1:46:45
