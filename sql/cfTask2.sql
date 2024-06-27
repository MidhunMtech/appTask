CREATE DATABASE IF NOT EXISTS cfTask2;

USE cfTask2;

CREATE TABLE registerForm (
		nameID INT AUTO_INCREMENT PRIMARY KEY,
        fullname VARCHAR(50),
        email VARCHAR(50),
        username VARCHAR(50),
        password VARCHAR(20)
);
 SELECT * FROM registerForm;
 truncate table registerForm;
 
 CREATE TABLE contacts (
	userId INT AUTO_INCREMENT PRIMARY KEY,
	title VARCHAR(5),
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

select * from contacts;
