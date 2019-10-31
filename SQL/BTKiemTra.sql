create database  BanHang
GO
USE BanHang
GO
Create table KhachHang(
	MaKH char(5) primary key not null,
	TenKH varchar(31) not null,
	DiaChi varchar(100) not null
)
Go
Create table HangHoa(
	MaHH char(5) primary key not null,
	TenHH varchar(51) not null,
	DonGia float not null,	
	ThueSuat float not null
)
GO
create table HoaDon(

	SoHD varchar(15) not null primary key,
	NgayLap date default getdate(),
	MaKH char(5) not null,
	MaHH char(5) not null,
	SoLuong int not null,
	TienHang money ,
	Thue float ,
	ChietKhau float ,
	TongTien money
)

DROP Table HoaDon
GO
ALTER TABLE HoaDon
ADD Constraint FK_MaKH foreign key (MaKH) references KhachHang(MaKH)
GO
ALTER TABLE HoaDon
ADD Constraint FK_MaHH foreign key (MaHH) references HangHoa(MaHH)
GO

Insert into KhachHang(MaKH, TenKH, DiaChi)
values('KH001','Tuan','Hue'), ('KH002','Tien','DN'), ('KH003','Linh','Hue'),('KH004','Toan','Quang Nam')
GO

insert into HangHoa(MaHH,TenHH,DonGia,ThueSuat)
values ('HH001','Sua',20000,0.2), ('HH002','Bot Giat',50000,0.1),('HH003','OiShi',10000,0.5),('HH004','Thuoc La',350000,0.7)
GO

create proc ThemHD(@SoHD varchar(15), @MaKH char(5), @MaHH char(5), @SoLuong int) as
begin
	if exists (select * from HoaDon where @SoHD = SoHD)
	print 'SoHD already exists'
	else
	begin
		if not exists (select * from KhachHang where @MaKH = MaKH)
		print'MaKH not exists'
		else
		begin
			if not exists (select * from HangHoa where @MaHH = MaHH)
			print'MaHH not exists'
			else
			begin
				-- SoLuong, TienHang, Thue, ChietKhau, TongTien
				Declare @TienHang money, @Thue float, @ChietKhau float, @TongTien money
				Declare @DonGia float
				Select @DonGia = DonGia from HangHoa where @MaHH = MaHH

				Declare @ThueSuat float
				Select @ThueSuat = ThueSuat from HangHoa where @MaHH = MaHH


				SET @TienHang = @SoLuong * @DonGia

				set @Thue = @TienHang * @ThueSuat

				set @ChietKhau = case
				when @TienHang > 10000000 then @TienHang*0.2
				when @TienHang >= 7000000 then @TienHang*0.15
				when @TienHang >= 4000000 then @TienHang*0.1
				else 0 end

				set @TongTien = @TienHang + @Thue - @ChietKhau

				Insert into HoaDon(SoHD, NgayLap, MaKH, MaHH, SoLuong, TienHang, Thue, ChietKhau, TongTien)
				values (@SoHD, getdate(), @MaKH, @MaHH, @SoLuong, @TienHang, @Thue, @ChietKhau, @TongTien)
			end
		end
	end
end


drop proc ThemHD
ThemHD 'HD006', 'KH003','HH003', 100000
select * from HoaDon	
select * from HangHoa