
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
			CALL `SP_Add_Spouse`(member_id, '', '', NULL, NULL, 'F', 1,1);
		ELSE
			CALL `SP_Add_Spouse`(member_id, '', '', NULL, NULL, 'M', 1,1);
		END IF;
        
		SET spouse_id = (SELECT spouseID FROM Relation WHERE memberID = member_id);
	END IF;
    
    SET coor_y = (select y from coordinates where memberID = member_id);
    SET coor_x = (select x from coordinates where memberID = member_id);
    SET coor_x_sp = (select x from coordinates where memberID = spouse_id);
    
    SET offspring_id = (SELECT (memberID + 1) FROM Member ORDER BY memberID DESC LIMIT 1);
    
	INSERT INTO Member 
    Values (offspring_id, offspring_fname, offspring_lname, offspring_dob, offspring_cob, offspring_gender, offspring_vs, offspring_treeID);

	
    
    IF (coor_x < coor_x_sp) THEN
    BEGIN	
        
        INSERT INTO Relation values (1, offspring_id, member_id, spouse_id, NULL, NULL);
        
        
        IF (exists (select * from coordinates where fatherID = member_id)) THEN
			BEGIN
				SET record_count = (SELECT count(*) from coordinates where fatherID = member_id);
        select record_count;
				
				IF (record_count = 1) THEN
					SET SQL_SAFE_UPDATES=0;
					UPDATE coordinates set x = (x + 20) WHERE x = coor_x and y = (coor_y + 20);
                ELSE
					SET SQL_SAFE_UPDATES=0;
					UPDATE coordinates set x = (x + 20) WHERE x >= coor_x and y > coor_y or x > coor_x + 20;
                END IF;
			END;		
		END IF;
		INSERT INTO coordinates values (offspring_ID, member_id, spouse_ID, NULL, coor_x, coor_y + 20);	
	END;
    
	ELSE
		BEGIN 						
						
			INSERT INTO Relation values (1, offspring_id, spouse_id, member_id, NULL, NULL);
            SET record_count = (SELECT count(*) from coordinates where fatherID = spouse_id);
            
			IF (exists (select * from coordinates where fatherID = spouse_ID)) THEN
				
				
				IF record_count = 1 THEN
					SET SQL_SAFE_UPDATES=0;
					UPDATE coordinates set x = (x + 20) WHERE x = coor_x_sp and y = (coor_y + 20);
                ELSE
					SET SQL_SAFE_UPDATES=0;
					UPDATE coordinates set x = (x + 20) WHERE x >= coor_x_sp and y > coor_y or x > coor_x_sp + 20;
                END IF;
			END IF;
			INSERT INTO coordinates values (offspring_ID, spouse_ID, member_ID, NULL, coor_x_sp, coor_y + 20);	
		END;
    END IF;
   
END;$$



