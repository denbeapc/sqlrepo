/*
ALTER PROCEDURE StudentSuccessBasedOnGPA
AS
BEGIN
	-- navigate thru the student table
	DECLARE student_cursor CURSOR FOR 
		SELECT first_name, last_name, gpa FROM student

	OPEN student_cursor
	DECLARE @firstName varchar(50), @lastName varchar(50), @gpa float

	FETCH NEXT FROM student_cursor INTO
		@firstName, @lastName, @gpa;

	WHILE @@FETCH_STATUS = 0 BEGIN
		-- do the work here
		IF @gpa > 3.5
			PRINT N'GPA is greater than 3.5'
		ELSE BEGIN
			IF @gpa >= 3.0
				PRINT N'GPA is greater than 3.0'
		END

		FETCH NEXT FROM student_cursor INTO
			@firstName, @lastName, @gpa;
	END

	CLOSE student_cursor;
	DEALLOCATE student_cursor;
END
*/

exec StudentSuccessBasedOnGPA