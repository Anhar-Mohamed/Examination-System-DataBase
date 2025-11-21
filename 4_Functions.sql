
---------------------------------------salma
go
CREATE FUNCTION dbo.fn_CheckInstructorExists (@InstID INT)
RETURNS BIT
AS
BEGIN
    DECLARE @Exists BIT;

    IF EXISTS (SELECT 1 FROM Instructor WHERE INS_Id = @InstID)
        SET @Exists = 1;
    ELSE
        SET @Exists = 0;

    RETURN @Exists;
END;


-----------------------------------------------------------------------------------
go
CREATE OR ALTER FUNCTION fn_GetTotalGrade
(
    @Student_Id INT,
    @Exam_Id INT
)
RETURNS INT
AS
BEGIN
    DECLARE @TotalGrade INT;

    SELECT @TotalGrade = SUM(st_Mark)
    FROM Student_Answer
    WHERE Student_Id = @Student_Id
      AND Exam_Id = @Exam_Id;

    RETURN ISNULL(@TotalGrade, 0);
END;



------------------------------------------------------------Ahmed

--  1- Validate Positive Int
go
CREATE OR ALTER FUNCTION dbo.fnValidatePositiveInt
(
    @Value NVARCHAR(50)
)
RETURNS INT
AS
BEGIN
    DECLARE @Result INT;
    SET @Result = TRY_CAST(@Value AS INT);

    IF @Result IS NULL OR @Result <= 0
        RETURN NULL;

    RETURN @Result
END

go
-- 2- Course is Exists
CREATE OR ALTER FUNCTION dbo.fnCourseExists (@Course_ID INT)
RETURNS BIT
AS
BEGIN
    DECLARE @Result BIT;

    SET @Result = CASE 
                    WHEN EXISTS (SELECT 1 FROM dbo.Course WHERE Course_ID = @Course_ID) 
                    THEN 1 
                    ELSE 0 
                  END;

    RETURN @Result;
END
go