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
    phoneNumber VARCHAR(10),
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

#Create a view for the first professor to see all the students in the class
CREATE VIEW inClass AS 
	SELECT * FROM Students WHERE studentID IN (
		SELECT studentID FROM Attending WHERE ClassID IN (
			SELECT classID FROM ClassID Where professorID = 0
            )
		);
