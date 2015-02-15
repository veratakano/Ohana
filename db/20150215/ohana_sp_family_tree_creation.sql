-- for creation for members
use ohana;

-- add this first before creating with webpage
insert into member values
(1, 'Vera', 'Aung', '1990-01-01', 'Myanmar', 'F', 0, 1);
insert into relation values (1, 1, 0, 0, NULL, NULL);
insert into coordinates values (1, 0, 0, 0, 30, 10);

/* 

select * from relation;
select * from member;
select * from coordinates;
select * from users;



insert into member values
(1, 'Vera', 'Aung', '1990-01-01', 'Myanmar', 'F', 0, 1);
insert into relation values (1, 1, 0, 0, NULL, NULL);
insert into coordinates values (1, 0, 0, 0, 30, 10);

CALL `SP_Add_Parent` (1, 'Nyo', 'Aung', '1937-01-01', 'Myanmar', 0, 'Grace', 'Aung', '1945-01-01', 'Myanmar', 1,1);

CALL `SP_Add_Family` (2, 3, 'KL', 'Aung', '1980-01-01', 'Myanmar', 'F', 1, 1);
CALL `SP_Add_Family` (2, 3, 'KM', 'Aung', '1978-01-01', 'Myanmar', 'M', 1, 1);


CALL `SP_Add_Spouse`  (1, 2, 'ABC', 'NG', '1990-02-02','Myanmar','M',1,1);
CALL `SP_Add_Spouse`  (4, 2, 'sis-ABC', 'NG', '1980-10-02','Myanmar','M',1,1);
CALL `SP_Add_Spouse`  (5, 2, 'bro-ABC', 'NG', '1979-03-02','Myanmar','F',1,1);

-- father first
CALL `SP_Add_Family` (5, 8, 'bro-son', 'Aung', '2000-01-01', 'Myanmar', 'M', 1, 1);
CALL `SP_Add_Family` (6, 1, 'vera-dau', 'Aung', '2010-01-01', 'Myanmar', 'F', 1, 1);


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
	DECLARE member_x INT unsigned DEFAULT 1;
    DECLARE member_y INT unsigned DEFAULT 1;
    
    -- error handiling for sql errors
	DECLARE EXIT HANDLER FOR SQLEXCEPTION 
	SELECT 1 AS status;
    
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
    
    INSERT INTO Coordinates VALUES (father_id, 0, 0, mother_id, member_x, member_y);
    INSERT INTO Coordinates VALUES (mother_id, 0, 0, father_id, (member_x + 20), member_y);
    
    UPDATE coordinates SET fatherID = father_id, motherID = mother_id
    WHERE memberID = member_id;
    
    SELECT 0 AS status;
    
END;$$



DELIMITER $$
DROP PROCEDURE IF EXISTS `SP_Add_Family`$$
CREATE PROCEDURE `SP_Add_Family`
( 
     father_id int,
     mother_id int, 
     member_fname varchar(35),
     member_lname varchar(50),
     member_dob date,
     member_cob varchar(20),
     member_gender varchar(1),
     member_vs tinyint(1),
     member_treeID tinyint(1)
 )
BEGIN
	DECLARE member_id INT unsigned DEFAULT 1;
    DECLARE father_x INT unsigned DEFAULT 1;
    DECLARE father_y INT unsigned DEFAULT 1;
    
    SET member_id = (SELECT (memberID + 1) FROM Member ORDER BY memberID DESC LIMIT 1);
    
	INSERT INTO Member 
    Values (member_id, member_fname, member_lname, member_dob, member_cob, member_gender, member_vs, member_treeID);
    
	INSERT INTO Relation values (1, member_id, father_id, mother_id, NULL, NULL);
    
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
    INSERT INTO coordinates values (member_ID, father_ID, mother_ID, NULL, father_x, father_y + 20);	
END;$$



DELIMITER $$
DROP PROCEDURE IF EXISTS `SP_Add_Spouse`$$
CREATE PROCEDURE `SP_Add_Spouse`
( 
	 member_id int,
     father_id int,
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
    DECLARE father_x INT unsigned DEFAULT 1;
    DECLARE spouse_id INT unsigned DEFAULT 1;
	DECLARE max_x INT unsigned DEFAULT 1;
    
    SET member_x = (select x from coordinates where memberID = member_id);
    SET member_y = (select y from coordinates where memberID = member_id);
    SET father_x = (select x from coordinates where memberID = father_id);
    
    
    SET spouse_id = (SELECT (memberID + 1) FROM Member ORDER BY memberID DESC LIMIT 1);
    
	INSERT INTO Member 
    Values (spouse_id, spouse_fname, spouse_lname, spouse_dob, spouse_cob, spouse_gender, spouse_vs, member_treeID);
    
    
    UPDATE Relation SET spouseID = spouse_id WHERE memberID = member_id;
    
    
    SET max_x = (SELECT max(x) FROM coordinates where fatherID = father_id);
    
    IF (max_x >= (father_x + 20)) THEN
		BEGIN
			IF (member_x = father_x) THEN
				UPDATE Coordinates SET x = (x + 20) WHERE x > (father_x + 20);
				UPDATE Coordinates SET x = (x + 20) WHERE x = (father_x + 20) and y = member_y;
            ELSE
				UPDATE Coordinates SET x = (x + 20) WHERE x > member_x;
            END IF;	
        END;
	END IF;
    
    SET member_x = (select x from coordinates where memberID = member_id);
    SET member_y = (select y from coordinates where memberID = member_id);
    
    IF (spouse_gender = 'F') THEN
		INSERT INTO Coordinates VALUES (spouse_id, -1, -1, member_id, (member_x + 20), member_y);
		
    ELSE
		UPDATE Coordinates SET x = (x + 20) WHERE memberID = member_id;
		INSERT INTO Coordinates VALUES (spouse_id, -1, -1, member_id, member_x, member_y);
    END IF;
    
    UPDATE Relation SET spouseID = spouse_id where memberID = member_id;
    UPDATE Coordinates SET spouseID = spouse_id where memberID = member_id;
END;$$

