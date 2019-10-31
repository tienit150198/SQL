create database Student
go
use Student
go
-- create table
create table Sinhvien(
	masv varchar(5) not null primary key,
	tensv varchar(30) not null,
	lop varchar(10) not null,
	tuoi int check(tuoi > 0)
)
go
create table Diem(
	id int identity primary key not null,
	masv varchar(5) not null unique,
	toan float not null default 0,
	van float not null default 0,
	hoa float not null default 0,
	diemtb float not null default 0,
	constraint FK_masv foreign key (masv) references Sinhvien(masv)
)

go
-- insert
insert into Sinhvien
values ('SV001', 'tien', '16CT', 10),('SV002', 'tuan', '16CT', 11),('SV003', 'tai', '16CT', 12)
go
insert into Diem(masv,toan,van,hoa)
values ('SV001',9,8,9), ('SV002',7,7,5)
go
-- function tinh diemTB of Diem
create function tinhDTB(@toan float, @van float, @hoa float) returns float
as begin
	declare @dtb float;

	set @dtb = (@toan + @van + @hoa)/3;

	return @dtb;
end
go
select dbo.tinhDTB(9,8,9) as 'diemtb' -- goi function diemTB
go
-- tao proc them mot sinh vien moi
create proc SP_add_sinhvien(@masv varchar(5), @tensv varchar(30), @lop varchar(10), @tuoi int)
as
begin
	if exists (select * from Sinhvien where Sinhvien.masv = @masv)
		print N'mã sinh viên đã tồn tại'
	else
	begin
		insert into Sinhvien(masv,tensv,lop,tuoi)
		values (@masv, @tensv, @lop, @tuoi)
		print N'thêm sinh viên thành công'
	end
end
go
-- gọi proc
exec SP_add_sinhvien 'SV004', 'thao', '16CT', 20
go
SP_add_sinhvien 'SV005', 'linh', '16CT',22
go

-- tạo trigger tự động cập nhật điểm trung bình khi thêm sinh viên mới.
create trigger tr_diem_update
on Diem
for insert
as
begin
	-- dữ liệu sau khi insert sẽ được lưu ở table inserted, lợi dụng điều này ta update như sau
	declare @dtb float, @toan float, @van float, @hoa float, @masv varchar(5);	-- khai báo các biến
	-- lấy dữ liệu từ bảng inserted
	select @toan = toan from inserted;
	select @van = van from inserted;
	select @hoa = hoa from inserted;
	select @masv = masv from inserted;

	-- set biến dtb
	set @dtb = (@toan +  @van + @hoa) /3;
	update Diem
	set Diem.diemtb = @dtb
	where Diem.masv = @masv;
end

-- insert dữ liệu bảng Diem vào
insert into Diem(masv,toan,van,hoa)
values ('SV004',5,3,2)

-- select để xem dữ liệu hiện tại
select * from Diem