#create the schema for the teachers aide application if it does not exist already
CREATE SCHEMA IF NOT EXISTS teachers_aide;

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
    startTime DATE NOT NULL,
    endTime DATE,
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
    PRIMARY KEY (studentID),
    FOREIGN KEY (deviceID) REFERENCES Devices(deviceID)
    );
    
CREATE TABLE IF NOT EXISTS Attending (
	studentID INT NOT NULL,
    classID VARCHAR(10) NOT NULL,
    fromDate DATE NOT NULL,
    toDate DATE,
    midGrade INT,
    finalGrade INT,
    PRIMARY KEY (studentID, classID),
    FOREIGN KEY (studentID) REFERENCES Students(studentID),
    FOREIGN KEY (classID) REFERENCES Classes(classID),
    CHECK(fromDate > toDate)
    ); 

#Inserts tennessee state university as a school in the schools table
INSERT INTO Schools (schoolID, schoolName)
	VALUES(0, 'Tennessee State University');

#Inserts professors from csv file
LOAD DATA INFILE 'c:/ProgramData/MySQL/MySQL Server 8.0/Uploads/professors1.csv'
	INTO TABLE Professors
    FIELDS TERMINATED BY ','
    ENCLOSED BY '"'
    LINES TERMINATED BY '\n'
    IGNORE 1 ROWS;
    
#Add set of professors to professor table
INSERT INTO Professors(professorID, firstName, lastName, email, phoneNumber)
	VALUES (0, 0, 'Manar', 'Samad', 'msamad@tnstate.edu', '123-456-7890'), (1, 0, 'Ali', 'Sekmen', 'asekmen@tnstate.edu', '234-567-8901'), 
		(2, 0, 'Fenghui', 'Yao', 'fyao@tnstate.edu', '345-678-9012');
    
#Add set of students to student table
INSERT INTO Students(studentID, firstName, lastName, SSN)
	VALUES (0, 'Mike', 'Mohieddin', '123456789'), (1, 'John', 'Doe', '0000000000'), (2, 'Jane', 'Smith', '111111111');
    
#Add set of classes to classes table
INSERT INTO Classes(classID, professorID, schoolID, className, classSubject, classPassword)
	VALUES ();
    
SELECT * FROM Students;

#Create a view for the professors to see all the students according to professor
CREATE VIEW inClass AS 
	SELECT s.studentID, s.firstName AS studentFirstName, s.lastName AS studentLastName, p.professorID, p.professorID, 
		   p.firstName AS professorFirstName, p.lastName AS professorLastName FROM Students s, Classes c, Professors p
		WHERE s.classID = c.classID AND c.professorID = p.professorID;
