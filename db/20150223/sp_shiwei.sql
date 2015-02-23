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
-- Dumping routines for database 'ohana'
--

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
		UPDATE Member SET firstName = '', lastName = '', dateOfBirth = NULL, placeOfBirth = NULL, vitalStatus = 1;
        
    ELSE
    
		BEGIN
			SET coor_x = (SELECT x FROM coordinates WHERE memberId = member_id);
            SET coor_y = (SELECT y FROM coordinates WHERE memberID = member_id);
            SET father_id = (SELECT fatherID FROM coordinates WHERE memberID = member_id);
            SET father_x = (SELECT x FROM coordinates WHERE memberId = father_id);
            SET spouse_id = (SELECT spouseID FROM coordinates WHERE memberID = member_id);
            SET spouse_x = (SELECT x FROM coordinates WHERE memberId = spouse_id);
            SET tree_id = (SELECT treeID FROM coordinates WHERE memberID = member_id);
            
            SET SQL_SAFE_UPDATES=0;
            DELETE FROM coordinates WHERE memberID in (member_id, spouse_id);
			DELETE FROM relation WHERE memberID in (member_id, spouse_id);
			DELETE FROM member WHERE memberID in (member_id, spouse_id);
            
            IF spouse_id IS NOT NULL THEN
				IF (coor_x > spouse_x) THEN
					SET SQL_SAFE_UPDATES=0;
					UPDATE coordinates set x = (x - 40) WHERE x > spouse_x and y >= coor_y and treeID = tree_id or x > father_x + 20 and treeID = tree_id;
                ELSE
					SET SQL_SAFE_UPDATES=0;
					UPDATE coordinates set x = (x - 40) WHERE x > coor_x and y >= coor_y and treeID = tree_id or x > father_x + 20 and treeID = tree_id;
                END IF;
			ELSE
				SET SQL_SAFE_UPDATES=0;
				UPDATE coordinates set x = (x - 20) WHERE x > coor_x and y >= coor_y and treeID = tree_id or x > father_x + 20 and treeID = tree_id;
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
	IN fname varchar(50), 
	lname varchar(50), 
	getmail varchar(50), 
	pwd varchar(35), 
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
	INSERT INTO Tree (treeName, userID, createOn)
	VALUES (NULL, user_id, NOW());
	SET tree_id = (SELECT treeID FROM Tree WHERE userID = user_id);

	-- Create Member
	IF (SELECT COUNT(memberID) FROM Member) = 0 THEN
		SET member_id = 1;
		INSERT INTO Member 
		Values (member_id, fname, lname, NULL, NULL, NULL, getmail, NULL, 1, tree_id);
	ELSE
		SET member_id = (SELECT (memberID + 1) FROM Member ORDER BY memberID DESC LIMIT 1);
		INSERT INTO Member 
		Values (member_id, fname, lname, NULL, NULL, NULL, getmail, NULL, 1, tree_id);
	END IF;

	-- Create Coord
	INSERT INTO Relation 
	VALUES (tree_id, member_id, 0, 0, NULL, NULL);

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
/*!50003 DROP PROCEDURE IF EXISTS `SP_DoUploadPGalleryPic` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_DoUploadPGalleryPic`(
	IN getMemberID INT(11), 
	IN getTreeID INT(11), 
	IN getName VARCHAR(100),
	IN getDest VARCHAR(50),
	IN getTnDest VARCHAR(50)
)
BEGIN

	DECLARE EXIT HANDLER FOR SQLEXCEPTION 
	  BEGIN
		-- ERROR
		SELECT 1 AS status;
		ROLLBACK;
	END;

	DECLARE EXIT HANDLER FOR SQLWARNING 
	  BEGIN
		-- WARNING
		SELECT 2 AS status;
		ROLLBACK;
	END;

	START TRANSACTION;
		INSERT INTO Rememberance (rName, rDate, file_dir, file_tn_dir, memberID, treeID)
		VALUES (getName, NOW(), getDest, getTnDest, getMemberID, getTreeID);
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
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_DoUploadProfilePic`(IN getMemberID INT(11), IN getTreeID INT(11), IN getData BLOB, IN getType VARCHAR(20))
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
				END, firstName, lastName ASC;
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
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2015-02-23  2:04:25
