----------------------------------------salma
 go
  CREATE OR ALTER VIEW vw_CoursePerformance
AS
SELECT 
    C.Course_Id,
    C.C_Name,
    AVG(dbo.fn_GetTotalGrade(S.Student_Id, E.Exam_Id) * 1.0) AS AvgScore,
    MIN(dbo.fn_GetTotalGrade(S.Student_Id, E.Exam_Id)) AS MinScore,
    MAX(dbo.fn_GetTotalGrade(S.Student_Id, E.Exam_Id)) AS MaxScore,
    COUNT(DISTINCT S.Student_Id) AS TotalStudents
FROM Course C
INNER JOIN Exam E 
    ON C.Course_Id = E.Course_Id
INNER JOIN Student_Answer SA 
    ON SA.Exam_Id = E.Exam_Id
INNER JOIN Student S 
    ON S.Student_Id = SA.Student_Id
GROUP BY C.Course_Id, C.C_Name;



SELECT * FROM vw_CoursePerformance;

----------------------------------------------------------------------222
go
use ITI_Project_Local
go
CREATE OR ALTER VIEW vw_PassRatePerCourse
AS
SELECT 
    C.Course_Id,
    C.C_Name,
    COUNT(DISTINCT S.Student_Id) AS Total_Students,
    SUM(CASE 
            WHEN dbo.fn_GetTotalGrade(S.Student_Id, E.Exam_Id) >= 50 
            THEN 1 ELSE 0 
        END) AS Passed_Students,
    CAST(
        ISNULL(SUM(CASE 
                       WHEN dbo.fn_GetTotalGrade(S.Student_Id, E.Exam_Id) >= 50 
                       THEN 1 ELSE 0 
                   END) * 10.0 / 
              NULLIF(COUNT(DISTINCT S.Student_Id), 0), 0) 
        AS int
    ) AS PassRate_Percentage
FROM Course C
LEFT JOIN Exam E 
       ON C.Course_Id = E.Course_Id
LEFT JOIN Student_Answer SA 
       ON SA.Exam_Id = E.Exam_Id
LEFT JOIN Student S 
       ON S.Student_Id = SA.Student_Id
GROUP BY C.Course_Id, C.C_Name;
GO

SELECT * FROM vw_PassRatePerCourse;

-------------------------------------------------------333333333

go
CREATE OR ALTER VIEW vw_PendingTextAnswers
AS
SELECT 
    SA.Student_Id,
    S.First_Name + ' ' + S.Last_Name AS StudentName,
    SA.Exam_Id,
    Q.Question_Id,
    Q.Q_Text,
    SA.st_Answer
   
FROM Student_Answer SA
JOIN Question Q 
    ON SA.Question_Id = Q.Question_Id
JOIN Student S 
    ON SA.Student_Id = S.Student_Id
WHERE Q.Q_Type = 'Text'
  AND SA.st_Mark IS NULL;  -- awaiting 


  SELECT * FROM vw_PendingTextAnswers;


--------------------------------------------------------------------------------------shimaa

----------------------------------------------------
---------------- view diplay questions
go
create or alter view v_display_questions_Mcq
as
select q.Question_Id, q.Q_Text, q.Course_Id, q.Q_Type ,m.Choice1,
m.Choice2 , m.Choice3 , m.Choice4 , m.Correct_Answer
from Question q join MCQ m on 
q.Question_Id = m.Question_Id
where Q_Type  = 'MCQ'
---------------------
go
create or alter view v_display_questions_TF
as
select q.Question_Id, q.Q_Text, q.Course_Id, q.Q_Type ,t.Choice1 , t.Choice2, t.Correct_Answer
from Question q join Q_T_F t 
on q.Question_Id = t.Question_Id
where Q_Type  = 'True/False'

-------------
go
create or alter view v_display_questions_text
as
select q.Question_Id, q.Q_Text, q.Course_Id, q.Q_Type , x.Correct_Answer
from Question q join Text_Question x 
on q.Question_Id = x.Question_Id 
where Q_Type = 'Text'


---------------- proc to select from view 
go
create or alter procedure display_view_questions_sp 
                               @C_id int
as
begin 
    select * from v_display_questions_Mcq 
    where Course_Id = @C_id
    select * from v_display_questions_TF
    where Course_Id = @C_id
    select * from v_display_questions_text
    where Course_Id = @C_id
end

exec display_view_questions_sp
@C_id = 1 

-------------------------------------------------------------
-------------- view diplay exams 
go
create or alter view v_display_exam
as
select * from Exam 

-------------proc to select from view  
go
create or alter procedure display_exams_sp
                     @INS_id int ,
                     @Course_id int 
as 
begin 
    select * from v_display_exam
    where INS_Id = @INS_id and Course_id = @Course_id 
end 

exec display_exams_sp
 @INS_id = 1 ,
 @Course_id = 1
--------------------
go
create or alter procedure display_all_exams_sp                                      
as 
begin 
    select * from v_display_exam     
end 


exec display_all_exams_sp 

---------------------------------------------------------------
--------------- display exam with questions 
go
create or alter view v_display_exam_questions_mcq
as
select e.Exam_Id ,q.Q_Text ,m.Choice2 , m.Choice3 , m.Choice4 ,
m.Correct_Answer ,e.quest_degree
from  Question q join MCQ m
on q.Question_Id = m.Question_Id
join Exam_Question e
on q.Question_Id = e.Question_Id

go
create or alter view v_display_exam_questions_tf
as
select e.Exam_Id ,q.Q_Text ,t.Choice2 ,t.Correct_Answer ,e.quest_degree
from  Question q join Q_T_F t
on q.Question_Id = t.Question_Id
join Exam_Question e
on q.Question_Id = e.Question_Id

go
create or alter view v_display_exam_questions_text
as
select e.Exam_Id ,q.Q_Text ,x.Correct_Answer ,e.quest_degree 
from  Question q join Text_Question x
on q.Question_Id = x.Question_Id
join Exam_Question e
on q.Question_Id = e.Question_Id
----------- proc to select from view 
go
create or alter procedure display_all_questions_exams_sp
                       @exam_id int 

as 
begin 
    select * from v_display_exam_questions_mcq  
    where Exam_Id = @exam_id
    select * from v_display_exam_questions_tf  
    where Exam_Id = @exam_id
    select * from v_display_exam_questions_text  
    where Exam_Id = @exam_id
end 
----------------
go
exec display_all_questions_exams_sp
@exam_id = 2

select * from Exam_Question