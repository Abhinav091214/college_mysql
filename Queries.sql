USE college_db;

-- List all entries from all tables
SELECT * FROM students;
SELECT * FROM courses;
SELECT * FROM enrollments;

-- 1. List all students majoring in 'Computer Sci'
SELECT name, major
FROM students
WHERE major = 'Computer Sci';

-- 2. Find all courses with more than 3 credits
SELECT * 
FROM courses
WHERE credits >=3;

-- 3. Show the names of students and the courses they are enrolled in
SELECT s.name,e.course_id,c.course_name
	FROM students s
    JOIN enrollments e ON s.student_id = e.student_id
    JOIN courses c ON c.course_id = e.course_id
    ORDER BY s.name ASC;
    
-- 4. List all students along with their grades for the course 'Intro to CS
SELECT s.name, e.course_id,c.course_name,e.grade 
	FROM students s
    JOIN enrollments e ON s.student_id = e.student_id
    JOIN courses c ON c.course_id = e.course_id
    WHERE c.course_name = 'Intro to CS';
    
-- 5. Count the number of students in each major
SELECT major, count(*) AS 'Num of students'
FROM students
GROUP BY major;

-- 6. Find the average age of students enrolled in 'Computer Sci' courses
SELECT Round(AVG(age),2) AS avg_age
FROM students
WHERE major = 'Computer Sci';

-- 7. List the number of students enrolled in each course
SELECT c.course_name, count(*) AS num_students
 FROM students s
 JOIN enrollments e ON s.student_id = e.student_id
 JOIN courses c ON c.course_id = e.course_id
 GROUP BY c.course_name;
 
 -- 8. What is the most popular course (highest enrollment)?
 SELECT c.course_name, COUNT(e.student_id) AS total_enrolled
FROM courses c
JOIN enrollments e ON c.course_id = e.course_id
GROUP BY c.course_name
ORDER BY total_enrolled DESC
LIMIT 1;

-- 9.  List the top 3 students with the most courses enrolled
SELECT s.name,count(e.student_id) AS num_courses
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
GROUP BY s.name
LIMIT 3;

-- 10. Show all courses sorted by number of enrollments (descending)
SELECT c.course_name,count(*)
FROM courses c
JOIN enrollments e ON c.course_id = e.course_id
GROUP BY c.course_name
ORDER BY count(*) DESC;    

-- 11. Find students who scored an 'A' in any course
SELECT s.name,c.course_name,e.grade
FROM students s 
JOIN enrollments e ON s.student_id = e.student_id
JOIN courses c ON c.course_id = e.course_id
WHERE e.grade = 'A';

-- 12. Find students enrolled in every course offered by the Computer Sci department.
SELECT s.name
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
JOIN courses c ON c.course_id = e.course_id
WHERE c.department = 'Computer Sci'
GROUP BY s.student_id, s.name
HAVING COUNT(DISTINCT c.course_id) = (
    SELECT COUNT(*) 
    FROM courses 
    WHERE department = 'Computer Sci'
);
-- 13,  List students who are NOT enrolled in any course
SELECT name
FROM students
WHERE student_id NOT IN (
    SELECT DISTINCT student_id FROM enrollments
);

-- 14. 
SELECT s.name
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
JOIN courses c ON c.course_id = e.course_id
WHERE c.course_name IN ('Intro to CS', 'Data Structures')
GROUP BY s.student_id, s.name
HAVING COUNT(DISTINCT c.course_name) = 2;

-- 15. Create a view showing each student's name, major, and GPA (assuming A=4.0, A-=3.7, B+=3.3, B=3.0, etc.).
DROP VIEW IF EXISTS student_gpa;
CREATE VIEW student_gpa AS
SELECT 
    s.name,
    s.major,
    e.grade,
    ROUND(AVG(
        CASE 
            WHEN e.grade = 'A'  THEN 4.0
            WHEN e.grade = 'A-' THEN 3.7
            WHEN e.grade = 'B+' THEN 3.3
            WHEN e.grade = 'B'  THEN 3.0
            WHEN e.grade = 'B-' THEN 2.7
            WHEN e.grade = 'C+' THEN 2.3
            WHEN e.grade = 'C'  THEN 2.0
            WHEN e.grade = 'C-' THEN 1.7
            WHEN e.grade = 'D'  THEN 1.0
            WHEN e.grade = 'F'  THEN 0.0
            ELSE NULL
        END
    ), 2) AS gpa
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
GROUP BY s.student_id, s.name, s.major,e.grade;

SELECT * FROM student_gpa;





