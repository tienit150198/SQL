create database QLTD

create table Khach(
	MaK varchar(10) not null primary key,
	TenK varchar(41) not null,
	DiaChi varchar(101) not null
)
go
create table LHSD(
	MaLHSD varchar(10) not null primary key,
	DonGia float check (DonGia >= 0),
	DinhMuc int check (DinhMuc >= 0)
)
go
create table HopDong(
	SoHD varchar(10) not null primary key,
	SoCT int not null,
	NgayKy date default getdate(),
	MaK varchar(10) not null,
	MaLHSD varchar(10),
	constraint FK_MaK foreign key(MaK) references Khach(MaK),
	constraint FK_MaLHSD foreign key(MaLHSD) references LHSD(MaLHSD)
)
go
create table HoaDon(
	SoHoaDon varchar(10) not null primary key,
	SoHD varchar(10) not null,
	NgayLap date default getdate(),
	CSCu int,
	CSMoi int,
	SDSD int default 0,
	VuotDM float,
	TienDien bigint,
	TongTien bigint,
	constraint FK_SoHD foreign key(SoHD) references HopDong(SoHD)
)

alter table HoaDon
alter column TienDien float

alter table HoaDon
alter column TongTien float


insert into Khach
values ('KH001','Tran Tien', 'Hue'), ('KH002','Le Vi', 'Da Nang'),('KH003','Le Thi', 'Quang Nam')

insert into LHSD
values ('SH', 1900, 1000),('SX', 1500, 700),('KD', 1100, 500)

insert into HopDong
values ('HD001',1111,getdate(), 'KH001', 'SH'),('HD002',1231,getdate(), 'KH002', 'SX'),
('HD003',5432,getdate(), 'KH003', 'KD')

create proc SP_ADD_HoaDon (@SoHoaDon varchar(10), @SoHD varchar(10), @CSCu int, @CSMoi int)
as
begin
	if exists (select * from HoaDon where @SoHoaDon = SoHoaDon)
		print'SoHoaDon is exists'
	else
	begin
		if not exists (select * from HopDong where @SoHD = SoHD)
			print 'SoHD does not exists'
		else
		begin
			Declare @SDSD int, @TienDien float, @TongTien float, @MaLHSD varchar(10),
			@DinhMuc int, @DonGia float, @Thue float, @VuotDM int
			select @MaLHSD = MaLHSD from HopDong where @SoHD = SoHD
			select @DinhMuc = DinhMuc from LHSD where @MaLHSD = MaLHSD
			select @DonGia = DonGia from LHSD where @MaLHSD = MaLHSD

			set @SDSD = @CSMoi - @CSCu
			set @VuotDM = case
			when @SDSD > @DinhMuc then @SDSD - @DinhMuc
			else 0 end

			set @TienDien = @SDSD * @DonGia
			set @Thue = @TienDien * 0.1
			set @TongTien = @TienDien + @Thue + @TienDien* case
			when @VuotDM > 0 and @MaLHSD = 'SH' then 0.3
			when @VuotDM > 0 and @MaLHSD = 'SX' then 0.5
			when @VuotDM > 0 and @MaLHSD = 'KD' then 0.6
			else 0 end

			insert into HoaDon(SoHoaDon, SoHD, NgayLap, CSCu, CSMoi, SDSD, VuotDM, TienDien, TongTien)
			values (@SoHoaDon,@SoHD, getdate(), @CSCu, @CSMoi, @SDSD, @VuotDM, @TienDien, @TongTien)
		end
	end	
end

drop proc SP_ADD_HoaDon

SP_ADD_HoaDon 'HDon005', 'HD001', 1000,5000
select * from HoaDon

create trigger Delete_HoaDon 
ON HopDong FOR DELETE
AS
BEGIN
	delete from HoaDon
	where HoaDon.SoHD IN (select deleted.SoHD from deleted)

	print 'deleted successfully'
END
