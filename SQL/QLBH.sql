create table KhachHang(
MaKH char(5) not null primary key,
TenKH varchar(51) not null,
DiaChi varchar(101)
)

create table HangHoa(
MaHH char(5) not null primary key,
TenHH varchar(51) not null,
DonGia float,
ThueSuat float
)

go
create table HoaDon(
SoHD char(5) not null primary key,
NgayLap date default getdate(),
MaHH char(5) not null,
TongSoLuong bigint,
TienHang float,
MaKH char(5) not null,
Thue float,
TongTien float
)
go
create table ChitietHD(
SoCTHD char(5) not null primary key,
SoHD char(5),
MaHH char(5),
NgayLapCTHD date default getdate(),
SoLuongNhap int
)
go
insert into KhachHang
values('KH001','Cuong','HaTinh'),('KH002','Tien','Hue'),('KH003','Ha','DaNang')
go
insert into HangHoa
values('HH001','Sua', 20000, 0.03),('HH002','Banh Mi', 10000, 0.02),('HH003','Duong', 15000, 0.05)

go
insert into ChitietHD
values('CT001','HD001','HH001',getdate(),10),('CT002','HD002','HH002',getdate(),7),('CT003','HD003','HH003',getdate(),2)
go
insert into HoaDon(SoHD,NgayLap,MaHH,TongSoLuong,TienHang,MaKH,Thue,TongTien)
values('HD001',getdate(),'HH001',10,0, 'KH001',0.3,0),('HD003',getdate(),'HH003',20,0, 'KH003',0.5,0),('HD002',getdate(),'HH002',5,0, 'KH002',0.2,0)


go
select * from HoaDon

go
create trigger HD_Delete on HoaDon FOR DELETE AS
begin
	delete from ChitietHD where SoHD IN (select SoHD from deleted);
	print'Deleted succesfully'
end

Delete from HoaDon
where SoHD = 'HD001'

select * from HoaDon
select * from ChitietHD



go

create proc SP_ADD_CTHD (@SoCTHD char(5), @SoHD char(5), @MaHH char(5), @SoLuongNhap int) as
begin
	if exists (select * from ChitietHD where @SoCTHD = SoCTHD)
	print 'SoCTHD exists'
	else
	begin
		if not exists (select * from HoaDon where @SoHD = SoHD)
		print 'SoHD not exists'
		else
		begin
			if not exists (select * from HangHoa where @MaHH = MaHH)
			print 'MaHH not exists'
			else
			begin
				Declare @DonGia float, @TienHang float, @ThueSuat float
				select @DonGia = DonGia from HangHoa where @MaHH = MaHH
				select @TienHang = TienHang from HoaDon where @SoHD = SoHD
				select @ThueSuat = ThueSuat from HangHoa where @MaHH = MaHH

				insert into ChitietHD(SoCTHD,SoHD,MaHH,NgayLapCTHD,SoLuongNhap)
				values (@SoCTHD,@SoHD,@MaHH,getdate(), @SoLuongNhap)

				update HoaDon
				set TienHang = @TienHang + @DonGia * @SoLuongNhap * (1+@ThueSuat)
				where @SoHD = SoHD
			end
		end
	end
end
drop proc SP_ADD_CTHD		-- xoa proc
truncate table HoaDon		-- xoa het du lieu trong bang HoaDon de nhap lai bang insert into

select * from HoaDon
select * from HangHoa
select * from ChitietHD

SP_ADD_CTHD 'CT004','HD001','HH001',2
-- inserted: dữ liệu mới được thêm vào sẽ được lưu ở đây
-- deleted: dữ liệu cũ sẽ được  lưu ở đây
-- trigger: tự động được gọi


create trigger CTHD_Insert ON ChitietHD FOR INSERT AS
begin
	Declare @SoLuongNhap int, @SoHD char(5), @MaHH char(5), @TongSoLuong bigint,@TienHang float,@TongTien float, @DonGia float, @Thue float
	select @SoLuongNhap = SoLuongNhap from inserted
	select @SoHD = SoHD from inserted
	select @MaHH = MaHH from inserted
	select @DonGia = DonGia from HangHoa where @MaHH = MaHH
	select @TongSoLuong = TongSoluong from HoaDon where @SoHD = SoHD
	select @Thue = Thue from HoaDon where @SoHD = SoHD
	set @TongSoLuong = @TongSoLuong + @SoLuongNhap
	set @TienHang = @TongSoLuong * @DonGia
	set @TongTien = @TongTien * (1 + @Thue)

	UPDATE HoaDon
	set TongSoLuong = @TongSoLuong,
	 TienHang = @TienHang,
	 TongTien = @TongTien
	where @SoHD = SoHD
end