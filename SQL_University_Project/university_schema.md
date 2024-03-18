# Database Schema: University 
<br>

![Picture1](https://github.com/din3shn/DA_Portfolio_Proj/assets/160537914/a2910d8e-b3bb-4103-9e27-53bbb0de3156) <br>
  
<br>
The relationships between these entities are depicted with lines connecting them. <br>
There are primary keys and foreign keys mentioned. <br>
For example, a many-to-many relationship exists between “student” and “section” through the “takes” relationship. <br> 
An identifying relationship exists between “instructor” and “section” through “teaches”, indicating that instructors teach specific sections of courses.

## DDL Query

        create table classroom (
        building varchar(15),
        room_number	varchar(7) primary key,
        capacity numeric(4,0)
        );

        create table department ( 
        dept_name		varchar(20),
        building		varchar(15),
        budget		  numeric(12,2) check (budget > 0),
        primary key (dept_name)
        );
        
        create table course
        (course_id		varchar(8),
        title			varchar(50),
        dept_name		varchar(20),
        credits		numeric(2,0) check (credits > 0),
        primary key (course_id),
        foreign key (dept_name) references department (dept_name)
        on delete set null
        );
        
        create table instructor
        (ID			varchar(5),
        name			varchar(20) not null,
        dept_name		varchar(20),
        salary			numeric(8,2) check (salary > 29000),
        primary key (ID),
        foreign key (dept_name) references department (dept_name)
        on delete set null
        );
        
        create table time_slot
        	(id int primary key,
        	time_slot_id		varchar(4),
        	 day			varchar(1),
        	 start_hr		numeric(2) check (start_hr >= 0 and start_hr < 24),
        	 start_min		numeric(2) check (start_min >= 0 and start_min < 60),
        	 end_hr			numeric(2) check (end_hr >= 0 and end_hr < 24),
        	 end_min		numeric(2) check (end_min >= 0 and end_min < 60)
        	);
        
        create table section
        	(course_id		varchar(8), 
          sec_id			varchar(8),
        	semester		varchar(6)
        	check (semester in ('Fall', 'Winter', 'Spring', 'Summer')), 
          year			numeric(4,0) check (year > 1701 and year < 2100), 
        	building		varchar(15),
        	room_number		varchar(7),
        	time_slot_id		varchar(4),
        	id int,
        	primary key (course_id, sec_id, semester, year),
        	foreign key (course_id) references course (course_id)
        	on delete cascade,
        	foreign key (room_number) references classroom (room_number)
        	on delete set null,
        	foreign key (id) references time_slot (id)
        	on delete set null,
        	);
         
        create table teaches
        (ID			varchar(5),
        course_id		varchar(8),
        sec_id			varchar(8),
        semester		varchar(6),
        year			numeric(4,0),
        primary key (ID, course_id, sec_id, semester, year),
        foreign key (course_id, sec_id, semester, year) references section (course_id, sec_id, semester, year)
        on delete cascade,
        foreign key (ID) references instructor (ID)
        on delete cascade
        );
        
        create table student
        (ID			varchar(5),
        name			varchar(20) not null,
        dept_name		varchar(20),
        tot_cred		numeric(3,0) check (tot_cred >= 0),
        primary key (ID),
        foreign key (dept_name) references department (dept_name)
        on delete set null
        );
        
        create table takes
        (ID			varchar(5),
        course_id		varchar(8),
        sec_id			varchar(8),
        semester		varchar(6),
        year			numeric(4,0),
        grade		        varchar(2),
        primary key (ID, course_id, sec_id, semester, year),
        foreign key (course_id, sec_id, semester, year) references section (course_id, sec_id, semester, year)
        on delete cascade,
        foreign key (ID) references student (ID)
        on delete cascade
        );
        
        create table advisor
        (s_ID			varchar(5),
        i_ID			varchar(5),
        primary key (s_ID),
        foreign key (i_ID) references instructor (ID)
        on delete set null,
        foreign key (s_ID) references student (ID)
        on delete cascade
        );
        
        create table prereq
        (course_id		varchar(8),
        prereq_id		varchar(8),
        primary key (course_id, prereq_id),
        foreign key (course_id) references course (course_id)
        on delete cascade,
        foreign key (prereq_id) references course (course_id)
        );
