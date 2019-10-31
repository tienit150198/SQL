create database ChungCu
use ChungCu
create table CANHO(
	MaCanHo varchar(5) primary key not null,
	DienTich float,
	LoaiCanHo varchar(20),
	DonGiaThue float
);
create table KHACHHANG(
	MaKhach varchar(5) primary key not null,
	HoTenKhach varchar(41),
	NgaySinh date,
	GioiTinh bit default 0,
	DienThoai varchar(12),
	DiaChi varchar(100)
);
create table HOPDONG(
	SoHopDong varchar(5) primary key not null,
	NgayThue date,
	NgayTra date,
	ThoiGianThue int,
	TienDatTruoc float,
	GiaTriHopDong float,
	TienConLai float,
	MaCanHo varchar(5),
	MaKhach varchar(5),
	constraint FK_MaCanHo foreign key(MaCanHo) references CANHO(MaCanHo),
	constraint FK_MaKhach foreign key(MaKhach) references KHACHHANG(MaKhach)
);

create proc SP_ThemHopDong(@SoHopDong varchar(5), @NgayThue date, @NgayTra date, @MaCanHo varchar(5), @MaKhach varchar(5)) as
begin
	if exists (select * from HOPDONG where @SoHopDong = SoHopDong)
		print 'SoHopDong da ton tai';
	else
		begin
			if not exists (select * from CANHO where @MaCanHo = MaCanHo)
				print 'MaCanHo khong ton tai';
			else
				begin
					if not exists (select * from KHACHHANG where @MaKhach = MaKhach)
						print 'MaKhachHang khong ton tai';
					else
					begin
						insert into HOPDONG(SoHopDong,NgayThue,NgayTra,MaCanHo, MaKhach)
						values (@SoHopDong,@NgayThue,@NgayTra,@MaCanHo,@MaKhach);
					end
				end
		end
end

insert into CANHO 
values('CH001',20,'VIP',20000);
insert into KHACHHANG
values ('KH001','ABC', '20000103', 1, '070123456', 'Hue');
select * from KHACHHANG
SP_ThemHopDong 'HD001','20190118', '20190218', 'CH001','KH001'
select * from HOPDONG