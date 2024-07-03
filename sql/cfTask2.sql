CREATE DATABASE IF NOT EXISTS cfTask2;

USE cfTask2;

CREATE TABLE registerForm (
		nameID INT AUTO_INCREMENT PRIMARY KEY,
        fullname VARCHAR(50),
        email VARCHAR(50),
        username VARCHAR(50),
        password VARCHAR(20)
);

-- Disable foreign key checks
SET FOREIGN_KEY_CHECKS = 0;

-- Enable foreign key checks
SET FOREIGN_KEY_CHECKS = 1;
 SELECT * FROM registerForm;
 truncate table registerForm;
 
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
    
 select * from title_names;
 
 CREATE TABLE contacts (
	userId INT AUTO_INCREMENT PRIMARY KEY,
	title_id INT,
    fname VARCHAR(50),
    lname VARCHAR(50),
    gender VARCHAR(10),
    DOB DATE,
    photoName VARCHAR(100),
    phone VARCHAR(20),
    address VARCHAR(100),
    street VARCHAR(50)
);

ALTER TABLE 
	contacts
ADD CONSTRAINT 
	fk_user
FOREIGN KEY 
	(nameId_fk) 
REFERENCES 
	registerForm(nameID);

ALTER TABLE contacts
CHANGE title title_id INT;

ALTER TABLE 
	contacts
ADD CONSTRAINT 
	fk_title
FOREIGN KEY 
	(title_id) 
REFERENCES 
	title_names(title_id);
    
ALTER TABLE contacts
ADD COLUMN `delete` INT DEFAULT TRUE;

ALTER TABLE contacts
ADD COLUMN nameId_fk INT;

ALTER TABLE contacts
MODIFY COLUMN `delete` INT DEFAULT FALSE;

ALTER TABLE contacts
CHANGE `delete` is_delete INT DEFAULT FALSE;

SET SQL_SAFE_UPDATES = 0;
/*update contacts
set `delete` = 0
where `delete` = 1;*/

truncate table contacts;
select * from contacts;

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
ON T1.title_id = T2.title_id;
