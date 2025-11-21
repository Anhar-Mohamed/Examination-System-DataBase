USE ITI_Project_Local;
GO

----------------------------------------------------
-- 1. Create Filegroups
----------------------------------------------------
ALTER DATABASE ITI_Project_Local ADD FILEGROUP FG_Metadata;
ALTER DATABASE ITI_Project_Local ADD FILEGROUP FG_Transactional;  
ALTER DATABASE ITI_Project_Local ADD FILEGROUP FG_History;


USE ITI_Project_Local;
GO

----------------------------------------------------
-- 3. Rebuild Clustered Indexes (to move tables)
----------------------------------------------------
-- FG_Metadata (reference tables)


CREATE nonCLUSTERED INDEX IX_Users_Name ON users(u_user_name)
 ON FG_Metadata;

 CREATE nonCLUSTERED INDEX IX_traning_manager ON Training_manager(Users_Id)
 ON FG_Metadata;

  CREATE nonCLUSTERED INDEX IX_Instructor ON Instructor(Users_Id)
 ON FG_Metadata;

  CREATE nonCLUSTERED INDEX IX_question ON Question(Course_Id)
 ON FG_Metadata;

   CREATE nonCLUSTERED INDEX IX_course ON Course(C_name)
 ON FG_Metadata;

    CREATE nonCLUSTERED INDEX IX_Exam_Question ON Exam_Question(Question_Id)
 ON FG_Metadata;




----------------------------------------------------
-- FG_Transactional (big, frequently queried tables)
----------------------------------------------------

CREATE nonCLUSTERED INDEX IX_Track_Branch_Intake ON Track_branch_intake(Intake_NO)
 ON FG_Transactional;

 CREATE nonCLUSTERED INDEX IX_Student ON Student(Users_Id)
 ON FG_Transactional;

  CREATE nonCLUSTERED INDEX IX_Instructor_Course ON instructor_course(Intake_NO)
 ON FG_Transactional;

   CREATE nonCLUSTERED INDEX IX_mcq ON MCQ(Question_Id)
 ON FG_Transactional;

    CREATE nonCLUSTERED INDEX IX_qtf ON Q_T_F(Question_Id)
 ON FG_Transactional;

    CREATE nonCLUSTERED INDEX IX_Exam_Student ON Exam_student(Exam_Id)
 ON FG_Transactional;

     CREATE nonCLUSTERED INDEX IX_textquestion ON Text_Question (Question_Id)
 ON FG_Transactional;


----------------------------------------------------
-- FG_History (relationship / history tables)
----------------------------------------------------
    create nonCLUSTERED INDEX IX_intake ON Intake (Intake_No)
 ON FG_History;


     create nonCLUSTERED INDEX IX_department ON Department (Dept_Name)
 ON FG_History;

     create nonCLUSTERED INDEX IX_track ON Track (Dept_Id)
 ON FG_History;

     create nonCLUSTERED INDEX IX_exam ON Exam (INS_Id)
 ON FG_History;


      create nonCLUSTERED INDEX IX_student_Answer ON Student_Answer (Student_Id)
 ON FG_History;







     
