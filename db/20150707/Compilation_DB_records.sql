insert into member (`TreeID`, `MemberID`, `firstName`, `LastName`, `gender`) values 
('1', '1', 'Amy', 'Aung', 'F');
insert into member (`TreeID`, `MemberID`, `firstName`, `LastName`, `gender`) values 
('1', '2', 'Ben', 'Aung', 'M');
insert into member (`TreeID`, `MemberID`, `firstName`, `LastName`, `gender`) values 
('1', '3', 'Cindy', 'Aung', 'F');
insert into member (`TreeID`, `MemberID`, `firstName`, `LastName`, `gender`) values 
('1', '4', 'Amery', 'Aung', 'F');
insert into member (`TreeID`, `MemberID`, `firstName`, `LastName`, `gender`) values 
('1', '5', 'Robert', 'Aung', 'M');

insert into member (`TreeID`, `MemberID`, `firstName`, `LastName`, `gender`) values 
('1', '6', 'Aron', 'Aung', 'M');
insert into member (`TreeID`, `MemberID`, `firstName`, `LastName`, `gender`) values 
('1', '7', 'Beth', 'Aung', 'F');
insert into member (`TreeID`, `MemberID`, `firstName`, `LastName`, `gender`) values 
('1', '8', 'Charles', 'Ng', 'M');


insert into member (`TreeID`, `MemberID`, `firstName`, `LastName`, `gender`) values 
('1', '9', 'David', 'Ng', 'M');
insert into member (`TreeID`, `MemberID`, `firstName`, `LastName`, `gender`) values 
('1', '10', 'Edward', 'Ng', 'M');
insert into member (`TreeID`, `MemberID`, `firstName`, `LastName`, `gender`) values 
('1', '11', 'Fiona', 'Ng', 'F');

insert into member (`TreeID`, `MemberID`, `firstName`, `LastName`, `gender`) values 
('1', '12', 'George', 'Ng', 'M');
insert into member (`TreeID`, `MemberID`, `firstName`, `LastName`, `gender`) values 
('1', '13', 'Joanne', 'Ng', 'F');
insert into member (`TreeID`, `MemberID`, `firstName`, `LastName`, `gender`) values 
('1', '14', 'Kris', 'Ng', 'M');

insert into member (`TreeID`, `MemberID`, `firstName`, `LastName`, `gender`) values 
('1', '15', 'Lydia', 'Ng', 'F');
insert into member (`TreeID`, `MemberID`, `firstName`, `LastName`, `gender`) values 
('1', '16', 'Michael', 'Ng', 'M');

insert into member (`TreeID`, `MemberID`, `firstName`, `LastName`, `gender`) values 
('1', '17', 'Nathan', 'Ng', 'M');
insert into member (`TreeID`, `MemberID`, `firstName`, `LastName`, `gender`) values 
('1', '18', 'Olivia', 'Ng', 'F');

insert into member (`TreeID`, `MemberID`, `firstName`, `LastName`, `gender`) values 
('1', '19', 'Peter', 'Ng', 'M');
insert into member (`TreeID`, `MemberID`, `firstName`, `LastName`, `gender`) values 
('1', '20', 'Rebecca', 'Ng', 'F');


insert into relation values (1, 1, 5, 4, 6, NULL);
insert into relation values (1, 2, 5, 4, 7, NULL);
insert into relation values (1, 3, 5, 4, 8, NULL);


insert into relation values (1, 9, 6, 1, NULL, NULL);
insert into relation values (1, 10, 6, 1, NULL, NULL);
insert into relation values (1, 11, 6, 1, NULL, NULL);


insert into relation values (1, 15, 2, 7, 16, NULL);
insert into relation values (1, 17, 16, 15, NULL, NULL);



insert into relation values (1, 12, 8, 3, NULL, NULL);
insert into relation values (1, 13, 8, 3, 14, NULL);
insert into relation values (1, 18, 14, 13, NULL, NULL);

insert into relation values (1, 20, 19, 11, NULL, NULL);


SET SQL_SAFE_UPDATES=0;
update relation set spouseID = 19 where memberID = 11;

SET SQL_SAFE_UPDATES=0;
update relation set fatherID = 5, motherID =4 where memberID = 3;
