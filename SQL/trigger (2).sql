--Best SQL interview Questions  (top 50)
--Trigger --------------------------------------------------------
-- kiểm soát tính toàn vẹn, đảm bảo liệu không bị thất thoát
/*
syntax to create a trigger
CREATE TRIGGER <trg_name> 
ON <tables>
FOR <Update | Delete | Insert>
AS
Begin
	SQL statements
End

--
Two logical table:
Inserted table
Deleted table
*/
create trigger tr_Account_Update 
ON Accounts
for Update 
as
begin
	--Show Delected table
	select * from Deleted
	--Show Inserted table
	select * from inserted
end
drop trigger tr_Account_Update



Update Accounts
set Balances += 1000
where ACCNO = 'ACC01'
go

select * from Account
----
go
Create Trigger tr_transaction_insert
ON Transactions
for Insert
as
begin
	update Accounts
	set Accounts.Balances = Accounts.Balances - inserted.Withdraw
	from Accounts inner join inserted ON Accounts.ACCNO = inserted.ACCNO
end

drop trigger tr_transaction_insert

Insert into Transactions
values('ID004','ACC01', getdate(), 100)

select * from Accounts
select * from Customers
select * from Transactions

delete from Accounts
where ACCNO = 'ACC01'
alter table Transactions
drop constraint FK_ACCNO 
alter table Transactions
drop column 

-- khi xoa 1 tai khoan thi se xoa tat ca cac giao dich tren tai khoan do
create trigger tr_Account_Delete
ON Accounts
FOR Delete
as
begin
	delete from Transactions
	where Transactions.ACCNO IN (select deleted.ACCNO from deleted)
end
drop trigger tr_Account_Delete

select * from Transactions