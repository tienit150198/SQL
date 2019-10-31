USE hotelDB
GO


-- create Room clone
SELECT * INTO RoomClone FROM Room

-- create view Room clone
CREATE VIEW [Room clone] AS
SELECT * FROM Room 

-- update Unitprice in View. Increase Unit price all room Except type 'A'

UPDATE [Room clone]
SET Unitprice = Unitprice * 1.2
WHERE Rtype <> 'A'

---
UPDATE [Room clone]
SET Unitprice = Unitprice * 1.2
WHERE Rtype in
(
	SELECT Rtype FROM [Room clone]
	Except
	(SELECT Rtype FROM [Room clone] WHERE Rtype = 'A')
)

-- Decrease unit price 2 room has the highest price
UPDATE Room
SET Unitprice = Unitprice * 0.8
WHERE Rtype in (SELECT TOP 2 Rtype FROM Room ORDER BY Unitprice DESC)

-- Tính số ngày ở : sử dụng datediff + if else hoặc case - when
DECLARE @Ngayo
SELECT Ono, Rno,
	Case
	When (datediff(day,datecheckIn,datecheckOut) = 0) then 1
	else datediff(day,datecheckIn,datecheckOut) end AS N'Ngày ở'
FROM Orders
-----
UPDATE Orders
SET Staynumber = Case
WHEN (datediff(day,datecheckIn,datecheckOut) = 0) then 1
ELSE datediff(day,datecheckIn,datecheckOut) end

-- Tính chiết khấu: tương tự tính số ngày ở
-- Thông tin khách quốc tịch nước ngoài sắp xếp ngày sinh giảm dần
SELECT * FROM Customer
WHERE Country <> 'VietNam'
ORDER BY DAY(Dateofbirth) DESC

-- Lấy thông tin khách đến nước nào theo từng quốc tịch
SELECT Country, COUNT(*) AS N'Số lượng' FROM Customer
GROUP BY Country
-- Lấy thông tin nước nào có 4 người trở lên
SELECT Country, COUNT(*) AS N'Số lượng' FROM Customer
GROUP BY Country
HAVING COUNT(*) >= 4
-- Thông tin gồm mã phòng, số lần thuê, tổng số ngày thuê
SELECT OD.Rno,COUNT(*) AS N'Số lần', SUM(Staynumber) AS N'Tổng ngày', AVG(Staynumber) as N'Số ngày thuê tb'
FROM Orders AS OD
WHERE YEAR(datecheckOut) = '2018'
GROUP BY OD.Rno

-- ngày sinh không trùng với ai khác
SELECT * FROM Customer
Except
SELECT CMT1.* FROM Customer AS CMT1, Customer AS CMT2
WHERE DAY(CMT1.Dateofbirth) = DAY(CMT2.Dateofbirth) AND CMT1.Cno <> CMT2.Cno

-- tên khách, quốc tịch, loại phòng, ngày đến, ngày đi trong tháng 9 năm 2018
SELECT CTM.Cname, CTM.Country, R.Rtype ,OD.datecheckIn, OD.datecheckOut FROM Orders AS OD, Room AS R, Customer AS CTM
WHERE OD.Rno = R.Rno AND OD.Cno = CTM.Cno AND MONTH(OD.datecheckIn) = '9' AND YEAR(OD.datecheckIn) = '2018'

-- Phòng hay mã phòng chưa được thuê trong 2018
SELECT * FROM Room
Except
SELECT R.* FROM Orders as OD, Room as R
WHERE OD.Rno = R.Rno AND YEAR(OD.datecheckIN) = '2018'


SELECT * FROM Room

SELECT month(datecheckIn) FROM Orders
SELECT * FROM Customer
-- tính stay number
SELECT * FROM Orders
UPDATE Orders
SET Staynumber = Case
WHEN (datediff(day,datecheckIn,datecheckOut) = 0) then 1
ELSE datediff(day,datecheckIn,datecheckOut) end
-- tính tiền total
UPDATE Orders
SET Total = Staynumber * Unitprice - (Staynumber * Unitprice * Discount)
FROM Orders inner join Room ON Orders.Rno = Room.Rno
-- tính chiết khấu
UPDATE Orders
SET Discount = Case
WHEN datediff(day,datecheckIn,datecheckOut) > 10 then 0.2
WHEN datediff(day,datecheckIn,datecheckOut) >= 7 then 0.15
WHEN datediff(day,datecheckIn,datecheckOut) >= 4 then 0.1
ELSE 0
END

SELECT * FROM Orders