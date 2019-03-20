#Create database if it does not exist
CREATE DATABASE IF NOT EXISTS dreamHomeRental;
#Select new database
USE dreamHomeRental;

#Create tables
CREATE TABLE IF NOT EXISTS PropertyForRent(
	propertyNo varchar(10) NOT NULL,
	noRooms int NOT NULL DEFAULT 4,
    rent int NOT NULL DEFAULT 600,
    PRIMARY KEY(propertyNo),
    CHECK (rent >=500)
);

CREATE TABLE IF NOT EXISTS Clients(
	ClientNo INT NOT NULL,
    First_Name VARCHAR(20) NULL,
    LAST_NAME VARCHAR(20) NULL,
    viewDate DATE NULL,
    propNo VARCHAR(10),
    PRIMARY KEY(CLientNo),
    FOREIGN KEY(propNo) REFERENCES PropertyForRent(propertyNo)
		ON DELETE SET NULL
);

ALTER TABLE Clients
	ADD gender char(1) NOT NULL AFTER viewDate;

describe clients;
#INSERT INTO propertyForRent (propertyNo, rent) VALUES('PLC04', 600);
SELECT * FROM propertyForRent;