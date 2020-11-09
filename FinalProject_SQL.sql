SELECT * FROM GradeRecordModuleV

--CREATE Master table GradeRecord--

SELECT * INTO GradeRecord
FROM GradeRecordModuleV

SELECT * FROM GradeRecord

--1NF, Normalizing DataSet, find duplicate rows--

SELECT * FROM GradeRecord

SELECT First_name, Lastname FROM GradeRecord
GROUP BY First_name, Lastname
HAVING COUNT(*)>1


DELETE FROM GradeRecord
WHERE studentID Not IN (
	SELECT MIN (studentID)
	FROM GradeRecord
	GROUP BY First_name, Lastname
	)


==2NF, eliminate redundant data, no redundant data found--

--Creating PRIMARY KEYS on StudentName table, ADD CONTRAINTS if needed to prevent duplicate rows on studentID attributes--

ALTER TABLE StudentNames
ADD CONSTRAINT PK_StudentNames PRIMARY KEY (studentID);

ALTER TABLE StudentNames
ADD PRIMARY KEY (studentID);

--Creating FOREIGN KEYS on StudentGrades table--

ALTER TABLE StudentGrades
ADD FOREIGN KEY (studentID) REFERENCES StudentNames (studentID);


--3NF, Normalizing DataSet--

	-- CREATE new Table StudentNames using AS --

CREATE TABLE StudentNames AS
SELECT studentID, First_name, Lastname, Grade
FROM GradeRecord

--didn't work,incorrect syntax near 'SELECT', expecting EDGE_TYPE, or FILETABLE--

	-- CREATE new Table StudentNames--


CREATE TABLE StudentNames (
studentID int not null,
First_name nvarchar (50),
Lastname nvarchar (50),
Grade nvarchar (50)
);


	-- INSERT attributes to StudentNames table from GradeRecord table--

INSERT INTO StudentNames (studentID, First_name, Lastname, Grade)
SELECT studentID, First_name, Lastname, Grade
FROM GradeRecord

SELECT * FROM StudentNames


	-- CREATE new Table StudentGrades--

CREATE TABLE StudentGrades (
studentID int not null,
Grade nvarchar (50),
Midtermexam nvarchar(50),
Finalexam float,
assignment1 nvarchar(50), 
assignment2 float,
Totalpoints int, 
Studentaverage float
);


	-- INSERT attributes to StudentGrades table from GradeRecord table--

Insert INTO StudentGrades (studentID, Grade, Midtermexam, Finalexam, assignment1, assignment2, Totalpoints, Studentaverage)
SELECT studentID, Grade, Midtermexam, Finalexam, assignment1, assignment2, Totalpoints, Studentaverage
FROM GradeRecord

SELECT * FROM StudentGrades

	--SELECT two table--

SELECT * FROM StudentNames
SELECT * FROM StudentGrades

--Creating PRIMARY KEYS on StudentName table, ADD CONTRAINTS if needed to prevent duplicate rows on studentID attributes--

ALTER TABLE StudentNames
ADD CONSTRAINT PK_StudentNames PRIMARY KEY (studentID);

ALTER TABLE StudentNames
ADD PRIMARY KEY (studentID);

--Creating FOREIGN KEYS on StudentGrades table--

ALTER TABLE StudentGrades
ADD FOREIGN KEY (studentID) REFERENCES StudentNames (studentID);

--using JOIN with PRIMARY KEY and FOREIGN KEYS to establish relationship--

CREATE TABLE JoinTable AS 

SELECT StudentNames.studentID, StudentNames.First_name, StudentNames.LastName,StudentGrades.Grade,StudentGrades.Midtermexam,StudentGrades.Finalexam, StudentGrades.Studentaverage
FROM StudentNames
FULL JOIN StudentGrades ON StudentNames.studentID=StudentGrades.studentID
WHERE Finalexam BETWEEN 0.40 AND 0.80


---END---

--INF, put into one column named assignment from two columns assignment1 and assignmentr2, to shpw relationships bet. PK and FK-- 

SELECT * INTO GradeStudent
FROM Grades

SELECT * FROM GradeStudent

DROP TABLE AssignmentsCombo
DROP TABLE AssignmentsCombo1


CREATE TABLE AssignmentsCombo (
studentID int not NULl,
First_name nvarchar (50),
Lastname nvarchar (50)
);

SELECT * FROM AssignmentsCombo

Insert INTO AssignmentsCombo (studentID, First_name, Lastname)
SELECT studentID, First_name, Lastname
FROM Grades


CREATE TABLE AssignmentsCombo1 (
studentID int not NULl,
Assignment float
);

Insert INTO AssignmentsCombo Values (3553,'John','Henstridge'), (94586,'Lucas', 'McGee'), (31322,'Tony', 'Shade'), (20335, 'Cutler', 'Melmore') 


INSERT INTO AssignmentsCombo1 
Values (3553,0.78),(3553,0.71),(94586,0.68),(94586,.84), (31322, 0.88), (31322, 0.90), (20335, 0.94), (20335, 0.69), (1, 0.8)

SELECT * FROM AssignmentsCombo
SELECT * FROM AssignmentsCombo1