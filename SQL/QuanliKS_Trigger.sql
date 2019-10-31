
select * from KhachHang
select * from Phong
select * from PhieuThue
select * from HoaDon


create trigger trg_add_hoadon
on dbo.PhieuThue
for insert
as
begin
	declare @LoaiPhong nvarchar(20), @DonGia float, @TenKH nvarchar(41), @MaPT varchar(20), @TongTien float;
	declare @MaPhong varchar(20), @MaKH varchar(20), @tienDC float;

	select @MaKH = MaKH from inserted
	select @MaPhong = MaPhong from inserted
	select @MaPT = MaPT from inserted
	select @tienDC = TienDC from inserted

	select @LoaiPhong = LoaiPhong from Phong where @MaPhong = MaPhong
	select @DonGia = DonGia from LoaiPhong where @LoaiPhong = Loaiphong
	select @TenKH = TenKH from KhachHang where @MaKH = MaKH
	set @TongTien = 0 + @DonGia - @tienDC;

	insert into dbo.HoaDon(MaPT, MaPhong, TenKH, GiaPhong, TongTien)
	values(@MaPT, @MaPhong, @TenKH, @DonGia, @TongTien)
end

drop trigger trg_add_hoadon

create trigger trg_update_hoadon
on HoaDonOfDichVu
for update
as
begin
	declare @MaHD varchar(20), @MaDV varchar(20), @Soluong int,
	@Gia float, @TienDV float, @TongTien float, @TienCu float, @GiaPhong int

	select @MaHD = MaHD from inserted
	select @MaDV = MaDV from inserted
	select @Soluong = Soluong from inserted
	select @Gia = Gia from DichVu where @MaDV = MaDV
	set @TienDV = @Gia * @Soluong
	
	select @GiaPhong = GiaPhong from HoaDon where @MaHD = MaHD
	select @TongTien = TongTien from HoaDon where @MaHD = MaHD

	set @TienCu = @TongTien - @GiaPhong
	set @TongTien = @GiaPhong + @TienDV - @TienCu

	update HoaDon
	set TongTien = @TongTien
	where MaHD = @MaHD
end

drop trigger trg_update_hoadon

create trigger trg_insert_HoaDonOfDichVu
on HoaDonOfDichVu
for insert
as
begin
	declare @MaHD varchar(20), @MaDV varchar(20), @Soluong int,
	@Gia float, @TienDV float

	select @MaHD = MaHD from inserted
	select @MaDV = MaDV from inserted
	select @Soluong = Soluong from inserted
	select @Gia = Gia from DichVu where @MaDV = MaDV
	set @TienDV = @Gia * @Soluong

	print @MaHD
	print @TienDV

	update HoaDon
	set TongTien = TongTien + @TienDV
	where @MaHD = MaHD
end

drop trigger trg_insert_HoaDonOfDichVu

select * from PhieuThue
select * from KhachHang
insert into PhieuThue (MaPT,MaKH,MaNV,MaPhong,NgayLap,NgayNhap,NgayTra,TienDC)
values ('PT002', 'KH002', 'hue', 'P001', getdate(), GETDATE(), '2018-11-30',100000)

create trigger trg_del_PhieuThue
on PhieuThue
for delete
as
begin
	declare @MaPhong varchar(20), @MaPT varchar(20)
	select @MaPhong = MaPhong from deleted
	select @MaPT = MaPT from deleted

	update Phong
	set TinhTrang = 0
	where @MaPhong = MaPhong
end

drop trigger trg_del_PhieuThue
select * from HoaDon
select * from HoaDonOfDichVu
insert into HoaDonOfDichVu
values('DV001', 28,2)
delete from HoaDonOfDichVu
where MaDV = 'DV001'
insert into HoaDonOfDichVu values ('DV001',3,28)