create database ITI_Project_Local
use ITI_Project_Local

create table Intake 
(
Intake_NO int ,
I_Year int ,
startdate date ,
enddate date ,

constraint pk_intake_id  primary key (Intake_NO) 

)
---------------------------------------------------------
create table Department
(

Dept_Id int  ,
Dept_Name nvarchar (100) ,

constraint pk_dept_id  primary key (Dept_Id) 

) 
-------------------------------------------------------
create table users
(
Users_Id int  ,
u_user_name nvarchar (50) ,
u_password nvarchar(50),
u_role nvarchar(100),
constraint pk_users_id  primary key (Users_Id) 
) 
---------------------------------------------------------
create table Training_manager
(

TManager_Id int  ,
First_Name varchar(50) ,
Last_Name varchar(50) ,
Email nvarchar(100),
Phone varchar(11),
Users_Id int ,
constraint pk_tm_tmid  primary key (TManager_Id),
constraint fk_tm_user_id foreign key (Users_Id) references  users (Users_Id)

) 


create table Branch
(
branch_id int   ,
B_Name varchar (50),
TManager_Id int,
constraint pk_branch_id  primary key (branch_id) ,
constraint fk_branch_tm_id foreign key (TManager_Id) references  Training_manager (TManager_Id)

)
---------edit 

create table Track
(
Track_Id int ,
T_Name char(100),
Dept_Id int ,
constraint pk_track_id  primary key (Track_Id) ,
constraint fk_track_dept foreign key (Dept_Id) references department (Dept_Id)

)


create table Track_branch_intake
(
Intake_NO int,
Branch_Id int ,
Track_Id int ,


constraint pk_tbi_id  primary key (Intake_NO  ,Branch_Id ,Track_Id) ,
constraint fk_tbi_t_dept foreign key (Track_Id) references Track (Track_Id),
constraint fk_tbi_b_dept foreign key (Branch_Id) references Branch (Branch_Id),
constraint fk_tbi_i_dept foreign key (Intake_NO) references Intake (Intake_NO)
)  



create table Instructor 
(
INS_Id int ,
First_Name nvarchar(50),
Last_Name nvarchar(50),
Email nvarchar(100),
Phone varchar(11),
Users_Id int ,
constraint pk_instructor_id  primary key (INS_Id) ,
constraint fk_ins_user_id foreign key (Users_Id) references  users (Users_Id)
) 


create table Course
(
Course_Id int  ,
C_Name char(50),
C_Description nvarchar(max),
Max_Deg int,
Min_Deg int ,

constraint pk_course_id  primary key (Course_Id) 
)


Create table instructor_course
(
Course_Id int, 
INS_Id int,
Intake_NO int ,

constraint pk_course_ins_id  primary key(Course_Id, INS_Id ,Intake_NO),
constraint fk_course_ins_cid foreign key (Course_Id) references Course (Course_Id),
constraint fk_course_ins_insid foreign key (INS_Id) references Instructor (INS_Id),
constraint fk_course_ins_iid foreign key (Intake_NO) references Intake (Intake_NO)

)

------------------------------------------------------------
create table Student
(
Student_Id int  ,
First_Name varchar(50),
Last_Name varchar(50),
Email nvarchar(100),
Phone varchar(11),
Intake_NO int,
branch_id int ,
Track_Id int,
Users_Id int ,
constraint pk_student_id  primary key(Student_Id),
constraint fk_st_branch_id foreign key (branch_id) references Branch (branch_id),
constraint fk_st_intake_id foreign key (Intake_NO) references Intake (Intake_NO),
constraint fk_st_track_id foreign key (Track_Id) references Track (Track_Id) ,
constraint fk_st_user_id foreign key (Users_Id) references  users (Users_Id)


) 

--------------------------------------------------------------
---------------------Inheratnce with Question

create table Question 
(
Question_Id int  ,
Q_Text NVARCHAR(500) NOT NULL,
Q_Type NVARCHAR(50) NOT NULL ,
Course_Id int,   
constraint pk_question_id  primary key(Question_Id),
constraint fk_q_course_id foreign key (Course_Id) references Course (Course_Id)
)


create table  MCQ 
(
    Question_Id INT ,
    Choice1 NVARCHAR(200) NOT NULL,
    Choice2 NVARCHAR(200) NOT NULL,
    Choice3 NVARCHAR(200) NOT NULL,
    Choice4 NVARCHAR(200) NOT NULL,
    Correct_Answer NVARCHAR(200) NOT NULL,
    
    constraint pk_mcq_id  primary key(Question_Id),
    constraint fk_qmcq_cid foreign key (Question_Id) references Question (Question_Id)
       
) 


CREATE TABLE Q_T_F (
    Question_Id INT ,
	Choice1 NVARCHAR(200) NOT NULL default 'True',
    Choice2 NVARCHAR(200) NOT NULL default 'False',
    Correct_Answer NVARCHAR(200),
    
    constraint pk_tf_id  primary key(Question_Id),
    constraint fk_qtf_cid foreign key (Question_Id) references Question (Question_Id)
        
) 

CREATE TABLE Text_Question (
    Question_Id INT,
    Correct_Answer NVARCHAR(500),
	
    constraint pk_text_id  primary key(Question_Id),
    constraint fk_qt_cid foreign key (Question_Id) references Question (Question_Id)
        
) 

----------------------------------------

create table Exam
(

Exam_Id int  ,
E_Type char(30),
StartTime time,
EndTime time,
E_date date ,

INS_Id int ,
Intake_NO int , 
Course_Id int ,
E_AllowedOption bit, -----------that mean if this exam can be taken again
constraint pk_exam_id  primary key(Exam_Id),
constraint fk_e_ins_id foreign key (INS_Id) references Instructor (INS_Id),
constraint fk_e_intake_id foreign key (Intake_NO) references Intake (Intake_NO),
constraint fk_e_course_id foreign key (Course_Id) references Course (Course_Id)


)

create table Exam_Question
(

Exam_Id int,
Question_Id int,
quest_degree int ,
constraint pk_exam_quest_id  primary key(Exam_Id , Question_Id),
constraint fk_e_exam_id foreign key (Exam_Id) references Exam (Exam_Id),
constraint fk_e_quest_id foreign key (Question_Id) references Question (Question_Id)
)


create table Exam_Student(

Exam_Id int,
Student_Id int,
constraint pk_exam_quest_stu_id  primary key(Exam_Id , Student_Id),
constraint fk_es_exam_id foreign key (Exam_Id) references Exam (Exam_Id),
constraint fk_es_stu_id foreign key (Student_Id) references Student (Student_Id)


)
-----------------------------------

create table Student_Answer
(
ans_id int  ,
Student_Id int,
Exam_Id int,
Question_Id int,
st_Answer nvarchar(500),
st_Mark int, 

constraint pk_stu_answre_id primary key(Student_Id,Question_Id,Exam_Id),
constraint pk_stu_ans_id FOREIGN KEY (Student_Id) REFERENCES Student(Student_Id),
constraint pk_exam_ans_id FOREIGN KEY (Exam_Id) REFERENCES Exam(Exam_Id),
constraint pk_exam_ques_id FOREIGN KEY (Question_Id) REFERENCES Question(Question_Id)
)

-------------------------------------------------------------------------
