#create the database
DROP DATABASE IF EXISTS teachers_aide;
CREATE DATABASE IF NOT EXISTS teachers_aide;
USE teachers_aide;
 
#delete all of the tables if they exist
DROP TABLE IF EXISTS allowing,
					 attending,
					 calcFeatures,
                     classes,
                     devices,
                     professors,
                     schools,
                     tests;

#Create tables of the database
CREATE TABLE IF NOT EXISTS Schools (
	schoolID INT NOT NULL,
    schoolName VARCHAR(50),
    PRIMARY KEY (schoolID)
    );
    
CREATE TABLE IF NOT EXISTS Professors (
	professorID INT NOT NULL,
    schoolID INT NOT NULL,
    firstName VARCHAR(20) NOT NULL,
    lastName VARCHAR(20),
    email VARCHAR(40),
    phoneNumber VARCHAR(20),
    PRIMARY KEY (professorID),
    FOREIGN KEY (schoolID) REFERENCES Schools(schoolID)
    );

CREATE TABLE IF NOT EXISTS Classes (
	classID VARCHAR(10) NOT NULL,
    professorID INT NOT NULL,
    schoolID INT NOT NULL,
    className VARCHAR(20) NOT NULL,
    classSubject VARCHAR(10) NOT NULL,
    classPassword VARCHAR(20) NOT NULL,
    PRIMARY KEY (classID),
    FOREIGN KEY (professorID) REFERENCES Professors(professorID),
    FOREIGN KEY (schoolID) REFERENCES Schools(schoolID)
    );
    
CREATE TABLE IF NOT EXISTS CalcFeatures (
	featureID INT NOT NULL,
    featureName VARCHAR(50),
    PRIMARY KEY (featureID)
    );
    
CREATE TABLE IF NOT EXISTS Tests (
	testID INT NOT NULL,
    classID VARCHAR(10) NOT NULL,
    startTime DATETIME NOT NULL,
    endTime DATETIME,
    disablePhone INT NOT NULL,
    PRIMARY KEY (testID),
    FOREIGN KEY (classID) REFERENCES Classes(classID),
    CHECK(startTime < endTime)
    );
    
CREATE TABLE IF NOT EXISTS Allowing (
	featureID INT NOT NULL,
    testID INT NOT NULL,
    PRIMARY KEY (featureID, testID),
	FOREIGN KEY (featureID) REFERENCES CalcFeatures(featureID),
    FOREIGN KEY (testID) REFERENCES Tests(testID)
    );
    
CREATE TABLE IF NOT EXISTS Devices (
	deviceID INT NOT NULL,
    testID INT,
    devicePassword VARCHAR(20) NOT NULL,
    isDisabled INT NOT NULL,
    PRIMARY KEY (deviceID),
    FOREIGN KEY (testID) REFERENCES Tests(testID)
    );

CREATE TABLE IF NOT EXISTS Students (
	studentID INT NOT NULL,
    deviceID INT,
    firstName VARCHAR(20) NOT NULL,
    lastName VARCHAR(20),
    SSN VARCHAR(10) NOT NULL,
    PRIMARY KEY (SSN),
    FOREIGN KEY (deviceID) REFERENCES Devices(deviceID)
    );
    
CREATE TABLE IF NOT EXISTS Attending (
	SSN VARCHAR(10) NOT NULL,
    classID VARCHAR(10) NOT NULL,
    fromDate DATE NOT NULL,
    toDate DATE,
    midGrade INT,
    finalGrade INT,
    PRIMARY KEY (SSN, classID),
    FOREIGN KEY (SSN) REFERENCES Students(SSN),
    FOREIGN KEY (classID) REFERENCES Classes(classID),
    CHECK(fromDate > toDate)
    ); 

#Inserts professors from csv file
#LOAD DATA INFILE 'c:/ProgramData/MySQL/MySQL Server 8.0/Uploads/professors1.csv'
#	INTO TABLE Professors
#    FIELDS TERMINATED BY ','
#    ENCLOSED BY '"'
#    LINES TERMINATED BY '\n'
#    IGNORE 1 ROWS;

#Create a view for the professors to see all the students according to professor
CREATE OR REPLACE VIEW professorsOfStudents AS 
	SELECT s.StudentID, s.firstName AS studentFirstName, s.lastName AS studentLastName, p.professorID, 
		   p.firstName AS professorFirstName, p.lastName AS professorLastName FROM Students s, Classes c, Professors p, Attending a
		WHERE a.classID = c.classID AND p.professorID = c.professorID AND s.SSN = a.SSN;


#Load the database info
FLUSH LOGS;

SELECT 'Loading Schools' as 'INFO';
SOURCE load_schools.dump;
    
SELECT 'Loading Professors' as 'INFO';
SOURCE load_professors.dump;
    
SELECT 'Loading Classes' as 'INFO';
SOURCE load_classes.dump;    

SELECT 'Loading calcFeatures' as 'INFO';
SOURCE load_calcFeatures.dump;

SELECT 'Loading Tests' as 'INFO';
SOURCE load_tests.dump;
    
SELECT 'Loading Allowing' as 'INFO';
SOURCE load_allowing.dump;
    
SELECT 'Loading Devices' as 'INFO';
SOURCE load_devices.dump;

SELECT 'Loading Students' as 'INFO';
SOURCE load_students.dump;

SELECT 'Loading Attending' as 'INFO';
SOURCE load_attending.dump;