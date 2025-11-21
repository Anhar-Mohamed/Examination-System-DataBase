
use ITI_Project_Local

-- Inserting data into Intake
INSERT INTO Intake ( Intake_NO ,I_Year, startdate, enddate) 
VALUES
(45 , 2025 , '2024-10-01', '2025-07-15')

----------------------------------------------------------------
-------------------Inserting data into users
INSERT INTO users (Users_ID, U_user_name, u_password, u_role) 
VALUES 
(1,'user1', 'pass1' , 'training manager'),
(2,'user2', 'pass2','training manager'),
(3,'user3', 'pass3','training manager'),
(4,'user4', 'pass4' , 'instructor'),
(5,'user5', 'pass5', 'instructor'),
(6,'user6', 'pass6', 'instructor'),
(7,'user7', 'pass7', 'instructor'),
(8,'user8', 'pass8', 'instructor'),
(9,'user9', 'pass9', 'instructor'),
(10,'user10', 'pass10', 'instructor'),
(11,'user11', 'pass11', 'instructor'),
(12,'user12', 'pass12', 'instructor'),
(13,'user13', 'pass13', 'instructor'),
(14,'user14', 'pass14', 'student'),
(15,'user15', 'pass15', 'student'),
(16,'user16', 'pass16', 'student'),
(17,'user17', 'pass17', 'student'),
(18,'user18', 'pass18', 'student'),
(19,'user19', 'pass19', 'student'),
(20,'user20', 'pass20','student'),
(21,'user21', 'pass21','student'),
(22,'user22', 'pass22','student'),
(23,'user23', 'pass23','student'),
(24,'user24', 'pass24','student'),
(25,'user25', 'pass25','student'),
(26,'user26', 'pass26','student'),
(27,'user27', 'pass27','student'),
(28,'user28', 'pass28','student'),
(29,'user29', 'pass29','student'),
(30,'user30', 'pass30','student'),
(31,'user31', 'pass31','student'),
(32,'user32', 'pass32','student'),
(33,'user33', 'pass33','student'),
(34,'user34', 'pass34','student'),
(35,'user35', 'pass35','student'),
(36,'user36', 'pass36','student'),
(37,'user37', 'pass37','student'),
(38,'user38', 'pass38','student'),
(39,'user39', 'pass39','student'),
(40,'user40', 'pass40','student');


--------------------------------------------------------------------
-- Inserting data into Training_manager
INSERT INTO Training_manager (TManager_Id, First_Name, Last_Name, Email, Phone, Users_Id) 
VALUES
(1, 'John', 'Doe', 'john.doe@example.com', '1234567890', 1),
(2, 'Jane', 'Smith', 'jane.smith@example.com', '1234567891', 2),
(3, 'Alice', 'Johnson', 'alice.johnson@example.com', '1234567892', 3);

--------------------------------------------------------------------------------------------------------------------
-- Inserting data into Branch
INSERT INTO Branch (Branch_Id, B_Name, TManager_Id) 
VALUES
(1, 'Smart Village Branch', 1),
(2, 'Alexandria Branch', 2),
(3, 'Minia Branch', 3);
------------------------------------------------------------------------------------------------------------------------------------------------
-- Inserting data into Department
INSERT INTO Department (Dept_Id, Dept_Name) 
VALUES
(1, 'Computer Science'),
(2, 'Data Science');

--------------------------------------------------------------------------
-- Inserting data into Track
INSERT INTO Track (Track_Id, T_Name, Dept_Id) 
VALUES
(1, 'Web Development', 1),
(2, 'Mobile App Development', 1),
(3, 'Machine Learning', 2),
(4, 'Data Engineering', 2);

-----------------------------------------------------------------------------
INSERT INTO Track_branch_intake (Intake_NO ,Branch_Id ,Track_Id) 
VALUES
(45 ,1 , 1),
(45 ,1 , 2),
(45 ,1 , 3),
(45 ,2 , 1),
(45 ,2 , 2), 
(45 ,2 , 4),
(45 ,3 , 2),
(45 ,3 , 3),
(45 ,3 , 4);

--------------------------------------------------------------------
-- Inserting data into Instructor
INSERT INTO Instructor (INS_Id, First_Name, Last_Name, Email, Phone, Users_Id) 
VALUES
(1, 'Alice', 'Smith', 'alice.smith@example.com', '1234567890', 4),
(2, 'Bob', 'Johnson', 'bob.johnson@example.com', '1234567891', 5),
(3, 'Charlie', 'Williams', 'charlie.williams@example.com', '1234567892', 6),
(4, 'David', 'Jones', 'david.jones@example.com', '1234567893', 7),
(5, 'Eva', 'Brown', 'eva.brown@example.com', '1234567894', 8),
(6, 'Frank', 'Davis', 'frank.davis@example.com', '1234567895', 9),
(7, 'Grace', 'Miller', 'grace.miller@example.com', '1234567896', 10),
(8, 'Henry', 'Wilson', 'henry.wilson@example.com', '1234567897', 11),
(9, 'Isabella', 'Moore', 'isabella.moore@example.com', '1234567898', 12),
(10, 'Jack', 'Taylor', 'jack.taylor@example.com', '1234567899', 13);

update Student
set First_Name = LTRIM(RTRIM(First_Name)),
    Last_Name  = LTRIM(RTRIM(Last_Name));
---------------------------------------------------------------------------
------------------- Inserting data into Course
INSERT INTO Course (Course_Id, C_Name, C_Description, Max_Deg, Min_Deg) 
VALUES
(1, 'HTML & CSS', 'Basics of building and styling web pages.', 100, 50),
(2, 'JavaScript Fundamentals', 'Core programming concepts in JavaScript.', 100, 50),
(3, 'React Basics', 'Introduction to building dynamic web apps with React.', 100, 50),
(4, 'Android Development', 'Building mobile apps using Java/Kotlin for Android.', 100, 50),
(5, 'iOS Development', 'Developing mobile apps for iOS using Swift.', 100, 50),
(6, 'Flutter Development', 'Cross-platform mobile development using Flutter.', 100, 50),
(7, 'Python for Machine Learning', 'Using Python for ML and AI applications.', 100, 50),
(8, 'Supervised Learning', 'Introduction to supervised ML algorithms.', 100, 50),
(9, 'Neural Networks', 'Basics of deep learning and neural networks.', 100, 50),
(10, 'Database Fundamentals', 'Understanding relational and non-relational databases.', 100, 50),
(11, 'ETL Processes', 'Extract, Transform, Load workflows in data engineering.', 100, 50),
(12, 'Big Data Tools', 'Introduction to tools like Hadoop and Spark.', 100, 50);

----------------------------------------------------------------------------------------------------------------------------------------------
-- Inserting data into instructor_course
INSERT INTO instructor_course (Course_Id, INS_Id, Intake_NO) VALUES
(1, 1, 45),
(2, 2, 45),
(3, 3, 45),
(4, 4, 45),
(5, 5, 45),
(6, 6, 45),
(7, 7, 45),
(8, 8, 45),
(9, 8, 45),
(10, 9, 45),
(11, 9, 45),
(12, 10, 45);

---------------------------------------------------------------------------------------------------------------------------------------------
INSERT INTO Student (Student_Id, First_Name, Last_Name, Email, Phone, Intake_NO, branch_id, Track_Id, Users_Id) 
VALUES
(1, 'Alice','Smith','alice.smith@student.com','1234567890', 45, 1 ,1 ,14),    
(2, 'Bob', 'Johnson','bob.johnson@student.com','1234567891', 45, 1 ,1 ,15),   
(3, 'Charlie','Williams','charlie.williams@student.com','1234567892', 45, 1,1 ,16), 
(4, 'David','Jones','david.jones@student.com','1234567893', 45, 1,2,17),   
(5, 'Eva','Brown','eva.brown@student.com','1234567894', 45, 1,2,18),        
(6, 'Frank','Davis','frank.davis@student.com','1234567895', 45, 1,2,19),
(7, 'Grace','Miller','grace.miller@student.com','1234567896', 45, 1,3,20),  
(8, 'Henry','Wilson','henry.wilson@student.com','1234567897', 45, 1,3,21),  
(9, 'Isabella','Moore','isabella.moore@student.com','1234567898', 45, 1,3 ,22), 

(10, 'Jack', 'Taylor', 'jack.taylor@student.com', '1234567899', 45, 2, 1, 23), 
(11, 'Liam', 'Anderson', 'liam.anderson@student.com', '1234567800', 45, 2, 1, 24), 
(12, 'Mia', 'Thomas', 'mia.thomas@student.com', '1234567801', 45, 2, 1, 25),   
(13, 'Noah', 'Jackson', 'noah.jackson@student.com', '1234567802', 45, 2, 2, 26), 
(14, 'Olivia', 'White', 'olivia.white@student.com', '1234567803', 45, 2, 2, 27),
(15, 'Paul', 'Harris', 'paul.harris@student.com', '1234567804', 45, 2, 2, 28),   
(16, 'Quinn', 'Martin', 'quinn.martin@student.com', '1234567805', 45, 2, 4, 29),
(17, 'Riley', 'Thompson', 'riley.thompson@student.com', '1234567806', 45, 2, 4, 30),
(18, 'Sophia', 'Garcia', 'sophia.garcia@student.com', '1234567807', 45, 2, 4, 31),

(19, 'shimaa', 'rabie', 'shimaa.rabie@student.com', '1242746575', 45, 3, 2, 32),
(20, 'Uma', 'Robinson', 'uma.robinson@student.com', '1234567809', 45, 3, 2, 33),   
(21, 'Victor', 'Clark', 'victor.clark@student.com', '1234567810', 45, 3, 2, 34), 
(22, 'Wendy', 'Rodriguez', 'wendy.rodriguez@student.com', '1234567811', 45, 3, 3, 35), 
(23, 'ahmed', 'mohammed', 'ahmed.mohammed@student.com', '1203797809', 45, 3, 3, 36),
(24, 'Yara', 'Lee', 'yara.lee@student.com', '1234567813', 45, 3, 3, 37),         
(25, 'Zoe', 'Walker', 'zoe.walker@student.com', '1234567814', 45, 3, 4, 38),     
(26, 'Aaron', 'Hall', 'aaron.hall@student.com', '1234567815', 45, 3, 4, 39),     
(27, 'Bella', 'Young', 'bella.young@student.com', '1234567816', 45, 3, 4, 40);

-------------------------------------------------------------------------------------------------------------------------
-- Inserting data into Question
INSERT INTO Question (Question_Id, Q_Text, Q_Type , Course_Id) 
VALUES
(1, 'What does HTML stand for?', 'MCQ', 1),
(2, 'Which tag is used to create a hyperlink in HTML?', 'MCQ', 1),
(3, 'What is the purpose of CSS?', 'MCQ', 1),
(4, 'What does the "display" property do in CSS?', 'MCQ', 1),
(5, 'What is the output of 2 + 2 in css?', 'MCQ', 1),
(6, 'What is a closure in JavaScript?', 'MCQ', 2),
(7, 'What is React primarily used for?', 'MCQ', 3),
(8, 'What is the purpose of state in React?', 'MCQ', 3),
(9, 'Which language is primarily used for Android development?', 'MCQ', 4),
(10, 'What is the main function of the AndroidManifest.xml file?', 'MCQ', 4),
(11, 'Which language is used for iOS development?', 'MCQ', 5),
(12, 'What is Swift primarily designed for?', 'MCQ', 5),
(13, 'What is Flutter used for?', 'MCQ', 6),
(14, 'What is a widget in Flutter?', 'MCQ', 6),
(15, 'What is the main library used for machine learning in Python?', 'MCQ', 7),
(16, 'What is supervised learning?', 'MCQ', 8),
(17, 'What is a neural network?', 'MCQ', 9),
(18, 'What is the purpose of a database?', 'MCQ', 10),
(19, 'What does ETL stand for?', 'MCQ', 11),
(20, 'What is Hadoop used for?', 'MCQ', 12),

(21, 'Explain the box model in CSS.', 'Text', 1),
(22, 'What are the differences between HTML and XHTML?', 'Text', 1),
(23, 'Describe the event loop in JavaScript.', 'Text', 2),
(24, 'What are the advantages of using React?', 'Text', 3),
(25, 'Explain the lifecycle of an Android activity.', 'Text', 4),
(26, 'What are the key features of Swift?', 'Text', 5),
(27, 'How does Flutter achieve cross-platform development?', 'Text', 6),
(28, 'What is the difference between supervised and unsupervised learning?', 'Text', 8),
(29, 'Describe the architecture of a neural network.', 'Text', 9),
(30, 'What are the main types of databases?', 'Text', 10),

(31, 'What is the purpose of the <head> tag in HTML?', 'True/False', 1),
(32, 'CSS can be used to change the layout of a web page. (True/False)', 'True/False', 1),
(33, 'JavaScript is a server-side language. (True/False)', 'True/False', 2),
(34, 'React uses a virtual DOM. (True/False)', 'True/False', 3),
(35, 'Android apps can only be developed using Java. (True/False)', 'True/False', 4),
(36, 'Swift is a compiled language. (True/False)', 'True/False', 5),
(37, 'Flutter allows for hot reload. (True/False)', 'True/False', 6),
(38, 'Python is not suitable for machine learning. (True/False)', 'True/False', 7),
(39, 'Supervised learning requires labeled data. (True/False)', 'True/False', 8),
(40, 'Neural networks can only be used for classification tasks. (True/False)','True/False', 9)
------------------------------------------------------------------------------------------------------------------------------------------

-- Insert into MCQ Table
INSERT INTO MCQ (Question_Id, Choice1, Choice2, Choice3, Choice4, Correct_Answer) VALUES
(1, 'Hyper Text Markup Language', 'High Text Markup Language', 'Hyper Text Markup Link', 'None of the above', 'Hyper Text Markup Language'),
(2, '<link>', '<a>', '<href>', '<url>', '<a>'),
(3, 'To structure web pages', 'To style web pages', 'To create web applications', 'All of the above', 'All of the above'),
(4, 'It defines how an element is displayed', 'It sets the color of an element', 'It adds a border to an element', 'None of the above', 'It defines how an element is displayed'),
(5, '2', '22', '4', 'Undefined', '4'),
(6, 'A function that returns another function', 'A variable that holds a function', 'A type of loop', 'None of the above', 'A function that returns another function'),
(7, 'Building static websites', 'Building dynamic web apps', 'Building mobile apps', 'All of the above', 'Building dynamic web apps'),
(8, 'To manage data', 'To handle user input', 'To maintain component state', 'None of the above', 'To maintain component state'),
(9, 'Java', 'Kotlin', 'C++', 'Both Java and Kotlin', 'Both Java and Kotlin'),
(10, 'To define app permissions', 'To set the app theme', 'To manage app resources', 'None of the above', 'To define app permissions'),
(11, 'Java', 'Swift', 'Objective-C', 'All of the above', 'Swift'),
(12, 'To manage app resources', 'To define app permissions', 'To set the app theme', 'None of the above', 'To manage app resources'),
(13, 'Web development', 'Mobile development', 'Desktop applications', 'All of the above', 'Mobile development'),
(14, 'A reusable UI component', 'A layout structure', 'A database', 'None of the above', 'A reusable UI component'),
(15, 'Pandas', 'NumPy', 'Scikit-learn', 'All of the above', 'All of the above'),
(16, 'Learning from labeled data', 'Learning from unlabeled data', 'Learning without supervision', 'None of the above', 'Learning from labeled data'),
(17, 'A type of algorithm', 'A biological model', 'A type of data structure', 'None of the above', 'A biological model'),
(18, 'To store data', 'To retrieve data', 'To manage data', 'All of the above', 'All of the above'),
(19, 'Extract, Transform, Load', 'Extract, Transfer, Load', 'Extract, Transform, Link', 'None of the above', 'Extract, Transform, Load'),
(20, 'Data storage', 'Data processing', 'Data analysis', 'All of the above', 'All of the above')
-------------------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------
-- Insert into Text_Question Table
INSERT INTO Text_Question (Question_Id, Correct_Answer) 
VALUES
(21, 'The box model in CSS describes the rectangular boxes generated for elements in the document tree, consisting of margins, borders, padding, and the actual content.'),
(22, 'HTML is a markup language that structures content, while XHTML is a stricter and cleaner version of HTML that follows XML syntax.'),
(23, 'The event loop in JavaScript is a mechanism that allows JavaScript to perform non-blocking operations by using a single thread to handle asynchronous events.'),
(24, 'Advantages of using React include component-based architecture, virtual DOM for performance, and a rich ecosystem of libraries and tools.'),
(25, 'The lifecycle of an Android activity includes states such as onCreate, onStart, onResume, onPause, onStop, and onDestroy, which manage the activity?s lifecycle.'),
(26, 'Key features of Swift include type safety, optionals, closures, and a modern syntax that is easy to read and write.'),
(27, 'Flutter achieves cross-platform development by using a single codebase that compiles to native code for both iOS and Android, along with a rich set of pre-built widgets.'),
(28, 'Supervised learning uses labeled data to train models, while unsupervised learning uses unlabeled data to find patterns.'),
(29, 'A neural network consists of layers of interconnected nodes (neurons) that process input data and learn to make predictions or classifications.'),
(30, 'Main types of databases include relational databases (like MySQL) and non-relational databases (like MongoDB).')
--------------------------------------------------------------------------------------------------------------------------------------
-- Insert into Q_T_F Table
INSERT INTO Q_T_F (Question_Id, Correct_Answer) 
VALUES
(31, 'True'),
(32, 'True'),
(33, 'False'),
(34, 'True'),
(35, 'False'),
(36, 'True'),
(37, 'True'),
(38, 'False'),
(39, 'True'),
(40, 'False');
-----------------------------------------------------------------------------------
-- Inserting data into Exam
INSERT INTO Exam ( Exam_Id, E_Type ,StartTime, EndTime, E_date, INS_Id, Intake_NO, Course_Id, E_AllowedOption) 
VALUES
( 1 ,'Exam', '10:00:00', '12:00:00', '2023-05-01' , 1 , 45, 1,  0)


-------------------------------------------------------------------------
--------------------------------------------------------------------------
INSERT INTO Exam_Question (Exam_Id, Question_Id, quest_degree) VALUES
(1, 1, 20),
(1, 2, 20),
(1, 3, 20),
(1, 4, 20),
(1, 5, 20);

----------------------------------------------------------------------------------------------
-- Inserting data into Exam_Student
INSERT INTO Exam_Student (Exam_Id, Student_Id) 
VALUES
(1, 1),
(1, 2),
(1, 3);
----------------------------------------------------------------------------------

INSERT INTO Student_Answer (ans_id,Exam_Id , Student_Id, Question_Id, st_Answer, st_Mark) 
VALUES
(1, 1, 1, 1, 'Hyper Text Markup Language', 20),
(2, 1, 1, 2, '<a>', 20),
(3, 1, 1, 3, 'All of the above', 20),
(4, 1, 1, 4, 'It defines how an element is displayed', 20),
(5, 1, 1, 5, '4', 20),

(6, 1, 2, 1, 'Hyper Text Markup Language', 20),
(7, 1, 2, 2, '<a>', 20),
(8, 1, 2, 3, 'All of the above', 20),
(9, 1, 2, 4, 'It defines how an element is displayed', 20),
(10,1, 2, 5, '4', 0),

(11, 1, 3, 1, 'Hyper Text Markup Language', 20),
(12, 1, 3, 2, '<a>', 20),
(13, 1, 3, 3, 'Primary Key', 20),
(14, 1, 3, 4, 'It adds a border to an element', 0),
(15, 1, 3, 5, '22', 0);


