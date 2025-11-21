-----------------------------------------------Anhaaaar

GO

/*
Student exam schedule-lists upcoming exams for given student.
*/

CREATE VIEW V_Student_Exam
AS
 SELECT S.Student_Id AS Student_ID , 
        S.First_Name AS Student_Fname,
		S.Last_Name AS Student_Lname,
		E.Course_Id AS Course_ID,
		E.Exam_Id AS Exam_ID,
		E.E_date AS Exam_Date,
		E.StartTime AS Exam_StartTime, 
		E.EndTime AS Exam_EndTime, 
		E.INS_Id AS Instructor_ID
 FROM Exam AS E
 INNER JOIN Exam_Student AS ES
 ON ES.Exam_Id = E.Exam_Id
 INNER JOIN Student AS S
 ON ES.Student_Id = S.Student_Id
 WHERE E.E_date >= CAST(GETDATE() AS date)

GO
------------excute-------------
SELECT *
FROM V_Student_Exam



------------------------------------------
go
CREATE VIEW V_Student_Answers
AS
 SELECT S.Student_Id AS Student_ID, 
        S.First_Name AS Student_Fname , 
		S.Last_Name AS Student_Lname , 
		E.Exam_Id AS Exam_ID ,
		E.E_date AS Exam_Date,
		SA.Question_Id AS Question_ID,
		Q.Q_Text AS Qusetion_Text,
		SA.st_Answer AS Student_Answer

 FROM Student_Answer AS SA
 INNER JOIN Student AS S
 ON SA.Student_Id = S.Student_Id
 INNER JOIN Exam AS E
 ON SA.Exam_Id = E.Exam_Id
 INNER JOIN Question AS Q
 ON SA.Question_Id = Q.Question_Id

GO
----------------excute-----------------
SELECT *
FROM V_Student_Answers


--------------------------------------------------------
go
CREATE VIEW V_Student_Results
AS 
 SELECT ExamDegree.Exam_Id , 
        Exam_Degree, Student_Id , 
        StudentMarks.Student_Degree_In_Exam, 
		CASE 
           WHEN Student_Degree_In_Exam >= 0.5*Exam_Degree
		   THEN 'Pass'
		   ELSE 'Fail'
		   END AS Student_Status
 FROM 
  (SELECT Exam_Id , SUM(quest_degree) AS Exam_Degree
   FROM Exam_Question 
   GROUP BY Exam_Id) AS ExamDegree
  FULL OUTER JOIN 
  (SELECT Student_Id , Exam_Id , SUM(st_Mark) AS Student_Degree_In_Exam
   FROM Student_Answer 
   GROUP BY Student_Id , Exam_Id) AS StudentMarks
 ON ExamDegree.Exam_Id = StudentMarks.Exam_Id

GO 
-------excute------------
SELECT *
FROM V_Student_Results




-------------------------------ahmed
-- AllStudent view to show all student with thier Intake, branch name , and track name

go
Create or Alter View vw_Allstudent as
select
	[Student_Id]as 'Student ID',
	Concat(rtrim([First_Name]),' ',rtrim([Last_Name])) as 'Full Name',
	[Intake_NO] as 'Intake',
	[Phone] , [B_Name] as 'Branch Name',
	[T_Name] as 'Trake Name'
from Student as Std
inner join Branch as B on Std.branch_id = B.branch_id
inner join Track as T on Std.Track_Id = T.Track_Id




select * from vw_Allstudent


-----------------------------------------

-- AllInstructor view to show all Instrucors with thier courses 
Create or Alter View vw_AllInstructor as
select 
	Ins_c.[INS_Id] as 'Instructor ID',
    ConCat(I.[First_Name],' ',I.[Last_Name]) as 'Instructor Name',
	C.[C_Name] as 'Course Name',
	C.[C_Description] as 'about Course'


from instructor_course as Ins_c
inner join Course As C on Ins_c.[Course_Id] = C.[Course_Id]
inner join Instructor As I on Ins_c.[INS_Id] = I.[INS_Id]




Select * from vw_AllInstructor
