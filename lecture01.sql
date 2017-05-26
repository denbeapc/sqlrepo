-- query: all columns for students with and assigned major
select * from student
	where major_id is not null

-- query: all columns for students without and assigned major
select * from student 
	where major_id is null

/*update student set major_id = 5 where id = 160

select * from student
select * from major*/

-- query: display students firstname, lastname, description(major) in description sequence
select first_name, last_name, description
from student
join major 
	on student.major_id = major.id
where sat >= 1200

-- query: list all classes, show instructors name, order by instructors first and last name
select subject as 'Department', section as 'Section #', CONCAT(first_name, ' ', last_name) as 'Instructor'
from class
join instructor 
	on class.instructor_id = instructor.id
order by last_name

select * from major
select * from class
select * from major_class_relationship

-- query: show all required classes for the psychology major
select description, subject, section 
from major
	join major_class_relationship
		on major_class_relationship.major_id = major.id
	join class
		on class.id = major_class_relationship.class_id
	where major.description = 'Engineering'


select * from major
select * from class
select * from major_class_relationship


-- query: show all majors which require Math 201
select description as 'Major', concat(subject, ' ', section) as 'Class'
from major
	join major_class_relationship
		on major_class_relationship.major_id = major.id
	join class
		on class.id = major_class_relationship.class_id
	where subject = 'Math' and section = '201'



-- left join will display everything on the left, and whatever values
-- on the right that match up
-- in this case, every student, some have null major, some have an actual
-- major
select concat(first_name, ' ', last_name), ISNULL(description, 'Undeclared') as 'Major'
from student
	left join major
		on major.id = student.major_id

-- gives current date and time
select getdate()

select concat(subject, ' ', section) as Class, concat(first_name, ' ', last_name) as Instructor
from class
	join instructor
		on instructor.id = class.instructor_id
	where subject = 'English' and instructor_id is not null
union
select concat(subject, ' ', section) as Class, concat(first_name, ' ', last_name) as Instructor
from class
	join instructor
		on instructor.id = class.instructor_id
	where subject = 'Math' and instructor_id is not null



-- subselect query: display all students that have GPAs greater than the average GPA
select avg(gpa) from student


select concat(first_name, ' ', last_name) as Name, gpa as GPA
from student
	where gpa > (select avg(gpa) from student)


select * from class
where section in ('101', '102', '103')


select section from class 
where subject = 'English' and section < '200'


select * from class
where section in (select section from class 
					where subject = 'English' and section < '200')


/******* Script for SelectTopNRows command from SSMS *******/
SELECT TOP (1000) [id]
		,[first_name]
		,[last_name]
		,[sat]
		,[gpa]
		,[major_id]
	FROM [education].[dbo].[student]

select sat
	,avg(gpa) as 'AVERAGE'
	,count(gpa) as 'COUNT'
	,min(gpa) as 'MIN'
	,max(gpa) as 'MAX' from student
-- where gpa >= 2.6
group by sat
having avg(gpa) >= 3.0