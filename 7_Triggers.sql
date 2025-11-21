----------------------------------------------------------Shimaa
create or alter trigger trg_check_exam_time
on Student_Answer
instead of insert
as
begin
    declare @ExamId int, @StudentId int, @QuestionId int
    declare @StartTime time, @EndTime time, @ExamDate date

    
    select 
        @ExamId = Exam_Id,
        @StudentId = Student_Id,
        @QuestionId = Question_Id
    from inserted

    
    select 
        @StartTime = StartTime,
        @EndTime = EndTime,
        @ExamDate = E_date
    from Exam
    where Exam_Id = @ExamId

   
    if cast(getdate() as date) <> @ExamDate
    begin
        raiserror('Exam is not today',16,1)
        rollback tran
        return
    end

    
    if cast(getdate() as time) < @StartTime
    begin
        raiserror('Exam has not started yet',16,1)
        rollback tran
        return
    end

    
    if cast(getdate() as time) > @EndTime
    begin
        raiserror('Exam has ended',16,1)
        rollback tran
        return
    end

    
    insert into Student_Answer(Ans_Id, Student_Id, Exam_Id, Question_Id, st_Answer)
    select Ans_Id, Student_Id, Exam_Id, Question_Id, st_Answer 
    from inserted
end

--------------------------------------------------Anhaaar
go
CREATE TRIGGER Trg_PrvDelete_Course_WithExams
on Course
AFTER Delete
AS 
 IF EXISTS 
          (SELECT 1 
		   FROM deleted AS D
		   INNER JOIN Exam AS E
		   ON E.Course_Id = D.Course_Id
		   ) 
    BEGIN 
	 
	 SELECT 'You can not delete a course exams'
	 ROLLBACK

	END 

GO 


---------------------------------------------------------Salma
-- in this trigger we suggest that every day teaning manger will log in at 9 am and the trigger fire just in update or insert or delete
----after searching well we can find that SQL Server also has DDL triggers (on schema changes 
--like CREATE TABLE) and LOGON triggers (when someone logs in).
--so we make it when reole reainig manager log in 9 am the trigger fire
--we can do it with schedule too
go

CREATE OR ALTER TRIGGER trg_BackupOnTrainingManagerLogon
ON ALL SERVER
FOR LOGON
AS
BEGIN
    IF ORIGINAL_LOGIN() = 'TrainingManager'
       AND DATEPART(HOUR, GETDATE()) = 9
      
    BEGIN
        BACKUP DATABASE [YourDatabaseName]
        TO DISK = 'C:\SQLBackups\Backup_At9AM.bak'
        WITH INIT,
             NAME = 'Backup triggered by Training Manager at 9 AM';

      

    END
END;


