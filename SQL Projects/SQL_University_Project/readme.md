# [SQL - EDA.](https://github.com/din3shn/DA_Portfolio_Proj/blob/main/SQL_University_Project/University_Project_Solution.sql)

- **Intro** : This project involves analyzing a comprehensive university database. The database schema consists of multiple tables containing data about students, courses, teachers and more. All the tables have a primary or a foreign key. This project involves writing complex SQL queries to extract meaningful insights from the university database. The queries make extensive use of joins, aggregate functions, and the GROUP BY clause to answer specific questions which you can find below about the university's operations.
   - This project was done on MS SQL Server.</sub>

- **Functions used** :
CREATE, INSERT, SELECT, SUM, COUNT, AVG, MAX, JOINS, GROUP BY, CTE, SUBQUERIES, CONCAT, LIKE, CASE, ORDER BY ETC.

- **Schema Used**: [university](https://github.com/din3shn/DA_Portfolio_Proj/blob/main/SQL_University_Project/university_schema.md)<br>
  The provided schema represents a university database. It outlines the relationships between various entities such as students, instructors, departments, courses, and more.<br>
   - **Key relationships include**:<br>
     - Students taking courses, represented by the “takes” entity.
     - Instructors teaching specific sections of courses, represented by the “teaches” entity.
     - Courses having prerequisites, represented by the “prereq” entity. <br>

These relationships allow for complex queries and analyses. This schema provides a comprehensive framework for managing and analyzing data in an educational institution.

- ## Data Analysis :
  
      - Instructors for student with highest 5 credits.
      - Semester and department offering maximum number of courses.
      - Courses that start and end at 8.
      - All course titles which have a string "Intro.".
      - Course Titles of courses in the Computer Science department that have 3 credits.
      - Count of Students in each section in Fall Semester.
      - Update salary by 10% if salary less than 90000.
      - For each department, find the total credit hours of courses in that department.
      - Find the number of courses having A grade in each building.
      - Display number of students in each department having total credits divisible by course credits.
      - Find number of instructors in each department having 'a' and 'e' in their name.
      - Count of courses in each  building
      - number of courses being taught in classroom having capacity more than 20.
      - Add 1000 to all the departments' budget.
      - Display number of students attending classes on Wednesday.
      - Display number of students and instructors in each department.
      - Display number of students in each semester and their sum of credits.
      - Find total credits earned by students coming at 9am.
      - Student Names and Room numbers ordered by Room
      - Remaining capacity of rooms.
      - Duration of class of each student.
      - Time Table with room number and building name.
      - Course title and avg salary of instructors.
      - Duration of each course id.
      - If the department budget was to be distributed among the buildings,
        how much amount can be allocated to each room in a building?
