CREATE DATABASE IF NOT EXISTS cfTask2;

USE cfTask2;

CREATE TABLE registerForm (
		nameID INT AUTO_INCREMENT PRIMARY KEY,
        fullname VARCHAR(50),
        email VARCHAR(50),
        username VARCHAR(50),
        password VARCHAR(250),
        salt VARCHAR(255) NOT NULL
);

ALTER TABLE 
	registerForm
ADD COLUMN 
	salt VARCHAR(255) NOT NULL;

-- Disable foreign key checks
SET FOREIGN_KEY_CHECKS = 0;
-- Enable foreign key checks
SET FOREIGN_KEY_CHECKS = 1;

 SELECT 
	* 
 FROM 
	registerForm;


 -- truncate table registerForm;
 
 CREATE TABLE title_names (
	title_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(10)
 );
 
 INSERT INTO title_names
	(title)
 VALUES 
	("Mr."),
    ("Ms."),
    ("Mrs."),
    ("Dr.");
    
 SELECT * FROM title_names;
 
 CREATE TABLE contacts (
	userId INT AUTO_INCREMENT PRIMARY KEY,
	title_id INT,
    fname VARCHAR(50),
    lname VARCHAR(50),
    gender VARCHAR(10),
    DOB DATE,
    photoName VARCHAR(100),
    phone VARCHAR(20),
    emailAddress VARCHAR(200),
    address VARCHAR(100),
    street VARCHAR(50),
    is_delete INT DEFAULT FALSE,
    public VARCHAR(20)
);

ALTER TABLE 
	contacts
ADD CONSTRAINT 
	fk_hobbie
FOREIGN KEY 
	(Hobbies) 
REFERENCES 
	hobbies(Id);
    
SHOW CREATE TABLE contacts;

ALTER TABLE contacts
DROP FOREIGN KEY fk_hobbie;

ALTER TABLE contacts
DROP COLUMN Hobbies;


ALTER TABLE 
	contacts
ADD CONSTRAINT 
	fk_user
FOREIGN KEY 
	(nameId_fk) 
REFERENCES 
	registerForm(nameID);
    

ALTER TABLE 
	contacts
CHANGE 
	title title_id INT;

ALTER TABLE 
	contacts
ADD CONSTRAINT 
	fk_title
FOREIGN KEY 
	(title_id) 
REFERENCES 
	title_names(title_id);
    
ALTER TABLE 
	contacts
ADD COLUMN 
	`delete` INT DEFAULT TRUE;

ALTER TABLE 
	contacts
ADD COLUMN 
	nameId_fk INT;

ALTER TABLE 
	contacts
MODIFY COLUMN 
	`delete` INT DEFAULT FALSE;

ALTER TABLE 
	contacts
CHANGE 
	`delete` is_delete INT DEFAULT FALSE;

ALTER TABLE 
	contacts
ADD COLUMN 
	public INT;
    
ALTER TABLE 
	contacts
MODIFY COLUMN
	emailAddress VARCHAR(200)
after phone;

ALTER TABLE 
	contacts
MODIFY COLUMN
	Hobbies INT
after photoName;

select * from contacts;

ALTER TABLE 
	contacts
MODIFY COLUMN 
	public VARCHAR(20);
    
-- to disable the safe updates mode
SET SQL_SAFE_UPDATES = 0;
/*update contacts
set `is_delete` = 0
where `is_delete` = 1;*/

-- truncate table contacts;
select * from contacts;
use cfTask2;

SELECT 
	t1.email,
    t2.userId,
	concat(t2.fname," ",t2.lname) as fullname,
    t2.gender,
	t2.DOB,
	t2.photoName,
	t2.phone,
	t2.address,
	t2.street
FROM 
	registerForm AS t1
INNER JOIN 
	contacts AS t2
ON t2.nameId_fk = t1.nameId
WHERE t2.userId = 4;

SELECT 
	t1.title as title_id, 
	fname, 
	lname, 
	gender, 
	DOB, 
	photoName, 
	phone, 
	address, 
	street,
	userId
FROM 
	title_names as T1
INNER JOIN
	contacts AS T2
ON 
	T1.title_id = T2.title_id;

UPDATE 
	contacts
SET 
	public = 'NO';

DELETE FROM 
	contacts
WHERE 
	userId > 26;

select * from contacts;
use cfTask2;

SELECT
	concat(fname," ",lname) AS fullname,
	title_id,
	phone,
	photoName,
	userId,
	is_delete,
	nameId_fk,
	public
FROM 
	contacts
WHERE
	is_delete = 0
	AND (nameId_fk = 12
    OR public = "YES");
    
SELECT 
	T1.title AS title_name,
	T2.fname AS fname, 
	T2.lname AS lname, 
	T2.gender AS gender, 
	T2.DOB AS DOB, 
	T2.photoName AS photoName, 
	T2.phone AS phone, 
	T2.address AS address, 
	T2.street AS street,
	T2.userId AS userId,
	T1.title_id AS title_id,
	T2.public AS public,
	T3.email AS email
FROM 
	title_names AS T1
INNER JOIN
	contacts AS T2
	ON 
		T1.title_id = T2.title_id
INNER JOIN 
	registerForm as T3
	ON
		T2.nameId_fk = T3.nameId
WHERE
	userId = 4;
    

            select
                *
            from
                contacts
            where
                userId = 16;
                
SELECT 
	fname,
    DOB,
	CURDATE() AS today,
    year(NOW()) AS yearToday,
    day(DOB) AS dayToday,
    month(DOB) AS monthToday,
    STR_TO_DATE(CONCAT(YEAR(NOW()), '-', MONTH(DOB), '-', DAY(DOB)), "%Y-%m-%d") AS myDate,
    MAKEDATE(YEAR(NOW()), DAYOFYEAR(DOB)) AS mydate2,
    DAYOFYEAR(DOB) AS `no of days`,
    MAKEDATE(year(NOW()), 12) AS myBirthDay
FROM 
	contacts
WHERE 
	is_delete = 0
;

select * from contacts;
use cfTask2;

CREATE TABLE hobbies (
	Id INT PRIMARY KEY AUTO_INCREMENT,
    hobbies VARCHAR(50)
);


CREATE TABLE User_Hobbies (
	user_hobbie_id INT PRIMARY KEY AUTO_INCREMENT,
    contact_userId INT,
    hobbie_id INT,
    hobbie_created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (contact_userId) REFERENCES contacts(userId),
    FOREIGN KEY (hobbie_id) REFERENCES Hobbies(Id)
);

USE cfTask2;

SELECT * FROM User_Hobbies;

select * from contacts;

select * from hobbies;

select * from contacts;


ALTER table
	User_Hobbies
add column
	hobbie_nameId_fk int;
    
ALTER table
	User_Hobbies
add column
	hobbie_created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP;

ALTER table
	User_Hobbies
CHANGE
	hobbie_nameId_fk contact_nameId_fk int;

ALTER TABLE 
	User_Hobbies
ADD CONSTRAINT 
	fk_hobbie_nameId
FOREIGN KEY 
	(hobbie_nameId_fk) 
REFERENCES 
	contacts(nameId_fk);
    
SELECT LAST_INSERT_ID() AS user_hobbie_id;


SELECT 
	hobbies 
FROM 
	Hobbies
INNER JOIN 
	User_Hobbies
ON 
	Hobbies.Id = User_Hobbies.hobbie_id;
    

update User_Hobbies
set hobbie_id = 4
where user_hobbie_id = 3;

ALTER TABLE User_Hobbies
DROP COLUMN contact_nameId_fk;

ALTER TABLE User_Hobbies
DROP FOREIGN KEY fk_hobbie_nameId;

update hobbies 
SET hobbies = "Reading"
where Id = 2;


use cfTask2;

SELECT 
	T1.Id AS hobbieId,
	T1.hobbies AS hobbieName,
	T2.hobbie_id AS T2hobbieId,
	T2.contact_userId,
	T2.user_hobbie_id,
	T3.is_delete AS is_delete
FROM
	hobbies AS T1
INNER JOIN
	User_Hobbies AS T2
	ON
		T1.Id = T2.hobbie_id
INNER JOIN
	contacts AS T3
	ON
		T3.userId = T2.contact_userId
WHERE
	is_delete = 0
	AND (
		T3.nameId_fk = 12
		OR T3.public = "YES"
	);


