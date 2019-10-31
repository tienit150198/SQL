/* foreign key:
syntax: Constraint FK_name foreign key Cno references Account(Cno)

*/
Create proc SP_ADD_Tran(@ID char(5), @ACCNO char(5), @WithDraw money) AS
begin
	-- check ID exists in Transactions or not
	if exists (select * from Transactions where @ID = ID)
	print 'ID already exists'
	
	else
	begin
		--check ACCNO not exists 
		if not exists (select * from Account where ACCNO = @ACCNO)
		print 'ACCNO does not exists'
		else
		begin
			Declare @Balances money
			select @Balances = Balances from Account where ACCNO = @ACCNO

			if @Balances - 50 < @WithDraw
			print 'Withdraw must be less than Balances and left over 50$'
			else
			begin
				INSERT INTO Transactions(ID,ACCNO,Time_Tran,WithDraw)
				VALUES (@ID, @ACCNO, getdate(), @WithDraw)

				-- update balances in Account
				UPDATE Account
				SET Balances = Balances - @WithDraw
				WHERE ACCNO = @ACCNO
			end
		end
	end
end
-- call: SP_ADD_Tran 'ID005', 'ACC05', '20'

select * from Account
select * from Transactions

-- drop: DROP proc SP_ADD_Tran
GO
create proc SP_ADD_Transfer (@ACCNO_Transfers char(5), @ACCNO_Receives char(5), @Amount money) AS
begin
	
	if not exists (select * from Account where @ACCNO_Transfers = ACCNO)
	print 'ACCNO Transfers does not exists'
	else
	begin
		if not exists (select * from Account where @ACCNO_Receives = ACCNO)
		print 'ACCNO Receives does not exists'
		else
		begin
			Declare @Balances money
			Declare @Service_charge float = 0.2

			select @Balances = Balances from Account where @ACCNO_Transfers = ACCNO
			-- 0.2 is service charge
			if (@Balances - 50.2 < @Amount)
				print 'Amount must be less than Balances and left over 50$'
			else
			begin
				insert into Account_Transfer(ACCNO_Transfers,ACCNO_Receives,Amount, Service_charge,Day_trading, ANote)
				values (@ACCNO_Transfers,@ACCNO_Receives,@Amount,@Service_charge, getdate(), 'transaction successful')
				--update balances of account transfer and receives
				UPDATE Account
				SET Balances = CASE
				WHEN ACCNO = @ACCNO_Transfers then Balances - @Service_charge - @Amount
				WHEN ACCNO = @ACCNO_Receives then Balances + @Amount
				else Balances end
			end
		end
	end
end
 

select * from Account
select * from Account_Transfer

truncate table Account_Transfer

SP_ADD_Transfer 'ACC03', 'ACC05', 250

DROP proc SP_ADD_Transfer

ALTER TABLE Account_Transfer
ADD Service_charge smallmoney


select * from Account_Transfer
/*
ALTER TABLE Account_Transfer
ADD Day_trading date default getdate()

ALTER TABLE Account_Transfer
ADD ANote varchar(50)

ALTER TABLE Account_Transfer
ALTER COLUMN ANote varchar(100)

ALTER TABLE Account_Transfer
ALTER COLUMN Service_charge smallmoney not null*/