-- SQL Progrramming
-- Declare Variable
--Syntax: DECLARE @VarName Datatype [= value]
Declare @name nvarchar(40)
Declare @age int = 18

-- Granted value for Variable
--Set @Varname = Value
--Select @varname = Value
SET @name = N'Trần Minh Tiến'
Select @age = 21

PRINT 'Hello ' + @name
PRINT 'You are ' + str(@age) + ' Year old'
-- If condition
If <Condition>
	SQL Commands
[else]
	SQL Commands
-- Block of code
Begin
	SQL Commands
End

-- Check a number is Even or Odd
Declare @n int
Set @n = 11
If @n % 2 = 0
	print 'Even number'
else
	print 'Odd number'
-- While loop
While <condition>
Begin
	SQL Commands
End

-- Sum S = 1 + 2 + ... + n
Declare  @n int = 100, @Total_Even int = 0, @Total_Odd int =0, @i int = 1
WHILE @i <= @n
	BEGIN
		IF @i%2 = 0
			SET @Total_Even += @i;
		ELSE
			SET @Total_Odd += @i;

		SET @i += 1;
	END

PRINT 'Even' + Str(@Total_Even)
PRINT 'Odd' + Str(@Total_Odd)

-- kiểm tra 1 số có phải là số hoàn hảo không
Declare @n int = 6, @total int = 0, @tmp int, @i int = 1
SET @tmp = @n
WHILE @i < @tmp
	BEGIN
		IF (@tmp % @i = 0)
			BEGIN
				SET @total += @i;
			END
		SET @i += 1;
	END
IF @total = @n
	PRINT 'Perfect number'
ELSE
	PRINT 'not perfect number'

-- Stored Procedure in SQL
Syntax: 
Create Procedure SP_name(Parameters)
as
begin
	SQL Commands
end
-- call execute a stored procedure
SP_name Parameters 

---------------------
--Stored procedure
Create Proc Tong(@n int)
as 
Begin
	Declare @total int = 0, @i int = 1
	While @i <= @n
		begin
			set @total += @i;
			set @i += 1;
		end
	Print 'Total is: ' + str(@total)
end
-- Call execute Tong procedure
Tong 20


-- tạo 1 thủ tục lưu trữ để tính các số chẵn từ 1 -> n
Create Proc evenSum(@n int) as
BEGIN
	Declare @total int = 0, @i int = 0
	While @i <= @n
		begin
			set @total += @i
			set @i += 2
		end
	Print 'Total even is: ' + str(@total)
END
GO
evenSum 100