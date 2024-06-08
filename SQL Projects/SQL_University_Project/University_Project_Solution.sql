select * from takes;
select * from prereq;
select * from student;
select * from section;
select * from time_slot;
select * from course;

-- Instructors for student with highest 5 credits.
select top 5 student.name as Student, instructor.name as Instructor, student.tot_cred 
from student, instructor where student.dept_name=instructor.dept_name 
order by tot_cred desc;

-- Semester and department offering maximum number of courses.
select semester, dept_name, count(c.course_id) as max 
from section s, course c where s.course_id=c.course_id 
group by semester, dept_name order by max desc;

-- Courses that start and end at 8.
select ts.start_hr, ts.end_hr, count(title) as Tot from course ct, section st, time_slot ts 
where ct.course_id=st.course_id and ts.time_slot_id=st.time_slot_id 
and start_hr= '8' and end_hr='8' group by start_hr,end_hr;

-- Find all course titles which have a string "Intro.".
select title from course where title like '%Intro%';

-- Find the titles of courses in the Computer Science department that have 3 credits.
select * from course;
select title from course where dept_name like 'Comp.%' and credits = 3;

-- Find IDs and titles of all the courses which were taught by an instructor named Einstein. Make sure there are no duplicates in the result.
select distinct ct.course_id, ct.title from course ct 
join instructor it on ct.dept_name=it.dept_name where it.name = 'Einstein';

-- Find all course IDs which start with CS
select course_id from course where course_id like 'CS%';

-- Count of Students in each section in Fall Semester.
select * from takes;
select sec_id, semester, year, count(course_id) as Tot 
from takes where semester = 'Fall' and year = 2017 group by sec_id, semester, year;

-- Update salary by 10% if salary less than 90000.
select * from instructor;
update instructor set salary = salary*1.1 where salary between 0 and 90000;

-- For each department, find the total credit hours of courses in that department.
select ct.dept_name, sum(credits) as Tot_Cred from course ct group by dept_name;

-- Find the number of courses having A grade in each building.
select st.building,count(tk.course_id) as No_of_Courses, tk.grade from takes tk, section st 
where st.course_id=tk.course_id and grade = 'A' group by building, grade;

-- Display number of students in each department having total credits divisible by course credits.
select student.dept_name, count(student.ID) as No_Stu from student join course on student.dept_name=course.dept_name 
where tot_cred%credits=0 group by student.dept_name;

-- Count of courses in each  building
select dt.building, count(ct.course_id) as Tot from department dt, course ct where dt.dept_name=ct.dept_name group by building;

-- Find number of instructors in each department having 'a' and 'e' in their name.
select dept_name, name,count(name) as No_Ins from instructor where name like '%a%e%' group by dept_name, name;

-- Display number of courses being taught in classroom having capacity more than 20.
select ct.room_number, count(st.course_id) as No_Cl from classroom ct, section st 
where ct.room_number = st.room_number and capacity > 20 group by ct.room_number;

-- Add 1000 to the department budget.
update department set budget = budget+1000;

-- Display number of students attending classes on Wednesday.
select ts.day, count(tk.ID) as No_Stu from time_slot ts, takes tk, section sc 
where sc.course_id=tk.course_id and ts.time_slot_id=sc.time_slot_id and day= 'W' group by day;

-- Display number of students and instructors in each department
select dept_name, count(*) as 'No. of Stu & Ins' from student group by dept_name
union all select dept_name, count(*) from instructor group by dept_name;

-- Display number of students in each semester and their sum of credits.
select tk.semester, count(*) as No_of_Std, sum(st.tot_cred) as Sum_of_Cred from takes tk, student st where tk.ID=st.ID group by semester;

-- Find total credits earned by students coming at 9am
select st.name, ts.start_hr, st.tot_cred from student st, time_slot ts, section sc, takes tk 
where ts.time_slot_id=sc.time_slot_id and st.ID=tk.ID and tk.course_id=sc.course_id
and start_hr = 9 group by name, start_hr, tot_cred;

-- Student Names and Room numbers ordered by Room
select st.name, sc.room_number from student st, section sc, takes tk 
where st.ID=tk.ID and sc.course_id = tk.course_id group by room_number, name order by room_number;

-- Remaining capacity of rooms.
select cr.room_number, cr.capacity- count(tk.ID) as Rem_Cap from takes tk, section sc, classroom cr 
where sc.course_id=tk.course_id and cr.room_number = sc.room_number 
group by cr.room_number, capacity;

-- Duration of class of each student.
select st.name, tk.course_id, end_hr-start_hr as Dur_in_Hrs, end_min-start_min as Dur_in_Min 
from student st, takes tk, time_slot ts, section sc
where st.ID=tk.ID and tk.course_id=sc.course_id and sc.time_slot_id=ts.time_slot_id  
group by name, tk.course_id, start_hr, end_hr, start_min, end_min;

--- Time Table with room number and building name
select sc.course_id, ts.day, sc.room_number, sc.building from section sc, time_slot ts 
where ts.time_slot_id=sc.time_slot_id group by day, course_id, room_number, building order by day;

-- Course title and avg salary of instructors
select ct.title, round(avg(it.salary),2) as avg_sal from course ct, instructor it, teaches tc 
where ct.course_id=tc.course_id and it.ID=tc.ID group by title order by avg_sal desc;

-- Duration of each course id
with tsd as (select time_slot_id, (end_min-start_min) as Duration from time_slot ts) 
select sc.course_id, avg(tsd.Duration) as Avg_Dur from section sc, tsd where sc.time_slot_id=tsd.time_slot_id group by course_id;

-- If the department budget was to be distributed among the buildings, how much amount can be allocated to each room in a building.
with RD as (
select building, count(room_number) as c from classroom group by building
)
select dt.building, sum(budget)/c as Room_Budget 
from department dt, RD where dt.building=RD.building 
group by dt.building, c;