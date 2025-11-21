CREATE LOGIN StudentUser WITH PASSWORD = 'StrongPass123';
CREATE LOGIN InstructorUser WITH PASSWORD = 'StrongPass123';
CREATE LOGIN TrainingManager WITH PASSWORD = 'StrongPass123';
CREATE LOGIN AdminUser WITH PASSWORD = 'StrongPass123';



USE ITI_Local_Project;
CREATE USER StudentUser FOR LOGIN StudentUser;
CREATE USER InstructorUser FOR LOGIN InstructorUser;
CREATE USER TrainingManager FOR LOGIN TrainingManager;
CREATE USER AdminUser FOR LOGIN AdminUser;




CREATE ROLE role_student;
CREATE ROLE role_instructor;
CREATE ROLE role_trainingmanager;


-- Admin
EXEC sp_addrolemember 'db_owner', 'AdminUser';



-- Student
GRANT SELECT, INSERT ON Student_Answer TO role_student;


-- Allow students to insert answers
GRANT INSERT ON dbo.Student_Answer TO role_student;


-- Instructor
GRANT SELECT, INSERT, UPDATE ON Exam TO role_instructor;
GRANT SELECT, UPDATE ON Student_Answer TO role_instructor;


-- Allow instructors to insert/update exams and questions
GRANT INSERT, UPDATE, DELETE ON dbo.Exam TO role_instructor;
GRANT INSERT, UPDATE, DELETE ON dbo.Question TO role_instructor;

-- Allow instructors to update student answers (grading text answers)
GRANT UPDATE ON dbo.Student_Answer TO role_instructor;

-- Training Manager
GRANT SELECT, UPDATE, INSERT ON Course TO role_trainingmanager;


-- Full access to courses
GRANT SELECT, INSERT, UPDATE, DELETE ON dbo.Course TO role_trainingmanager;



-- Allow viewing students and instructors for management
GRANT SELECT ON dbo.Student TO role_trainingmanager;
GRANT SELECT ON dbo.Instructor TO role_trainingmanager;



EXEC sp_addrolemember 'role_student', 'StudentUser';
EXEC sp_addrolemember 'role_instructor', 'InstructorUser';
EXEC sp_addrolemember 'role_trainingmanager', 'TrainingManager';



