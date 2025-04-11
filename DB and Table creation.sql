CREATE database college_db;
USE college_db;

-- Table 1: students
DROP TABLE IF EXISTS students;
CREATE TABLE students (
    student_id INT PRIMARY KEY,
    name VARCHAR(50),
    gender CHAR(1),
    age INT,
    major VARCHAR(50)
);

-- Table 2: courses
CREATE TABLE courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(100),
    department VARCHAR(50),
    credits INT
);

-- Table 3: enrollments
CREATE TABLE enrollments (
    enrollment_id INT PRIMARY KEY,
    student_id INT,
    course_id INT,
    grade VARCHAR(2),
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

SHOW TABLES;

-- Insert into students
INSERT INTO students VALUES
(1, 'Alice Smith', 'F', 20, 'Computer Sci'),
(2, 'Bob Johnson', 'M', 22, 'Mathematics'),
(3, 'Clara Davis', 'F', 21, 'Physics'),
(4, 'Daniel Evans', 'M', 23, 'Computer Sci'),
(5, 'Eva Thomas', 'F', 20, 'Mathematics'),
(6, 'Felix Wright', 'M', 22, 'Chemistry');

-- Insert into courses
INSERT INTO courses VALUES
(101, 'Intro to CS', 'Computer Sci', 4),
(102, 'Linear Algebra', 'Mathematics', 3),
(103, 'Classical Physics', 'Physics', 4),
(104, 'Organic Chemistry', 'Chemistry', 3),
(105, 'Data Structures', 'Computer Sci', 4);

-- Insert into enrollments
INSERT INTO enrollments VALUES
(1, 1, 101, 'A'),
(2, 1, 105, 'A-'),
(3, 2, 102, 'B+'),
(4, 2, 101, 'B'),
(5, 3, 103, 'A'),
(6, 4, 105, 'B+'),
(7, 5, 102, 'A'),
(8, 6, 104, 'C+'),
(9, 3, 101, 'B'),
(10, 4, 101, 'A');
