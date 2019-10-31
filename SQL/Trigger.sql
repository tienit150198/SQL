select * from Transactions
select * from Account
select * from Customers
GO
-- Trigger ------------
create trigger checkTrans_Update ON dbo.Transactions AFTER UPDATE
AS
BEGIN
	print 'update Transaction'
END
go
create trigger checkTrans_Insert ON dbo.Transactions AFTER INSERT
AS
BEGIN
	print 'insert Transaction'
END
go
create trigger checkTrans_Delete ON dbo.Transactions AFTER DELETE
AS
BEGIN
	print 'delete Transaction'
END



SP_ADD_Tran 'ID001', 'ACC05', '20'

select * from Transactions
UPDATE Transactions
set WithDraw = 500
where ID = 'ID001'

delete Transactions

go
---------------------------------------------------
/*create database SinhVien
go
use SinhVien
go
create table Info(
	id int identity not null primary key,
	name varchar(31) not null,
	age int not null,
	isAction bit default 0
)

go
select * from Info
go
insert into Info(name,age)
values('Tran Tien', 18)
go

---create trigger
create trigger checkInfo_update after update
as
begin
	print 'update info'
	update Info
	set isAction = 1
	where 
end*/