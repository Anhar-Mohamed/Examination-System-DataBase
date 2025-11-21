-----------------------------------------------------------------------------------------------------------------111111Shimaa

----------------------------------------------------------------
-------------------- add question ------------------------------
create or alter procedure add_question_sp
    @Q_id int,
    @Q_Text nvarchar(500),
    @Q_Type nvarchar(50),
    @Course_Id int,
    @Choice1 nvarchar(200) = NULL,
    @Choice2 nvarchar(200) = NULL,
    @Choice3 nvarchar(200) = NULL,
    @Choice4 nvarchar(200) = NULL,
    @Correct_Answer nvarchar(500) 
as
begin
    if @Q_id is null
    begin
        print 'Q_id is required'
        return
    end

    else if @Q_Text is null 
    begin
        print ' text of question is required'
        return
    end

    else if @Q_Type is null
    begin
        print 'type of question is required'
        return
    end

    else if @Course_Id is null
    begin
        print 'course is required'
        return
    end

    else if @Correct_Answer is null
    begin
        print 'correct answer is required'
        return
    end


    begin try
        begin tran
        insert into Question (Question_Id , Q_Text , Q_Type , Course_Id)
        values (@Q_id, @Q_Text, @Q_Type, @Course_Id)

        if @Q_Type = 'MCQ'
        begin
            insert into MCQ (Question_Id, Choice1, Choice2, Choice3, Choice4, Correct_Answer)
            values(@Q_id, @Choice1, @Choice2, @Choice3, @Choice4, @Correct_Answer)
        end


        else if @Q_Type = 'True&False'
        begin
            insert into Q_T_F (Question_Id, Choice1, Choice2, Correct_Answer)
            values (@Q_id , 'True', 'False', @Correct_Answer)
        end

        else if @Q_Type = 'Text'
        begin
            insert into Text_Question (Question_Id, Correct_Answer)
            values (@Q_id, @Correct_Answer)
        end

        commit tran
        print 'done add question successfully'
    end try

    begin catch
        rollback tran

        declare @ErrMsg nvarchar(4000)
        set @ErrMsg = ERROR_MESSAGE()

        if ERROR_NUMBER() = 2627  
            print 'Sorry,you canot enter duplicated question_id'
        else if ERROR_NUMBER() = 547  
            print 'this course isnot exist '
           
       else
            print 'unexpected error ' + @ErrMsg
    end catch
end


exec add_question_sp
    @Q_id = 41,
    @Q_Text = 'What is the data type of "shimaa"?',
    @Q_Type = 'MCQ',
    @Course_Id = 10 ,
    @Choice1 = 'int',
    @Choice2 = 'float',
    @Choice3 = 'string',
    @Choice4 = 'boolian',
    @Correct_Answer = 'string' 
    select * from MCQ
------------------------------------------------------------------------ 
-------------------- add exam ------------------------------------------

go
create OR alter procedure add_exam_sp
    @Exam_Id int,
    @E_Type CHAR(30),
    @StartTime TIME,
    @EndTime TIME,
    @E_date DATE,
    @INS_Id INT,
    @Intake_NO INT, 
    @Course_Id INT,
    @E_AllowedOption BIT
as
begin
    if not exists (
        select 1
        from instructor_course
        where INS_Id = @INS_Id and Course_Id = @Course_Id
    )
    begin
        raiserror('You should pick exam for your courses only', 16, 1)
        return
    end

    else if @EndTime <= @StartTime
    begin
        raiserror('Exam end time must be greater than start time', 16, 1)
        return
    end

    else if @E_date < CAST(GETDATE() as date)
    begin
        raiserror('Exam date cannot be in the past', 16, 1)
        return
    end

    insert into Exam (Exam_Id ,E_Type, StartTime, EndTime, E_Date,  INS_Id, Intake_NO, Course_Id, E_AllowedOption)
    values (@Exam_Id,@E_Type, @StartTime, @EndTime, @E_date, @INS_Id, @Intake_No, @Course_Id, @E_AllowedOption);

    print ' Exam added successfully'
end
go


exec add_exam_sp 
    @Exam_Id = 2,
    @E_Type = 'Exam',
    @StartTime = '16:15',   
    @EndTime = '17:00',     
    @E_date = '2025-08-21', 
    @INS_Id = 5,
    @Intake_No = 45,
    @Course_Id = 5,
    @E_AllowedOption=1
    select * from Exam
--------------------------------------------------------------------------
-----------------add questions into exam 
------------------------------------------------------------------------ 
go
create or alter procedure add_question_into_exam_sp
    @Exam_Id int,
    @Question_Id int,
    @quest_degree int
as
begin
    declare @total_degree int;  
    declare @current_sum int ;         

    select @total_degree = c.Max_Deg
    from   Exam e , Course  c
    where e.Course_Id = c.Course_Id and Exam_Id = @Exam_Id 
  

    select @current_sum = isnull(sum(quest_degree), 0)
    from  Exam_Question
    where Exam_Id = @Exam_Id

    if not exists (select 1 from Exam where Exam_Id = @Exam_Id)
    begin
    raiserror('Exam not found', 16, 1)
return
    end

    else if exists (select 1 from Exam_Question 
    where Exam_Id = @Exam_Id and Question_Id = @Question_Id)
    begin
       raiserror('This question already exists in the exam', 16, 1)
   return
    end

    else if not exists (
    select 1
    from Question q
    join Exam e on q.Course_Id = e.Course_Id
    where q.Question_Id = @Question_Id and e.Exam_Id = @Exam_Id
    )
    begin
       raiserror('This question does not belong to the same course as the exam', 16, 1)
   return
    end

    else if @quest_degree <= 0
    begin
       raiserror('Question degree must be greater than zero', 16, 1)
   return
    end

    else if @current_sum + @quest_degree <= @total_degree
    begin
        INSERT INTO Exam_Question (Exam_Id, Question_Id, quest_degree)
        VALUES (@Exam_Id, @Question_Id, @quest_degree)
    end

    else
    begin
        raiserror ('Adding this question will exceed the total exam degree', 16, 1)
        return
    end

end
-----------------------------------------------------------------
--- execute ----------------
execute add_question_into_exam_sp
    @Exam_Id = 2 ,
    @Question_Id = 12,
    @quest_degree =2 

    select * from Exam_Question










------------------------------------------------------------------------------------------22222222222Salma



go
CREATE OR ALTER PROCEDURE sp_AddInstructor
    @User_Id INT,
    @INS_Id INT,
    @First_Name NVARCHAR(50),
    @Last_Name NVARCHAR(50),
    @Email NVARCHAR(100),
    @Phone VARCHAR(11),
    @UserName NVARCHAR(100),
    @Password NVARCHAR(100)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;

        -- Step 1: Insert into Users (manual User_Id)
        INSERT INTO Users (Users_Id, u_user_name, u_password)
        VALUES (@User_Id, @UserName, @Password);

        -- Step 2: Insert into Instructor (use the same User_Id)
        INSERT INTO Instructor (INS_Id, First_Name, Last_Name, Email, Phone, Users_Id)
        VALUES (@INS_Id, @First_Name, @Last_Name, @Email, @Phone, @User_Id);

        COMMIT TRANSACTION;
        PRINT 'Instructor and User added successfully.';
    END TRY

    BEGIN CATCH
        ROLLBACK TRANSACTION;
        PRINT 'An error occurred: ' + ERROR_MESSAGE();
    END CATCH
END;




-------------------excute-----------------
EXEC sp_AddInstructor
    @User_Id = 2001,               
    @INS_Id = 101,
    @First_Name = 'Ali',
    @Last_Name = 'Hassan',
    @Email = 'ali.hassan@example.com',
    @Phone = '0101112233',
    @UserName = 'ali_h',
    @Password = 'StrongPass123';





---------------------------------------------------------------------------------------------222222

go
CREATE OR ALTER PROCEDURE sp_UpdateInstructor
    @INS_Id INT,
    @First_Name NVARCHAR(50),
    @Last_Name NVARCHAR(50),
    @Email NVARCHAR(100),
    @Phone VARCHAR(11),
    @User_Id INT
AS
BEGIN
    BEGIN TRY
        -- Step 1: Check if instructor exists
        IF dbo.fn_CheckInstructorExists(@INS_Id) = 0
        BEGIN
            PRINT 'Instructor does not exist. Update not performed.';
            RETURN;
        END

        -- Step 2: Perform update
        UPDATE Instructor
        SET First_Name = @First_Name,
            Last_Name = @Last_Name,
            Email = @Email,
            Phone = @Phone,
            Users_Id = @User_Id
        WHERE INS_Id = @INS_Id;

        PRINT 'Instructor updated successfully.';
    END TRY

    BEGIN CATCH
        PRINT 'An error occurred: ' + ERROR_MESSAGE();
    END CATCH
END;

-----------------excute------------------
EXEC sp_UpdateInstructor 
    @INS_Id = 101,
    @First_Name = 'Ahmed',
    @Last_Name = 'Hassan',
    @Email = 'ahmed.hassan@example.com',
    @Phone = '01012345678',
    @User_Id = 14;



-------------------------------------------------------------------------3333333
go
CREATE OR ALTER PROCEDURE sp_CalculateFinalResult
    @Student_Id INT
AS
BEGIN
    BEGIN TRY
        DECLARE @FinalResult INT;

        -- Check if student exists
        IF NOT EXISTS (SELECT 1 FROM Student WHERE Student_Id = @Student_Id)
        BEGIN
            PRINT 'Student does not exist.';
            RETURN;
        END

        -- Calculate total grade (final result)
        SELECT @FinalResult = SUM(st_Mark)
        FROM Student_Answer
        WHERE Student_Id = @Student_Id;

        -- If no grades found, set result to 0
        IF @FinalResult IS NULL
            SET @FinalResult = 0;

        PRINT 'Final result calculated successfully.';
        
        -- Return result
        SELECT S.Student_Id, 
               S.First_Name, 
               S.Last_Name, 
               @FinalResult AS FinalResult
        FROM Student S
        WHERE S.Student_Id = @Student_Id;
    END TRY

    BEGIN CATCH
        PRINT 'An error occurred: ' + ERROR_MESSAGE();
    END CATCH
END;

------------------excute-------------------
EXEC sp_CalculateFinalResult @Student_Id = 1;

------------------------------------------------------------------44444
go
CREATE OR ALTER PROCEDURE sp_AssignExamToStudents
    @Exam_Id   INT,
    @Student1  INT,
    @Student2  INT,
    @Student3  INT
AS
BEGIN
    BEGIN TRY
        -- Insert Student1
        INSERT INTO Exam_Student (Student_Id, Exam_Id)
        VALUES (@Student1, @Exam_Id);

        -- Insert Student2
        INSERT INTO Exam_Student (Student_Id, Exam_Id)
        VALUES (@Student2, @Exam_Id);

        -- Insert Student3
        INSERT INTO Exam_Student (Student_Id, Exam_Id)
        VALUES (@Student3, @Exam_Id);

        PRINT ' Exam assigned to the 3 students successfully.';

        -- Show the 3 students
        SELECT S.Student_Id, S.First_Name, S.Last_Name
        FROM Student S
        WHERE S.Student_Id IN (@Student1, @Student2, @Student3);
    END TRY
    BEGIN CATCH
        PRINT 'Error: ' + ERROR_MESSAGE();
    END CATCH
END;
GO
--------excute------------
EXEC sp_AssignExamToStudents @Exam_Id = 2, @Student1 = 1, @Student2 = 2, @Student3 = 3;



-----------------------------------------------------------------------------------------------333333Aya

go

CREATE OR ALTER PROCEDURE SP_Get_Exam_Question_Random
    @Exam_Id INT,        -- Exam ID
    @NumQuestions INT    -- Number of random questions
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @CurrentTotal INT;
    DECLARE @Course_Id INT;
    DECLARE @INS_Id INT;

    -- Get Course_Id and INS_Id from Exam table
    SELECT 
        @Course_Id = Course_Id,
        @INS_Id = INS_Id
    FROM Exam
    WHERE Exam_Id = @Exam_Id;

    -- Safety check: if exam not found
    IF @Course_Id IS NULL OR @INS_Id IS NULL
    BEGIN
        RAISERROR('Invalid Exam_Id. Exam not found.', 16, 1);
        RETURN;
    END

    -- Get current total degree of exam questions
    SELECT @CurrentTotal = ISNULL(SUM(quest_degree), 0)
    FROM Exam_Question
    WHERE Exam_Id = @Exam_Id;

    ;WITH RandomQuestions AS (
        SELECT TOP (@NumQuestions)
               q.Question_Id,
               q.Q_Type,
               CASE 
                   WHEN q.Q_Type = 'MCQ'   THEN 2
                   WHEN q.Q_Type = 'True/False' THEN 2
                   WHEN q.Q_Type = 'Text'  THEN 5
               END AS quest_degree
        FROM Question q
        WHERE q.Course_Id = @Course_Id
          AND NOT EXISTS (
              SELECT 1 
              FROM Exam_Question eq 
              WHERE eq.Exam_Id = @Exam_Id 
                AND eq.Question_Id = q.Question_Id
          )  
        ORDER BY NEWID()
    )
    INSERT INTO Exam_Question (Exam_Id, Question_Id, quest_degree)
    SELECT @Exam_Id, Question_Id, quest_degree
    FROM RandomQuestions rq
    CROSS APPLY (
        SELECT SUM(quest_degree) AS TotalNewDegree
        FROM RandomQuestions
    ) t
    WHERE (@CurrentTotal + t.TotalNewDegree) <= 100;
END

go 
-----------------excute-----------------------
SP_Get_Exam_Question_Random  @Exam_Id = 2 ,@NumQuestions = 3

select * from Exam_Question


--------------------------------------------------------------------------------------------------2222
go
CREATE OR ALTER PROCEDURE SP_Record_Student_Answer
    @Exam_Id INT,
    @Student_Id INT,
    @Question_Id INT,
    @st_Answer NVARCHAR(500),
    @Submit BIT = 0  
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @StartTime TIME, @EndTime TIME, @Today DATE, @Now DATETIME, @QType NVARCHAR(50);

    -- Get exam info
    SELECT 
        @StartTime = StartTime, 
        @EndTime = EndTime,
        @Today = E_date
    FROM Exam
    WHERE Exam_Id = @Exam_Id;

    SET @Now = GETDATE();

    -- Get Question Type
    SELECT @QType = Q_Type 
    FROM Question
    WHERE Question_Id = @Question_Id;

    --------------------------------------------------------
    --  Validate Answer depending on Question Type
    --------------------------------------------------------
    IF @QType = 'MCQ'
    BEGIN
        IF NOT EXISTS (
            SELECT 1 FROM MCQ
            WHERE Question_Id = @Question_Id
              AND @st_Answer IN (Choice1, Choice2, Choice3, Choice4)
        )
        BEGIN
            RAISERROR('Invalid choice. Answer must match one of the defined MCQ choices.',16,1);
            RETURN;
        END
    END
    ELSE IF @QType = 'TrueFalse'
    BEGIN
        IF @st_Answer NOT IN ('True','False')
        BEGIN
            RAISERROR('Invalid choice. Answer must be either True or False.',16,1);
            RETURN;
        END
    END

    --------------------------------------------------------
    -- Save Answer if time still valid
    --------------------------------------------------------
    IF (
        (@Submit = 0 AND CAST(@Now AS DATE) = @Today AND CAST(@Now AS TIME) BETWEEN @StartTime AND @EndTime)
    )
    BEGIN
        ;WITH Upsert AS (
            SELECT *
            FROM Student_Answer sa
            WHERE sa.Exam_Id = @Exam_Id 
              AND sa.Student_Id = @Student_Id 
              AND sa.Question_Id = @Question_Id
        )
        -- If answer exists ? update it
        UPDATE Upsert
        SET st_Answer = @st_Answer
        WHERE EXISTS (SELECT 1 FROM Upsert);

        -- If not exists ? insert new
        IF NOT EXISTS (
            SELECT 1 FROM Student_Answer 
            WHERE Exam_Id = @Exam_Id AND Student_Id = @Student_Id AND Question_Id = @Question_Id
        )
        BEGIN
            INSERT INTO Student_Answer (ans_id, Student_Id, Exam_Id, Question_Id, st_Answer, st_Mark)
            VALUES (
                (SELECT ISNULL(MAX(ans_id),0)+1 FROM Student_Answer), 
                @Student_Id, 
                @Exam_Id, 
                @Question_Id, 
                @st_Answer,
                NULL -- mark will be graded later
            );
        END
    END
    ELSE
    BEGIN
        RAISERROR('Time is over, cannot update answer.', 16, 1);
    END
END

go 
-----------------excute--------------
EXEC SP_Record_Student_Answer
    @Exam_Id = 2,
    @Student_Id = 3,
    @Question_Id = 11,
    @st_Answer ='Swift',
    @Submit = 0;


	select * from Exam_Question
---------------------------------------------------------------------------------------
go
CREATE OR ALTER PROCEDURE SP_Grade_Exam_Auto
    @Exam_Id INT
AS
BEGIN
   --------------------------------------------------------------------
    -- 1) mark  MCQ quetion
    --------------------------------------------------------------------
    UPDATE sa
    SET sa.st_Mark = 
        CASE 
            WHEN sa.st_Answer = mc.Correct_Answer 
            THEN eq.quest_degree
            ELSE 0
        END
    FROM Student_Answer sa
    INNER JOIN Exam_Question eq 
        ON sa.Exam_Id = eq.Exam_Id AND sa.Question_Id = eq.Question_Id
    INNER JOIN Question q 
        ON sa.Question_Id = q.Question_Id
    INNER JOIN MCQ mc 
        ON q.Question_Id = mc.Question_Id
    WHERE sa.Exam_Id = @Exam_Id
      AND q.Q_Type = 'MCQ';

    --------------------------------------------------------------------
    -- 2) mark  True/Fals quetion
    --------------------------------------------------------------------
    UPDATE sa
    SET sa.st_Mark = 
        CASE 
            WHEN sa.st_Answer = tf.Correct_Answer 
            THEN eq.quest_degree
            ELSE 0
        END
    FROM Student_Answer sa
    INNER JOIN Exam_Question eq 
        ON sa.Exam_Id = eq.Exam_Id AND sa.Question_Id = eq.Question_Id
    INNER JOIN Question q 
        ON sa.Question_Id = q.Question_Id
    INNER JOIN Q_T_F tf 
        ON q.Question_Id = tf.Question_Id
    WHERE sa.Exam_Id = @Exam_Id
      AND q.Q_Type = 'Q_T_F';
END

-----------------excute-------------------
exec SP_Grade_Exam_Auto @Exam_Id= 1





