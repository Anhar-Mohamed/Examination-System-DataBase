---------------------------------------------------Ahmed

create or alter procedure addbranch
    @brach_id nvarchar(5),
    @B_Name nvarchar(50),
    @TManager_id int
as
begin
    declare @brach_id_int int

    -- 1st -- try to convert branch id
    set @brach_id_int = try_convert(int, @brach_id)

    if @brach_id_int is null
    begin
        print 'error: invalid branch id (must be integer)'
        return
    end

    -- 2nd -- check for empty name
    if @B_Name is null or ltrim(rtrim(@B_Name)) = ''
    begin
        print 'error: branch name cannot be empty'
        return;
    end

    -- 3rd -- check if branch already exists
    if exists (select 1 from Branch where Branch_Id = @brach_id_int)
    begin
        print 'error: branch id already exists'
        return;
    end

    -- 4th -- check if branch name already used
    if exists (select 1 from Branch where B_Name = @B_Name)
    begin
        print 'error: branch name already exists'
        return
    end

    -- 5th -- check if training manager exists
    if not exists (select 1 from Training_manager where TManager_Id = @TManager_id)
    begin
        print 'error: training manager does not exist'
        return
    end

    -- 6th -- check if training manager is already assigned to another branch
    if exists (select 1 from Branch where TManager_Id = @TManager_id)
    begin
        print 'error: this training manager is already assigned to another branch'
        return
    end

    -- 7th -- insert new branch
    insert into Branch (Branch_Id, B_Name, TManager_Id)
    values (@brach_id_int, @B_Name, @TManager_id)

    print 'branch added successfully'
end

-----------excute----------------------------

exec addbranch @brach_id = 4, @B_Name = 'Mansoura Branch' , @TManager_id = 4

select * from Branch
----------------------------------------------------------------------------

create or alter procedure addtrack
    @Track_id nvarchar(5),
    @T_Name nvarchar(100),
    @Dept_id int
as
begin
    declare @Track_id_int int;

    -- 1st -- try to convert track id
    set @Track_id_int = try_convert(int, @Track_id)

    if @Track_id_int is null
    begin
        print 'error: invalid track id (must be integer)'
        return
    end

    -- 2nd -- check for empty name
    if @T_Name is null or ltrim(rtrim(@T_Name)) = ''
    begin
        print 'error: track name cannot be empty'
        return
    end

    -- 3rd -- check if track already exists
    if exists (select 1 from Track where Track_Id = @Track_id_int)
    begin
        print 'error: track id already exists'
        return
    end

    -- 4th -- check if track name already exists
    if exists (select 1 from Track where T_Name = @T_Name)
    begin
        print 'error: track name already exists'
        return
    end

    -- 5th -- check if department exists
    if not exists (select 1 from Department where Dept_Id = @Dept_id)
    begin
        print 'error: department does not exist'
        return
    end

    -- 6th -- insert new track
    insert into Track (Track_Id, T_Name, Dept_Id)
    values (@Track_id_int, @T_Name, @Dept_id)

    print 'track added successfully'
end

------excute-----------------
exec addtrack @track_id = 5 , @t_name = 'AI' , @dept_id = 2

select * from Track

----------------------------------------------------------------------------------

create or alter procedure addintake
    @Intake_no nvarchar(5),
    @I_Year int,
    @startdate date,
    @enddate date
as
begin
    declare @Intake_no_int int

    -- 1st -- try to convert intake number
    set @Intake_no_int = try_convert(int, @Intake_no)

    if @Intake_no_int is null
    begin
        print 'error: invalid intake number (must be integer)'
        return
    end

    -- 2nd -- check if intake already exists
    if exists (select 1 from Intake where Intake_NO = @Intake_no_int)
    begin
        print 'error: intake number already exists'
        return
    end

    -- 3rd -- validate year
    if @I_Year not in (year(getdate()), year(getdate()) + 1)
    begin
        print 'error: invalid year value (must be current year or next year)'
        return
    end

    -- 4th -- validate dates
    if @startdate >= @enddate
    begin
        print 'error: start date must be before end date'
        return
    end

    -- 5th -- insert new intake
    insert into Intake (Intake_NO, I_Year, startdate, enddate)
    values (@Intake_no_int, @I_Year, @startdate, @enddate)

    print 'intake added successfully'
end

--------------excute------------------

exec addintake 
    @intake_no = '46',
    @I_year = 2025,
    @startdate = '2025-09-01',
    @enddate   = '2026-06-30'

select * from Intake



---------------------------------------------------Anhar
GO

/*
Stored procedure Add a new student with personal data, intake, branch, and track.
*/

CREATE or ALTER PROCEDURE proc_add_student
 @St_Id int,
 @St_Fname char(50),
 @St_Lname char(50),
 @St_Email nvarchar(100),
 @In_No int,
 @Br_Id int,
 @Tr_Id int, 
 @User_Id int ,
 @User_Role nvarchar(100)

AS
 BEGIN
    
    IF NOT EXISTS (SELECT 1 FROM Branch WHERE branch_id = @Br_Id)   --Validate Branch
	
      THROW 50001 , 'This branch ID not exist' , 1

    IF NOT EXISTS (SELECT 1 FROM Track WHERE Track_Id = @Tr_Id)     --Validate Track

      THROW 50001 , 'This track ID not exist' , 1

    IF NOT EXISTS (SELECT 1 FROM Intake WHERE Intake_NO = @In_No)   --Validate Intake

      THROW 50001 , 'This intake ID not exist' , 1


    IF EXISTS (SELECT 1 FROM Student WHERE Student_Id = @St_Id)     --Validate Student

      THROW 50001 , 'This student ID is already exists' , 1

    BEGIN TRAN T1
	 BEGIN TRY
	  
	  IF EXISTS (SELECT 1 FROM users WHERE Users_Id = @User_Id)   --Validate User IF Not Exists 
	     
		 PRINT('This User is already Exist So Can not add a student is already exists as an user')
      ELSE 
	     BEGIN

	      INSERT INTO users (Users_Id , u_role)
	      VALUES (@User_Id , @User_Role)


          INSERT INTO Student(Student_Id , First_Name , Last_Name , Email , Intake_NO , branch_id , Track_Id , Users_Id)
          VALUES (@St_Id , @St_Fname , @St_Lname , @St_Email , @In_No , @Br_Id , @Tr_Id , @User_Id)

         END
      COMMIT
     END TRY
   BEGIN CATCH
    
	ROLLBACK

   END CATCH

 END

GO

------------excute------------

EXECUTE proc_add_student 28,'Ali','Ahmed', 'aliahmed222@gmail.com' , 45,1,1 , 100 , 'student'

EXECUTE proc_add_student 32,'Nora','Samy', 'norasamy567@gmail.com' , 45,100,1 , 101 , 'student'

EXECUTE proc_add_student 32,'Nora','Samy', 'norasamy567@gmail.com' , 45,1,1 , 40 , 'student'

EXECUTE proc_add_student 29,'Mona','Osama', 'monaosama252@gmail.com' , 45,2,3 , 101 , 'student'




---------------------------------------------------------------------
/*
Stored procedure Update student edit student details.
*/

CREATE or ALTER PROCEDURE proc_update_student
 @St_Id int,
 @St_Fname char(50),
 @St_Lname char(50),
 @St_Email nvarchar(100),
 @St_Phone varchar(11),
 @In_No int,
 @Br_Id int,
 @Tr_Id int

AS
 BEGIN

   IF NOT EXISTS (SELECT 1 FROM Intake WHERE Intake_NO = @In_No)  --Validate parent table
    
	THROW 50001 , 'Error: Intake ID is not exists in parent table (Intake) table' , 1

   IF NOT EXISTS (SELECT 1 FROM Branch WHERE branch_id = @Br_Id)  --Validate parent table
    
	THROW 50001 , 'Error: Branch ID is not exists in parent table (Branch) table' , 1

   IF NOT EXISTS (SELECT 1 FROM Track WHERE Track_Id = @Tr_Id)     --Validate parent table
    
	THROW 50001 , 'Error: Track ID is not exists in parent table (Track) table' , 1

   BEGIN TRAN T  
    BEGIN TRY

     UPDATE Student
	 SET First_Name = @St_Fname ,
	     Last_Name  = @St_Lname ,
		 Email = @St_Email ,
		 Phone = @St_Phone , 
		 Intake_NO = @In_No ,
		 branch_id = @Br_Id , 
		 Track_Id = @Tr_Id
	 WHERE Student_Id = @St_Id

	 IF @@ROWCOUNT = 0
	   PRINT('No updated happened as the student not found!')

	 ELSE
	   PRINT ('Update done successfully in student table!')

	 COMMIT

    END TRY

    BEGIN CATCH

     ROLLBACK
            
    END CATCH

 END

GO

------excute-----------------

EXECUTE proc_update_student 100,'Ali','Ahmed', 'aliahmed222@gmail.com' , 01129210122 , 45,1,1

EXECUTE proc_update_student 28,'Nora','Samy', 'norasamy567@gmail.com' , 01129210122 , 45,200,1

EXECUTE proc_update_student 32,'Nora','Samy', 'norasamy567@gmail.com' , 01129210122 , 55,2,1

GO


----------------------------------------------------------

CREATE OR ALTER PROCEDURE proc_delete_student_record
 @St_Id int

 AS
 BEGIN

  IF NOT EXISTS (SELECT 1 FROM Student WHERE Student_Id = @St_Id)
     THROW 50001 , 'Can not delete as student ID is not exists!' , 1

  BEGIN TRAN T
   BEGIN TRY

    DELETE FROM Student
    WHERE Student_Id = @St_Id

    COMMIT

	PRINT ('Deleted done successfully!')

  END TRY

  BEGIN CATCH

    ROLLBACK

  END CATCH

 END 

GO 
--------ecute------------------
EXECUTE proc_delete_student_record 100

EXECUTE proc_delete_student_record 28

GO


-------------------------------------------------------------------



CREATE OR ALTER PROCEDURE proc_search_student
 @St_Fname char(50) = NULL ,
 @St_Lname char(50) = NULL ,
 @Intake_No int = NULL ,
 @Branch_Id int = NULL ,
 @Track_Id int = NULL

AS
 BEGIN

   SELECT S.Student_Id AS St_ID , 
          S.First_Name AS First_Name , 
		  S.Last_Name AS Last_Name , 
		  S.Email AS St_Email ,
		  S.Phone AS St_Phone ,
		  I.Intake_NO AS Intake_No ,
		  B.B_Name AS Branch_Name ,
		  T.T_Name AS Track_Name

   FROM Student AS S
   LEFT JOIN Intake AS I
   ON S.Intake_NO = I.Intake_NO
   LEFT JOIN Branch AS B
   ON S.branch_id = B.branch_id
   LEFT JOIN Track AS T
   ON S.Track_Id = T.Track_Id

   WHERE (@St_Fname IS NULL OR  S.First_Name = @St_Fname )
     AND (@St_Lname IS NULL OR S.Last_Name = @St_Lname )
     AND (@Intake_No IS NULL OR I.Intake_NO = @Intake_No)
	 AND (@Branch_Id IS NULL OR B.branch_id = @Branch_Id)
	 AND (@Track_Id IS NULL OR T.Track_Id = @Track_Id)

 END

GO

-------------excute--------------------

EXECUTE proc_search_student NULL , NULL , NULL , NULL , NULL                                                                                      


EXECUTE proc_search_student 



EXECUTE proc_search_student NULL ,NULL , 45 , 3 , NULL

EXECUTE proc_search_student  'Ahmed' ,NULL , 45 , 3 

EXECUTE proc_search_student @St_Fname = 'Alice' , @Intake_No = 45 


------------------------------------------------------------------------------------------Mohammed
go

Create or alter PROC AssignInstructorToCourse
    @C_ID NVARCHAR(20),
    @INS_ID NVARCHAR(20),
    @INT_Id NVARCHAR(20)
AS
Begin
  
    Begin Try
        SET NOCOUNT ON

        -- Check Course ID cannot be empty and positvie number.
        DECLARE @Course_ID INT = dbo.fnValidatePositiveInt(@C_ID)
        If @Course_ID IS NULL 
        Begin
            Print 'Error: Course ID Must be Positve Int.'
            Return
        End

        -- Check Instructor ID cannot be empty and positvie number.
        DECLARE @IN_ID INT = dbo.fnValidatePositiveInt(@INS_ID)
        If @IN_ID IS NULL 
        Begin
            Print 'Error: Instructor ID Must be Positve Int.'
            Return
        End

        -- Check Intake ID cannot be empty and positvie number.
        DECLARE @Intake_Id INT = dbo.fnValidatePositiveInt(@INT_Id)
        If @Intake_Id IS NULL 
        Begin
            Print 'Error: Intake ID Must be Positve Int.'
            Return
        End


        -- Chech Intake is found
        IF dbo.fnIntakeExists (@Intake_Id)=0
        BEGIN
            PRINT 'Error: Intake does not exist.'
            RETURN;
        END

        -- Chech Instructor is found
        If dbo.fnInstructorExists (@IN_ID) = 0
        Begin
            Print 'Error: Instructor not found.'
           
            Return;
        End

        -- Chech Course is found

        IF dbo.fnCourseExists(@Course_ID) = 0
        Begin
            Print 'Error: Course not found.'
            Return
        End
  

        -- Check instructor is not assigned to this course
        IF EXISTS 
            (
              Select 1 From [dbo].[instructor_course] 
              Where INS_ID = @IN_ID 
                And Course_ID = @Course_ID 
                And Intake_NO = @Intake_Id
            )
        Begin
            Print 'Error: This instructor is already assigned to this course.'
            Return
        End
        -- Insert Course to Ins
        Begin Transaction
        Insert into dbo.Instructor_Course (Course_Id, INS_Id, Intake_NO)
                                   VALUES (@Course_ID, @IN_ID, @Intake_Id)
        COMMIT Transaction
        Print Concat('Instructor No: (',@IN_ID,') assigned to Course No: (',@Course_ID,') in Intake No: (',@Intake_Id,') Successfully.')

    End try
    Begin Catch
        ROLLBACK Transaction
        Print 'Error: ' + ERROR_MESSAGE()
    End Catch
End
-------------excute--------------
EXEC dbo.AssignInstructorToCourse
    @C_ID = '3',
    @INS_ID = '5',
    @INT_Id = '45'

	-------------------------------------------------------------
	Create or alter Procedure dbo.AddCourse
    @C_Name CHAR(50),
    @C_Description NVARCHAR(MAX),
    @Max_Deg INT,
    @Min_Deg INT
AS
Begin
    Begin Try
        SET NOCOUNT ON
        DECLARE @NextId INT
        SELECT @NextId = ISNULL(MAX(Course_Id), 0) + 1
        FROM dbo.Course with (tablockx) 


     -- Check Course name cannot be empty.
       If dbo.fnStringIsValid(@C_Name) = 0 
        Begin
            Print 'Error: Course name cannot be empty.';
            Return
        End
        If EXISTS (SELECT 1 FROM dbo.Course WHERE LTRIM(RTRIM(C_Name)) = LTRIM(RTRIM(@C_Name))) 
        Begin
            Print 'Error: Course name already exists.';
            Return
        End
     
        -- Check Degree is valid.
        If dbo.fnIsDegreeValid(@Max_Deg, @Min_Deg) = 0
        Begin
            Print 'Error: Degree values are invalid. Max must be > 0, Min >= 0, and Max >= Min.';
            Return
        End
        Insert into dbo.Course (Course_Id,C_Name, C_Description, Max_Deg, Min_Deg)
        Values (@NextId, @C_Name, @C_Description, @Max_Deg, @Min_Deg)

        print 'Course added successfully.'
        print concat('The New Course ID is ',@NextId)
        
    End Try

    Begin Catch
        Print 'Error: ' + ERROR_MESSAGE()
    End Catch
End

--------------excute---------
EXEC dbo.AddCourse  
    @C_Name = 'SQL Basics',  
    @C_Description = 'Introduction to SQL fundamentals',  
    @Max_Deg = 100,  
    @Min_Deg = 50
-------------------------------------------------------------
Create or alter Procedure dbo.UpdateCourse
    @C_ID NVARCHAR(20),
    @C_Name CHAR(50),
    @C_Description NVARCHAR(MAX),
    @Max_Deg INT,
    @Min_Deg INT
AS
Begin
    Begin Try
        SET NOCOUNT ON

        -- Check Course ID cannot be empty and positvie number.
        DECLARE @Course_ID INT = dbo.fnValidatePositiveInt(@C_ID)
        If @Course_ID IS NULL
        Begin
            Print 'Error: Course ID cannot be empty or negative.';
            Return
        End

        -- Check Course ID not exists
        IF dbo.fnCourseExists(@Course_ID) = 0
        Begin
            Print 'Error: Course ID not exists.'
            Return
        End

       -- Check Course name cannot be empty.
       If dbo.fnStringIsValid(@C_Name) = 0
        Begin
            Print 'Error: Course name cannot be empty.';
            Return
        End

        -- Check Degree is valid.
        If dbo.fnIsDegreeValid(@Max_Deg, @Min_Deg) = 0
        Begin
            Print 'Error: Degree values are invalid. Max must be > 0, Min >= 0, and Max >= Min.';
            Return
        End

        Begin Transaction
        Update Course
        SET 
            C_Name = @C_Name,
            C_Description = @C_Description,
            Max_Deg = @Max_Deg,
            Min_Deg = @Min_Deg
        Where Course_ID = @Course_ID
        Commit Transaction
        print concat('Course No: (',@Course_ID, ') is updated successfully.')
    End Try

    Begin Catch
        ROLLBACK Transaction
        Print 'Error: ' + ERROR_MESSAGE()
    End Catch
End


-----------------excute------------

EXEC dbo.UpdateCourse
    @C_ID = '1',  
    @C_Name = 'Advanced SQL',  
    @C_Description = 'Covers advanced SQL queries and optimization techniques',  
    @Max_Deg = 100,  
    @Min_Deg = 40

	----------------------------------------------------
	CREATE OR ALTER PROCEDURE SearchExams
    @Exam_Id int =null,
    @E_Type CHAR(30) = NULL,
    @Course_ID int = NULL,
    @Ins_ID int = NULL,
    @Intake_ID int = NULL,
    @E_Date NVARCHAR(20) = NULL,
    @E_AllowedOption BIT = NULL
AS
BEGIN
    BEGIN TRY
        -- Check Exam ID positvie number.
        If @Exam_ID <=0
        Begin
            Print 'Error: Exam ID Must be Positive.';
            Return
        End
        -- Check Intake ID positvie number 
        If @Intake_ID <=0
        Begin
            Print 'Error: Intake ID Must be Positive.';
            Return
        End
        -- Check Course ID positvie number
        If @Course_ID <=0
        Begin
            Print 'Error: Course ID Must be Positive.';
            Return
        End
        -- Check Instructor ID positvie number .
        If @Ins_ID <=0
        Begin
            Print 'Error: Instructor ID Must be Positive.';
            Return
        End

        -- Validate Exam Date 
        IF @E_Date IS NOT NULL AND LTRIM(RTRIM(@E_Date)) <> ''
        BEGIN
            SET @E_Date = dbo.fnValidateDateFormat(@E_Date);
            IF @E_Date IS NULL
            BEGIN
                PRINT 'Error: Date must be in format YYYY-MM-DD, YYYY/MM/DD, or YYYY\MM\DD and valid.';
                RETURN;
            END
        END

        -- Main Query to search
 
        SELECT *
        FROM [dbo].[Exam]
        WHERE (@Exam_Id IS NULL OR Exam_Id = @Exam_Id)
            And (@Course_ID IS NULL OR Course_ID = @Course_ID)
            AND (@Ins_ID IS NULL OR INS_ID = @Ins_ID)
            AND (@Intake_ID IS NULL OR Intake_No = @Intake_ID)
            AND (@E_Date IS NULL OR E_Date = @E_Date)
            AND (@E_AllowedOption IS NULL OR E_AllowedOption = @E_AllowedOption)
            And (@E_Type IS NULL OR E_Type = @E_Type) 
    END TRY

    BEGIN CATCH
        
        PRINT 'Error: ' + ERROR_MESSAGE()
    END CATCH
END



----------------excute------------

EXEC SearchExams @Course_ID = 1, @INS_ID = 1, @Intake_ID = 45, @E_type='exam'

EXEC SearchExams @Course_ID = '1', @INS_ID = '2', @Intake_ID = '-1';

EXEC SearchExams @Course_ID = '5', @INS_ID = '-5';

EXEC SearchExams @Course_ID = '-1';

EXEC SearchExams @INS_ID = '1'

EXEC SearchExams 


EXEC SearchExams @C_ID =1,@INS_ID = 1






   

    