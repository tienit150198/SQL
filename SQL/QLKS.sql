create database QuanLiKhachSan
use QuanLiKhachSan
go

create table KhachHang(MaKH varchar(20) not null primary key, TenKH nvarchar(41) not null,
Tuoi int not null, DiaChi nvarchar(100), Gioitinh bit default 0, SDT varchar(20), SoCMND varchar(12),
Quoctich nvarchar(31) default N'Việt Nam', GhiChu nvarchar(100))

---
create table Logon(MaNV varchar(20), MatKhau varchar(24));
---
create table NhanVien(MaNV varchar(20) not null primary key, TenNV nvarchar(41) not null, Tuoi int default 0, DiaChi nvarchar(100), Gioitinh bit default 0,
Luong float , ChucVu nvarchar(20) default N'Nhân Viên', GhiChu nvarchar(100))

create table HoaDon(MaHD int identity primary key, MaPT varchar(20) not null, MaPhong varchar(20), 
TenKH nvarchar(41), GiaPhong int, TongTien float default 0, GhiChu nvarchar(100))

create table HoaDonOfDichVu(MaDV varchar (20) not null, MaHD int , TenDV nvarchar(41), Soluong int)

create table DichVu(MaDV varchar(20) not null primary key, TenDV nvarchar(51) not null, Gia float not null, GhiChu nvarchar(100))

create table LoaiPhong(Loaiphong nvarchar(40) not null primary key, DonGia float, SoNguoi int default 1)

create table Phong(MaPhong varchar(20) not null primary key, Loaiphong nvarchar(40), TinhTrang bit default 0, TienDC float default 0, GhiChu nvarchar(100))

create table ThietBi(MaPhong varchar(20) not null primary key, TenThietBi nvarchar(40), Gia float, GhiChu nvarchar(100))

create table PhieuThue(MaPT varchar(20) not null primary key, MaKH varchar(20), MaNV varchar(20), MaPhong varchar(20), NgayLap date default getdate(),
NgayNhap date default getdate(), NgayTra date, TienDC float default 0, GhiChu nvarchar(100))

-- them khoa phu
Alter table Logon
add constraint FK_Logon_MaNV foreign key(MaNV) references NhanVien(MaNV) on delete cascade

Alter table PhieuThue
add constraint FK_PhieuThue_MaNV foreign key(MaNV) references NhanVien(MaNV) on delete cascade

Alter table PhieuThue
add constraint FK_PhieuThue_MaKH foreign key(MaKH) references KhachHang(MaKH) on delete cascade

Alter table PhieuThue
add constraint FK_PhieuThue_MaPhong foreign key(MaPhong) references Phong(MaPhong) on delete cascade

Alter table HoaDon
add constraint FK_HoaDon_MaPT foreign key(MaPT) references PhieuThue(MaPT) on delete cascade

Alter table HoaDonOfDichVu
add constraint FK_HoaDonOfDichVu_MaHD foreign key(MaHD) references HoaDon(MaHD) on delete cascade

Alter table HoaDonOfDichVu
add constraint FK_HoaDonOfDichVu_MaDV foreign key(MaDV) references DichVu(MaDV) on delete cascade

Alter table ThietBi
add constraint FK_ThietBi_MaPhong foreign key(MaPhong) references Phong(MaPhong) on delete cascade

Alter table Phong
add constraint FK_Phong_Loaiphong foreign key(Loaiphong) references LoaiPhong(Loaiphong) on delete cascade


select * from NhanVien

select * from logon
select * from PhieuThue
insert into logon 
values ('hue','hue')

select * from KhachHang
insert into KhachHang(MaKH,TenKH,Tuoi,DiaChi,Gioitinh,SDT,SoCMND,Quoctich)
values('KH002',N'Huế',22,N'Thái Bình',0,'012345677','123456789',N'Việt Nam')

select * from PhieuThue
select * from Phong
