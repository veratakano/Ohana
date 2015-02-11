
use ohana;
select * from relation;




DELIMITER $$
DROP PROCEDURE IF EXISTS `SP_Add_Family`$$
CREATE PROCEDURE `SP_Add_Family`
( 
	 member_ID int,
     father_ID int,
     mother_ID int, 
     spouse_ID int
 )
BEGIN
	DECLARE father_x INT unsigned DEFAULT 1;
    DECLARE father_y INT unsigned DEFAULT 1;
    
    SET father_x = (select x from coordinates where memberID = father_ID);
    SET father_y = (select y from coordinates where memberID = father_ID);
    -- SET mother_x = (select x from coordinates where memberID = mother_ID);
    
    IF (exists (select * from coordinates where fatherID = father_ID)) THEN
		BEGIN
            IF (exists (select * from coordinates where x = father_x and y = father_y + 20)) THEN
				UPDATE coordinates set x = (x + 20) WHERE x >= father_x and memberID <> father_ID and memberID <> mother_ID;
            
            END IF;
		END;		
    END IF;
    INSERT INTO coordinates values (member_ID, father_ID, mother_ID, spouse_ID, father_x, father_y + 20);	
END;$$




DELIMITER $$
DROP PROCEDURE IF EXISTS `SP_Add_Spouse`$$
CREATE PROCEDURE `SP_Add_Spouse`
( 
	 member_ID int,
     father_ID int,
     mother_ID int, 
     spouse_ID int
 )
BEGIN
	DECLARE father_x INT unsigned DEFAULT 1;
    DECLARE father_y INT unsigned DEFAULT 1;
    
    SET father_x = (select x from coordinates where memberID = father_ID);
    SET father_y = (select y from coordinates where memberID = father_ID);
    -- SET mother_x = (select x from coordinates where memberID = mother_ID);
    
    IF (exists (select * from coordinates where fatherID = father_ID)) THEN
		BEGIN
            IF (exists (select * from coordinates where x = father_x and y = father_y + 20)) THEN
				UPDATE coordinates set x = (x + 20) WHERE x >= father_x and memberID <> father_ID and memberID <> mother_ID;
            
            END IF;
		END;		
    END IF;
    INSERT INTO coordinates values (member_ID, father_ID, mother_ID, spouse_ID, father_x, father_y + 20);	
END;$$

INSERT INTO coordinates values (5, 0, 0, 4, 30,10);

call SP_Add_Family (6, 5, 4, 1);
call SP_Add_Family (1, 5, 4, 6);
call SP_Add_Family (2, 5, 4, 7);
call SP_Add_Family (7, 5, 4, 2);
call SP_Add_Family (10, 6, 1, 23);
call SP_Add_Family (23, 6, 1, 10);
call SP_Add_Family (11, 6, 1, 19);
call SP_Add_Family (19, 6, 1, 11);
call SP_Add_Family (8, 5, 4, 3);
call SP_Add_Family (3, 5, 4, 8);
call SP_Add_Family (15, 2, 7, 16);
call SP_Add_Family (16, 2, 7, 15);
call SP_Add_Family (31, 2, 7, NULL);
call SP_Add_Family (32, 2, 7, NULL);
call SP_Add_Family (33, 2, 7, NULL);

call SP_Add_Family (12, 8, 3, NULL);
call SP_Add_Family (17, 15, 15, NULL);
call SP_Add_Family (24, 11, 19, NULL);
call SP_Add_Family (25, 11, 19, NULL);
call SP_Add_Family (26, 11, 19, NULL);
call SP_Add_Family (27, 11, 19, NULL);
call SP_Add_Family (28, 11, 19, NULL);
call SP_Add_Family (29, 11, 19, NULL);


SELECT 
    *
FROM
    coordinates
WHERE
    memberID = 1;
SELECT 
    *
FROM
    coordinates;

SELECT 
    MAX(x)
FROM
    coordinates
WHERE
    fatherID = 6;