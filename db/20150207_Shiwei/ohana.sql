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
  `x` int(11) DEFAULT NULL,
  `y` int(11) DEFAULT NULL,
  `verticalHierarchy` int(11) DEFAULT NULL,
  PRIMARY KEY (`memberID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Coordinates`
--

LOCK TABLES `Coordinates` WRITE;
/*!40000 ALTER TABLE `Coordinates` DISABLE KEYS */;
/*!40000 ALTER TABLE `Coordinates` ENABLE KEYS */;
UNLOCK TABLES;

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
  `countryOfBirth` varchar(20) DEFAULT NULL,
  `gender` varchar(1) DEFAULT NULL,
  `treeID` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`memberID`,`treeID`),
  KEY `idx_tree_member_id` (`treeID`,`memberID`),
  KEY `fk_treeID_idx` (`treeID`),
  CONSTRAINT `treeID` FOREIGN KEY (`treeID`) REFERENCES `Tree` (`treeID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Member`
--

LOCK TABLES `Member` WRITE;
/*!40000 ALTER TABLE `Member` DISABLE KEYS */;
/*!40000 ALTER TABLE `Member` ENABLE KEYS */;
UNLOCK TABLES;

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
  PRIMARY KEY (`treeID`,`memberID`,`fatherID`,`motherID`),
  KEY `idx_tree_member_ID` (`treeID`,`memberID`),
  CONSTRAINT `fk_tree_member` FOREIGN KEY (`treeID`, `memberID`) REFERENCES `Member` (`treeID`, `memberID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Relation`
--

LOCK TABLES `Relation` WRITE;
/*!40000 ALTER TABLE `Relation` DISABLE KEYS */;
/*!40000 ALTER TABLE `Relation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Rememberance`
--

DROP TABLE IF EXISTS `Rememberance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Rememberance` (
  `rID` int(11) NOT NULL,
  `rName` varchar(100) DEFAULT NULL,
  `rDate` date DEFAULT NULL,
  `file` longtext COMMENT 'File Path\nEither video or photograph\n',
  `memberID` int(11) NOT NULL,
  `treeID` int(11) NOT NULL,
  PRIMARY KEY (`rID`,`memberID`,`treeID`),
  KEY `fk_tree_member_2` (`treeID`,`memberID`),
  CONSTRAINT `fk_tree_member_2` FOREIGN KEY (`treeID`, `memberID`) REFERENCES `Member` (`treeID`, `memberID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Rememberance`
--

LOCK TABLES `Rememberance` WRITE;
/*!40000 ALTER TABLE `Rememberance` DISABLE KEYS */;
/*!40000 ALTER TABLE `Rememberance` ENABLE KEYS */;
UNLOCK TABLES;

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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Tree`
--

LOCK TABLES `Tree` WRITE;
/*!40000 ALTER TABLE `Tree` DISABLE KEYS */;
INSERT INTO `Tree` VALUES (1,NULL,'Testing',1,'2015-02-07');
/*!40000 ALTER TABLE `Tree` ENABLE KEYS */;
UNLOCK TABLES;

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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Users`
--

LOCK TABLES `Users` WRITE;
/*!40000 ALTER TABLE `Users` DISABLE KEYS */;
INSERT INTO `Users` VALUES (1,'shiwei_ou@hotmail.com',NULL,'Shiwei','Ou',10152586635933342,'2015-02-07 15:28:09',NULL);
/*!40000 ALTER TABLE `Users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'ohana'
--
/*!50003 DROP PROCEDURE IF EXISTS `SP_DoCreateTree` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_DoCreateTree`(IN tName VARCHAR(100), uID INT(11))
BEGIN

	-- error handiling for sql errors
	-- DECLARE EXIT HANDLER FOR SQLEXCEPTION 
	-- SELECT 1 AS status;

	INSERT INTO Tree (treeName, userID, createOn)
	VALUES (tName, uID, NOW());

	SELECT 0 AS status, treeID FROM Tree WHERE userID = uID;

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
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_DoRegistration`(IN fname varchar(50), lname varchar(50), getmail varchar(50), pwd varchar(35), fb_id BIGINT(20))
BEGIN

	-- error handiling for sql errors
	DECLARE EXIT HANDLER FOR SQLEXCEPTION 
	SELECT 1 AS status;

	-- error handiling for duplicate email
	DECLARE EXIT HANDLER FOR 1062
	SELECT 2 AS status;
	

	INSERT INTO users (firstname, lastname, email, password, fbID, created)
	VALUES (fname, lname, getmail, pwd, fb_id, NOW());

	SELECT 0 AS status, uID, email FROM users WHERE email = getmail;

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
		FROM users 
		WHERE email = getEmail AND password = pwd;
	ELSE
		SELECT * 
		FROM users 
		WHERE email = getEmail AND fbID = fb_id;
	END IF;

END ;;
DELIMITER ;
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

-- Dump completed on 2015-02-07 16:18:36
