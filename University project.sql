# MySQL Script created by Marie Schürmann
# Trinity Business School -- M.Sc. Business Analytics 21/22
# Individual Assignment in BU7141: Business Data Management and Visualisation
# Date of SQL Script Creation: 15/10/2021
--------------------------------------------------------------------
# creation of a database for the university case
CREATE DATABASE  IF NOT EXISTS university;
USE university;

# creation of a table containing all the programmes
CREATE TABLE programmes (
	programmeNo int NOT NULL AUTO_INCREMENT, 
    programmeName varchar(255),
    PRIMARY KEY (programmeNo)
    );

# creation of a table containing all the students immatriculated in the university
CREATE TABLE students (
	studentID int NOT NULL AUTO_INCREMENT,
	programmeNo int NOT NULL,
    lastName varchar(20) NOT NULL, 
    firstName varchar(40) NOT NULL,
    address varchar(255) NOT NULL,
    phoneNo int NOT NULL,
    PRIMARY KEY (studentID),
    FOREIGN KEY (programmeNo)
		REFERENCES programmes(programmeNo)
);

# creation of a table containing all staff (teaching and non-teaching)
CREATE TABLE staff (
	staffID int NOT NULL AUTO_INCREMENT,
    lastName varchar(255) NOT NULL,
    firstName varchar(255) NOT NULL,
	salary int NOT NULL,
    roleProfessional varchar(255) DEFAULT NULL,
    PRIMARY KEY (staffID)
    );
    
# creation of a table containing all the courses
CREATE TABLE courses (
	courseNo int NOT NULL AUTO_INCREMENT,
    courseName varchar(255) NOT NULL,
    programmeNo int NOT NULL,
    staffID int NOT NULL,
    maxNoStudents int NOT NULL,
    PRIMARY KEY (courseNo),
FOREIGN KEY (programmeNo) 
		REFERENCES programmes(programmeNo),
FOREIGN KEY (staffID) 
		REFERENCES staff(staffID)
    );

# creation of a table containing the course choices students made
CREATE TABLE course_choice (
	choice int NOT NULL AUTO_INCREMENT,
    student int NOT NULL,
    course int NOT NULL,
    acception varchar(10) NOT NULL,
    PRIMARY KEY (choice),
    FOREIGN KEY (student)
		REFERENCES students(studentID),
	FOREIGN KEY (course)
		REFERENCES courses(courseNo)
    );

# creation a table containing all complaints and their statuses    
CREATE TABLE complaints (
	complaintID int NOT NULL AUTO_INCREMENT,
    complaintDesc varchar(255) NOT NULL,
	studentNo int NOT NULL,
    courseNo int DEFAULT NULL,
    staffNo int DEFAULT NULL,
	resolution varchar(10) DEFAULT "open",
    PRIMARY KEY (complaintID),
    FOREIGN KEY (studentNo)
		REFERENCES students(studentID),
	FOREIGN KEY (courseNo)
		REFERENCES courses(courseNo),
	FOREIGN KEY (staffNo)
		REFERENCES staff(staffID)
    );

# filling values into the tables
# university programmes:
INSERT INTO programmes (programmeName)
	VALUES ("Business Analytics");
INSERT INTO programmes (programmeName)
	VALUES ("Finance");
INSERT INTO programmes (programmeName)
	VALUES ("Management");
INSERT INTO programmes (programmeName)
	VALUES ("Marketing");
INSERT INTO programmes (programmeName)
	VALUES ("Entrepreneurship");

# see information of programmes in MySQL workbench:
SELECT * FROM university.programmes;
    
# students:
INSERT INTO students (programmeNo, lastName, firstName, address, phoneNo)
	VALUES (2, "Granger", "Hermione Jane", "6 Willifield Way, London, UK", 12345);
INSERT INTO students (programmeNo, lastName, firstName, address, phoneNo)
	VALUES (1, "Potter", "Harry James", "4 Privet Drive, Little Whinging, UK", 447923);
INSERT INTO students (programmeNo, lastName, firstName, address, phoneNo)
	VALUES (4, "Weasley", "Ronald Bilius", "The Burrow, Ottery St. Catchpole, UK", 42938);
INSERT INTO students (programmeNo, lastName, firstName, address, phoneNo)
	VALUES (5, "Lovegood", "Luna", "Lovegood House, Ottery St. Catchpole, UK", 54878);
INSERT INTO students (programmeNo, lastName, firstName, address, phoneNo)
	VALUES (3, "Malfoy", "Draco", "Malfoy Manor, Wiltshire, UK", 345776);
    
# see information of students in MySQL workbench:
SELECT * FROM university.students;
    
# staff:
INSERT INTO staff (lastName, firstName, salary)
	VALUES ("McGonagall", "Minerva", 35000);
INSERT INTO staff (lastName, firstName, salary)
	VALUES ("Snape", "Severus", 35000);
INSERT INTO staff (lastName, firstName, salary, roleProfessional)
	VALUES ("Filch", "Argus", 13000, "Caretaker");
INSERT INTO staff (lastName, firstName, salary)
	VALUES ("Lupin", "Remus", 25000);
INSERT INTO staff (lastName, firstName, salary, roleProfessional)
	VALUES ("Pomfrey", "Poppy", 25000, "Nurse");
    
# see information of staff in MySQL workbench:
SELECT * FROM university.staff;

# courses:
INSERT INTO courses (courseName, programmeNo, staffID, maxNoStudents)
	VALUES ("International Financial Statement Analysis", 2, 4, 30);
INSERT INTO courses (courseName, programmeNo, staffID, maxNoStudents)
	VALUES ("International Entrepreneurship", 5, 2, 15);
INSERT INTO courses (courseName, programmeNo, staffID, maxNoStudents)
	VALUES ("Machine Learning", 1, 1, 40);
INSERT INTO courses (courseName, programmeNo, staffID, maxNoStudents)
	VALUES ("Project Management", 3, 2, 50);
INSERT INTO courses (courseName, programmeNo, staffID, maxNoStudents)
	VALUES ("Marketing Management", 3, 4, 20);
    
# see information of courses in MySQL workbench:
SELECT * FROM university.courses;

# course_choice:
INSERT INTO course_choice (student, course, acception)
	VALUES (2, 2, "approved");
INSERT INTO course_choice (student, course, acception)
	VALUES (3, 5, "approved");
INSERT INTO course_choice (student, course, acception)
	VALUES (2, 3, "approved");
INSERT INTO course_choice (student, course, acception)
	VALUES (1, 5, "no");
INSERT INTO course_choice (student, course, acception)
	VALUES (4, 2, "no");
    
# see information of course courses in MySQL workbench:
SELECT * FROM university.course_choice;

# complaints:
INSERT INTO complaints (complaintDesc, studentNo, courseNo)
	VALUES ("The course is too slow for me", 1, 3);
INSERT INTO complaints (complaintDesc, studentNo, staffNo)
	VALUES ("The waiting time when Mdm. Pomfrey attends is too long", 2, 5);
INSERT INTO complaints (complaintDesc, studentNo, courseNo)
	VALUES ("The course contents are not what I expected.", 5, 5);
INSERT INTO complaints (complaintDesc, studentNo, staffNo)
	VALUES ("Mr. Snape is grading me not fairly.", 2, 2);
INSERT INTO complaints (complaintDesc, studentNo, courseNo, staffNo)
	VALUES ("The course could be improved by more interactive contents.", 4, 5, 4);

# see information of complaints in MySQL workbench:
SELECT * FROM university.complaints;