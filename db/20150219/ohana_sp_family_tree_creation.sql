-- for creation for members

use ohana;

-- add this first before creating with webpage
insert into member values
(1, 'Vera', 'Aung', '1990-01-01', 'Myanmar', 'F', 0, 1);
insert into relation values (1, 1, 0, 0, NULL, NULL);
insert into coordinates values (1, 0, 0, NULL, 30, 10);


/* 
select * from coordinates order by fatherID, y,x;
select * from relation;
select * from member;
select * from coordinates;
select * from users;
select * from tree;


CALL `SP_Add_Parent` (1, 'Nyo', 'Aung', '1937-01-01', 'Myanmar', 0, 'Grace', 'Aung', '1945-01-01', 'Myanmar', 1,1);

CALL `SP_Add_Offspring` (2,  'KL', 'Aung', '1980-01-01', 'Myanmar', 'M', 1, 1);
CALL `SP_Add_Offspring` (7, 'KM', 'Aung', '1978-01-01', 'Myanmar', 'F', 1, 1);
CALL `SP_Add_Offspring`(7, '8th kid', 'Aung', '1990-11-11', 'sg', 'M', 1,1);
CALL `SP_Add_Offspring`(4 , '8th kid', 'Aung', '1990-11-11', 'sg', 'F', 1,1);
CALL `SP_Add_Offspring`(11, '6th kid', 'Aung', '1990-11-11', 'sg', 'M', 1,1);

call `SP_Add_Sibling` (2, 'KL', 'Aung', '1984-07-14', 'Myanmar', 'F', 1, 1);
call `SP_Add_Sibling` (2, 'KM', 'Aung', '1982-10-14', 'Myanmar', 'M', 1, 1);
call `SP_Add_Sibling` (1, 'KL', 'Aung', '1984-07-14', 'Myanmar', 'M', 1, 1);
call `SP_Add_Sibling` (8, 'KM', 'Aung', '1982-10-14', 'Myanmar', 'M', 1, 1);

CALL `SP_Add_Spouse`  (19, 'ABC', 'NG', '1990-02-02','Myanmar','M',1,1);
CALL `SP_Add_Spouse`  (7, 'sis-ABC', 'NG', '1980-10-02','Myanmar','F',1,1);
CALL `SP_Add_Spouse`  (26, 'bro-ABC', 'NG', '1979-03-02','Myanmar','M',1,1);


SELECT memberID FROM Member ORDER BY memberID DESC LIMIT 1;
*/


DELIMITER $$
DROP PROCEDURE IF EXISTS `SP_Add_Parent`$$
CREATE PROCEDURE `SP_Add_Parent`
( 
	 member_ID int,
     father_fname varchar(35),
     father_lname varchar(50),
     father_dob date,
     father_cob varchar(20),
     father_vs tinyint(1),
     mother_fname varchar(35),
     mother_lname varchar(50),
     mother_dob date,
     mother_cob varchar(20),
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
    
    SET father_id = (SELECT (memberID + 1) FROM Member ORDER BY memberID DESC LIMIT 1);

    INSERT INTO Member 
    Values (father_id, father_fname, father_lname, father_dob, father_cob, 'M', father_vs, tree_id);
    
    SET mother_id = (SELECT (memberID + 1) FROM Member ORDER BY memberID DESC LIMIT 1);
    INSERT INTO Member 
    Values (mother_id, mother_fname, mother_lname, mother_dob, mother_cob, 'F', mother_vs, tree_id);
    
	UPDATE Relation SET fatherID = father_id, motherID = mother_id
    WHERE memberID = member_id;
    
    INSERT INTO Relation values (1, father_id, 0, 0, mother_id, NULL);
    
    SET member_x = (select x from coordinates where memberID = member_ID);
    SET member_y = (select y from coordinates where memberID = member_ID);
    
    update coordinates set y = (y + 20) where y >= member_y;
    
    SET mem_sp_id = (SELECT spouseID FROM coordinates WHERE memberID = member_ID);
    
    select mem_sp_id;
    IF (mem_sp_id is not null) THEN
		BEGIN
        
        select "here";
			SET member_sp_x = (select x from coordinates where memberID = mem_sp_id);
			SET member_sp_y = (select y from coordinates where memberID = mem_sp_id);

			IF (member_x < member_sp_x) THEN
				INSERT INTO Coordinates VALUES (father_id, 0, 0, mother_id, member_x, member_y);
				INSERT INTO Coordinates VALUES (mother_id, 0, 0, father_id, (member_x + 20), member_y);
			ELSE
				INSERT INTO Coordinates VALUES (father_id, 0, 0, mother_id, member_sp_x, member_y);
				INSERT INTO Coordinates VALUES (mother_id, 0, 0, father_id, (member_sp_x + 20), member_y);
			END IF;
			
        END;
	ELSE
		BEGIN
			INSERT INTO Coordinates VALUES (father_id, 0, 0, mother_id, member_x, member_y);
			INSERT INTO Coordinates VALUES (mother_id, 0, 0, father_id, (member_x + 20), member_y);
		END;
	END IF;
    
    UPDATE coordinates SET fatherID = father_id, motherID = mother_id
    WHERE memberID = member_ID;
    UPDATE coordinates SET fatherID = father_id, motherID = mother_id WHERE memberID = mem_sp_id;
    SELECT 0 AS status;
    
END;$$


DELIMITER $$
DROP PROCEDURE IF EXISTS `SP_Add_Sibling`$$
CREATE PROCEDURE `SP_Add_Sibling`
( 
     member_id int, 
     sib_fname varchar(35),
     sib_lname varchar(50),
     sib_dob date,
     sib_cob varchar(20),
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
        CALL `SP_Add_Parent` (member_ID, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, 1, sib_treeID);
		SET father_id = (SELECT fatherID from Relation WHERE memberID = member_id);
		SET mother_id = (SELECT motherID from Relation WHERE memberID = member_id);
        
    END;
    END IF;
    
    
    SET sib_id = (SELECT (memberID + 1) FROM Member ORDER BY memberID DESC LIMIT 1);
    
	INSERT INTO Member 
    Values (sib_id, sib_fname, sib_lname, sib_dob, sib_cob, sib_gender, sib_vs, sib_treeID);
    
	INSERT INTO Relation values (1, sib_id, father_id, mother_id, NULL, NULL);
    
    SET father_x = (select x from coordinates where memberID = father_ID);
    SET father_y = (select y from coordinates where memberID = father_ID);
    
    
    IF (exists (select * from coordinates where fatherID = father_ID)) THEN
		BEGIN
            IF (exists (select * from coordinates where x = father_x and y = father_y + 20)) THEN
				SET record_count = (select count(*) from coordinates where fatherID = father_id and motherID = mother_id);
				
                IF record_count = 1 THEN
					UPDATE coordinates set x = (x + 20) WHERE x = father_x and y = (father_y + 20);
                ELSE
					UPDATE coordinates set x = (x + 20) WHERE x >= father_x and y > father_y or x > father_x + 20;
                END IF;
				
            
            END IF;
		END;		
    END IF;
    INSERT INTO coordinates values (sib_id, father_ID, mother_ID, NULL, father_x, father_y + 20);	
END;$$




DELIMITER $$
DROP PROCEDURE IF EXISTS `SP_Add_Spouse`$$
CREATE PROCEDURE `SP_Add_Spouse`
( 
	 member_id int,
     spouse_fname varchar(35),
     spouse_lname varchar(50),
     spouse_dob date,
     spouse_cob varchar(20),
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
    Values (spouse_id, spouse_fname, spouse_lname, spouse_dob, spouse_cob, spouse_gender, spouse_vs, member_treeID);
    
    SET SQL_SAFE_UPDATES=0;
    UPDATE Relation SET spouseID = spouse_id WHERE memberID = member_id;
    
    
    SET max_x = (SELECT max(x) FROM coordinates where fatherID = father_id);
    
    IF (max_x >= (father_x + 20)) THEN
		BEGIN
			IF (member_x = father_x) THEN
				SET SQL_SAFE_UPDATES=0;
				UPDATE Coordinates SET x = (x + 20) WHERE x > (father_x + 20);
				UPDATE Coordinates SET x = (x + 20) WHERE x = (father_x + 20) and y >= member_y;
            ELSE
				SET SQL_SAFE_UPDATES=0;
				UPDATE Coordinates SET x = (x + 20) WHERE x > member_x and y >= member_y or x >= (member_x+20);
            END IF;	
        END;
	END IF;
    
    SET member_x = (select x from coordinates where memberID = member_id);
    SET member_y = (select y from coordinates where memberID = member_id);
    
    IF (spouse_gender = 'F') THEN
		INSERT INTO Coordinates VALUES (spouse_id, father_id, mother_id, member_id, (member_x + 20), member_y);
		
    ELSE
		SET SQL_SAFE_UPDATES=0;
		UPDATE Coordinates SET x = (x + 20) WHERE memberID = member_id;
		INSERT INTO Coordinates VALUES (spouse_id, father_id, mother_id, member_id, member_x, member_y);
    END IF;
    SET SQL_SAFE_UPDATES=0;
    UPDATE Relation SET spouseID = spouse_id where memberID = member_id;
    UPDATE Coordinates SET spouseID = spouse_id where memberID = member_id;
END;$$


USE `Ohana`;


DELIMITER $$
DROP PROCEDURE IF EXISTS `SP_Add_Offspring`$$
CREATE PROCEDURE `SP_Add_Offspring`
( 
     member_id int,
     offspring_fname varchar(35),
     offspring_lname varchar(50),
     offspring_dob date,
     offspring_cob varchar(20),
     offspring_gender varchar(1),
     offspring_vs tinyint(1),
     offspring_treeID tinyint(1)
 )
BEGIN
	DECLARE offspring_id INT unsigned DEFAULT 1;
    DECLARE spouse_ID INT unsigned DEFAULT 1;
    DECLARE coor_x_sp INT unsigned DEFAULT 1;
    DECLARE coor_x INT unsigned DEFAULT 1;
    DECLARE coor_y INT unsigned DEFAULT 1;
    DECLARE record_count INT unsigned DEFAULT 1;
    DECLARE member_gender varchar(1);
    
    SET spouse_id = (SELECT spouseID FROM Relation WHERE memberID = member_id);
    
    SET member_gender = (select gender from member where memberID = member_id);
    
    IF (spouse_id is null) THEN
		IF member_gender = 'M' THEN
			CALL `SP_Add_Spouse`(member_id, '', '', NULL, NULL, 'F', 1,1);
		ELSE
			CALL `SP_Add_Spouse`(member_id, '', '', NULL, NULL, 'M', 1,1);
		END IF;
        
		SET spouse_id = (SELECT spouseID FROM Relation WHERE memberID = member_id);
	END IF;
    
    SET coor_y = (select y from coordinates where memberID = member_ID);
    SET coor_x = (select x from coordinates where memberID = member_ID);
    SET coor_x_sp = (select x from coordinates where memberID = spouse_ID);
    
    SET offspring_id = (SELECT (memberID + 1) FROM Member ORDER BY memberID DESC LIMIT 1);
    
	INSERT INTO Member 
    Values (offspring_id, offspring_fname, offspring_lname, offspring_dob, offspring_cob, offspring_gender, offspring_vs, offspring_treeID);

	
    
    IF (coor_x < coor_x_sp) THEN
    BEGIN	
        
        INSERT INTO Relation values (1, offspring_id, member_id, spouse_id, NULL, NULL);
        
        
        IF (exists (select * from coordinates where fatherID = member_id)) THEN
			BEGIN
				SET record_count = (SELECT count(*) from coordinates where fatherID = member_id and motherID = spouse_ID);
        select record_count;
				SET SQL_SAFE_UPDATES=0;
				IF record_count = 1 THEN
					UPDATE coordinates set x = (x + 20) WHERE x = coor_x and y = (coor_x + 20);
                ELSE
					UPDATE coordinates set x = (x + 20) WHERE x >= coor_x and y > coor_y or x > coor_x + 20;
                END IF;
			END;		
		END IF;
		INSERT INTO coordinates values (offspring_ID, member_id, spouse_ID, NULL, coor_x, coor_y + 20);	
	END;
    
	ELSE
		BEGIN 						
						
			INSERT INTO Relation values (1, offspring_id, spouse_id, member_id, NULL, NULL);
            SET record_count = (SELECT count(*) from coordinates where fatherID = spouse_id and motherID = member_id);
            
			IF (exists (select * from coordinates where fatherID = spouse_ID)) THEN
				
				SET SQL_SAFE_UPDATES=0;
				IF record_count = 1 THEN
					UPDATE coordinates set x = (x + 20) WHERE x = coor_x_sp and y = (coor_x_sp + 20);
                ELSE
					UPDATE coordinates set x = (x + 20) WHERE x >= coor_x_sp and y > coor_y or x > coor_x_sp + 20;
                END IF;
			END IF;
			INSERT INTO coordinates values (offspring_ID, spouse_ID, member_ID, NULL, coor_x_sp, coor_y + 20);	
		END;
    END IF;
   
END;$$




USE `Ohana`;


DELIMITER $$
DROP PROCEDURE IF EXISTS `SP_Add_Offspring`$$
CREATE PROCEDURE `SP_Add_Offspring`
( 
     member_id int,
     offspring_fname varchar(35),
     offspring_lname varchar(50),
     offspring_dob date,
     offspring_cob varchar(20),
     offspring_gender varchar(1),
     offspring_vs tinyint(1),
     offspring_treeID tinyint(1)
 )
BEGIN
	DECLARE offspring_id INT unsigned DEFAULT 1;
    DECLARE spouse_ID INT unsigned DEFAULT 1;
    DECLARE coor_x_sp INT unsigned DEFAULT 1;
    DECLARE coor_x INT unsigned DEFAULT 1;
    DECLARE coor_y INT unsigned DEFAULT 1;
    DECLARE record_count INT unsigned DEFAULT 1;
    DECLARE member_gender varchar(1);
    
    SET spouse_id = (SELECT spouseID FROM Relation WHERE memberID = member_id);
    
    SET member_gender = (select gender from member where memberID = member_id);
    
    IF (spouse_id is null) THEN
		IF member_gender = 'M' THEN
			CALL `SP_Add_Spouse`(member_id, '', '', NULL, NULL, 'F', 1,1);
		ELSE
			CALL `SP_Add_Spouse`(member_id, '', '', NULL, NULL, 'M', 1,1);
		END IF;
        
		SET spouse_id = (SELECT spouseID FROM Relation WHERE memberID = member_id);
	END IF;
    
    SET coor_y = (select y from coordinates where memberID = member_ID);
    SET coor_x = (select x from coordinates where memberID = member_ID);
    SET coor_x_sp = (select x from coordinates where memberID = spouse_ID);
    
    SET offspring_id = (SELECT (memberID + 1) FROM Member ORDER BY memberID DESC LIMIT 1);
    
	INSERT INTO Member 
    Values (offspring_id, offspring_fname, offspring_lname, offspring_dob, offspring_cob, offspring_gender, offspring_vs, offspring_treeID);

	
    
    IF (coor_x < coor_x_sp) THEN
    BEGIN	
        
        INSERT INTO Relation values (1, offspring_id, member_id, spouse_id, NULL, NULL);
        
        
        IF (exists (select * from coordinates where fatherID = member_id)) THEN
			BEGIN
				SET record_count = (SELECT count(*) from coordinates where fatherID = member_id and motherID = spouse_ID);
        select record_count;
				SET SQL_SAFE_UPDATES=0;
				IF record_count = 1 THEN
					UPDATE coordinates set x = (x + 20) WHERE x = coor_x and y = (coor_x + 20);
                ELSE
					UPDATE coordinates set x = (x + 20) WHERE x >= coor_x and y > coor_y or x > coor_x + 20;
                END IF;
			END;		
		END IF;
		INSERT INTO coordinates values (offspring_ID, member_id, spouse_ID, NULL, coor_x, coor_y + 20);	
	END;
    
	ELSE
		BEGIN 						
						
			INSERT INTO Relation values (1, offspring_id, spouse_id, member_id, NULL, NULL);
            SET record_count = (SELECT count(*) from coordinates where fatherID = spouse_id and motherID = member_id);
            
			IF (exists (select * from coordinates where fatherID = spouse_ID)) THEN
				
				SET SQL_SAFE_UPDATES=0;
				IF record_count = 1 THEN
					UPDATE coordinates set x = (x + 20) WHERE x = coor_x_sp and y = (coor_x_sp + 20);
                ELSE
					UPDATE coordinates set x = (x + 20) WHERE x >= coor_x_sp and y > coor_y or x > coor_x_sp + 20;
                END IF;
			END IF;
			INSERT INTO coordinates values (offspring_ID, spouse_ID, member_ID, NULL, coor_x_sp, coor_y + 20);	
		END;
    END IF;
   
END;$$







DELIMITER $$
DROP PROCEDURE IF EXISTS `SP_Delete_Member`$$
CREATE PROCEDURE `SP_Delete_Member`
( 
	 member_id int
 )
BEGIN
	DECLARE max_x INT unsigned DEFAULT 1;
    
	IF (exists (SELECT * FROM Relation WHERE fatherID = member_id or motherID = member_id)) THEN
		SET SQL_SAFE_UPDATES=0;
		UPDATE Member SET firstName = '', lastName = '', dateOfBirth = NULL, countryOfBirth = NULL, vitalStatus = 1;
    ELSE
		DELETE FROM coordinates WHERE memberID = member_id;
		DELETE FROM relation WHERE memberID = member_id;
		DELETE FROM member WHERE memberID = member_id;    
    END IF;

END;$$
