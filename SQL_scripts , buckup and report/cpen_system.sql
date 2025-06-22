CREATE TABLE IF NOT EXISTS studentDeets(
student_id INT PRIMARY KEY,
first_name VARCHAR(30) NOT NULL,
last_name VARCHAR(30) NOT NULL,
email VARCHAR(50) UNIQUE,
phone INT UNIQUE NOT NULL
);

CREATE TABLE IF NOT EXISTS lecturers(
lecturer_id SERIAL PRIMARY KEY,
lecturer_first_name VARCHAR(30) NOT NULL,
lecturer_last_name VARCHAR(30) NOT NULL,
email VARCHAR(40) UNIQUE,
phone INT UNIQUE NOT NULL
);

CREATE TABLE IF NOT EXISTS courses(
course_id SERIAL PRIMARY KEY,
course_name VARCHAR(40) NOT NULL UNIQUE,
course_description TEXT NOT NULL,
lecturer_id INT REFERENCES lecturers(lecturer_id)
);

CREATE TABLE IF NOT EXISTS feesPayment(
payment_id SERIAL PRIMARY KEY,
student_id INT REFERENCES studentDeets(student_id),
amount_paid DECIMAL(10, 2) DEFAULT 0
);

CREATE TABLE IF NOT EXISTS courseEnrollments(
student_id INT REFERENCES studentDeets(student_id),
course_id INT REFERENCES courses(course_id)
);

CREATE TABLE IF NOT EXISTS TAs(
ta_id SERIAL PRIMARY KEY,
ta_first_name VARCHAR(30) NOT NULL,
ta_last_name VARCHAR(30) NOT NULL,
ta_email VARCHAR(40) UNIQUE,
ta_phone INT UNIQUE NOT NULL,
lecturer_id INT REFERENCES lecturers(lecturer_id)
);


CREATE TABLE IF NOT EXISTS users(
id SERIAL PRIMARY KEY,
email VARCHAR(120) UNIQUE,
password_hash VARCHAR(170) NOT NULL,
username VARCHAR(40) UNIQUE
);