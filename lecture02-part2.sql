/*
alter procedure SetStudentMajorByMajorDescription
	@last_name nvarchar(50),
	@majorDescription varchar(50)
as
BEGIN
	declare @studentId int 
	select @studentId = Id from student where last_name = @last_name

	declare @majorId int
	select @majorId = Id from major where description = @majorDescription

	update student set major_id = @majorId
		where id = @studentId
END
*/

exec SetStudentMajorByMajorDescription 'Gould', 'General Studies'