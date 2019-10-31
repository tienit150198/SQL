/*User function in SQL
-- syntax:
Create function <UF_name>(Parameters) Returns DataType
AS
BEGIN

Return <Function_value>

END
*/
USE ATM 
GO
-- 1 + 2 +...+n
Create function sum_n(@n int)	returns int
as
begin
	Declare @res int = 0, @i int = 1;
	while(@i <= @n)
	begin
		set @res += @i;
		set @i += 1;
	end
	
	return @res;
end
GO
-- tong chan
Create function sum_even(@n int)	returns int
as
begin
	Declare @res_even int = 0, @i int = 1;
	while(@i <= @n)
	begin
		if(@i % 2 = 0)	-- check value is even or not
			set @res_even += @i;
		set @i += 1;
	end
	
	return @res_even;
end

-- tong le
GO
Create function sum_odd(@n int)	returns int
as
begin
	Declare @res_odd int = 0, @i int = 1;
	while(@i <= @n)
	begin
		if(@i % 2 = 1)
			set @res_odd += @i;
		set @i += 1;
	end
	
	return @res_odd;
end

select dbo.sum_n(10) as N'Tổng'
select dbo.sum_odd(10) as N'Tổng Lẻ'
select dbo.sum_even(10) as N'Tổng Chẵn'
GO
-- create function pefect_number
create function pefect_number(@n int) returns bit
as
begin
	declare @flag bit = 0, @total int = 0, @i int = 1;

	while(@i < @n)
	begin
		if(@n % @i = 0)
		begin
			set @total += @i;
			
		end
		set @i += 1;
	end

	if(@n = @total)
		set @flag = 1;

	return @flag;
end
GO
-- display pefect number in 1 -> 1000
Declare @i int = 1;
while(@i <= 1000)
begin
	Declare @tmp bit;
	select @tmp = dbo.pefect_number(@i);
	if(@tmp = 1)
	print @i + '  ';

	set @i +=1;
end
GO
create function prime_number(@n int) returns bit
as
begin
	declare @flag bit = 1, @i int = 2, @tmp int = sqrt(@n);

	if(@n < 2)
		set @flag = 0;
	else if(@n %2 = 0 AND @n <> 2)
		set @flag = 0
	else
	begin
		while(@i <= @tmp)
		begin
			if(@n % @i = 0)
				set @flag = 0;
				
			set @i += 1;
		end
	end
	return @flag;
end
GO
drop function prime_number
GO
Declare @i int = 1;
while(@i <= 100)
begin
	Declare @tmp bit;
	select @tmp = dbo.prime_number(@i);
	if(@tmp = 1)
	print @i + '  ';

	set @i +=1;
end
GO
select dbo.prime_number(4)