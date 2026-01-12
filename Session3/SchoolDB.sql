
CREATE DATABASE SchoolDB
CREATE TABLE students (
    student_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    dob DATE
);
CREATE TABLE courses (
    course_id SERIAL PRIMARY KEY,
    course_name VARCHAR(255) NOT NULL,
    credits INTEGER NOT NULL
);
CREATE TABLE enrollments (
    enrollment_id SERIAL PRIMARY KEY,
    student_id INTEGER NOT NULL,
    course_id INTEGER NOT NULL,
    grade CHAR(1),
    CONSTRAINT fk_enrollments_student
        FOREIGN KEY (student_id)
        REFERENCES students(student_id),
    CONSTRAINT fk_enrollments_course
        FOREIGN KEY (course_id)
        REFERENCES courses(course_id),
    CONSTRAINT chk_grade
        CHECK (grade IN ('A', 'B', 'C', 'D', 'F'))
);
INSERT INTO students (name, dob)
VALUES
('Nguyen Van A', '2003-05-10'),
('Tran Thi B', '2004-08-20');

INSERT INTO courses (course_name, credits)
VALUES
('Database Systems', 3),
('Software Engineering', 4);

INSERT INTO enrollments (student_id, course_id, grade)
VALUES
(1, 1, 'A'),
(1, 2, 'B'),
(2, 1, 'C');
SELECT * FROM students;
SELECT * FROM courses;
SELECT * FROM enrollments;
