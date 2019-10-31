create database CrawlData;
use CrawlData;
go;

create table DATA(id int identity primary key not null, URL nvarchar(300) not null unique, title nvarchar(300), type nvarchar(100), post_time date, crawl_time date default getdate(), description nvarchar(max), content nvarchar(max), tags nvarchar(max), author nvarchar(100), image nvarchar(max));
go;
----------------- get in day

create proc DT_Get_UrlAndId_inday as
begin
	select id, url from data where day(post_time) = day(getdate()) and month(post_time) = month(getdate()) and year(post_time) = year(getdate())
end


go;

create proc DT_Get_IdAndTag_inday as
begin
	select id, tags from data where day(post_time) = day(getdate()) and month(post_time) = month(getdate()) and year(post_time) = year(getdate())
end

go;
create proc DT_Get_UrlAndTag_inday as
begin
	select url, tags, post_time from data where day(post_time) = day(getdate()) and month(post_time) = month(getdate()) and year(post_time) = year(getdate())
end
go

DT_Get_UrlAndTag_inday

create proc DT_Get_IdAndUrlAndTag_inday as
begin
	select id,url, tags from data where day(post_time) = day(getdate())
end
go;
create proc DT_Get_AllFromUrl_inday (@url nvarchar(300)) as
begin
	select * from data where url = @url order by post_time
end
go;
create proc DT_Get_AllFromId_inday(@id nvarchar(300)) as
begin
	select * from data where id = @id order by post_time
end

-- end get in day ---

---------- start get in week

create proc DT_Get_UrlAndId_inweek as
begin
	select id, url,post_time from data where (datepart(week, post_time)) = (datepart(week, getdate()))
end

go;

create proc DT_Get_IdAndTag_inweek as
begin
	select id, tags from data where (datepart(week, post_time)) = (datepart(week, getdate()))
end

go;
create proc DT_Get_UrlAndTag_inweek as
begin
	select url, tags from data where (datepart(week, post_time)) = (datepart(week, getdate()))
end
go

create proc DT_Get_IdAndUrlAndTag_inweek as
begin
	select id,url, tags from data where (datepart(week, post_time)) = (datepart(week, getdate()))
end
go;
---------- end get in week ---------

---------- start get in week

create proc DT_Get_UrlAndId_inmonth as
begin
	select id, url from data where month(post_time) = month(getdate()) and year(post_time) = year(getdate())
end

go;

create proc DT_Get_IdAndTag_inmonth as
begin
	select id, tags from data where month(post_time) = month(getdate())  and year(post_time) = year(getdate())
end

go;
create proc DT_Get_UrlAndTag_inmonth as
begin
	select url, tags from data where month(post_time) = month(getdate()) and year(post_time) = year(getdate())
end
go

create proc DT_Get_IdAndUrlAndTag_inmonth as
begin
	select id,url, tags from data where month(post_time) = month(getdate()) and year(post_time) = year(getdate())
end
go;
---------- end get in week ---------


-------------------------------------

create proc DT_Get_UrlAndId as
begin
	select id, url from data order by post_time
end
go;

create proc DT_Get_IdAndTag as
begin
	select id, tags from data order by post_time
end

go;
create proc DT_Get_UrlAndTag as
begin
	select url, tags from data order by post_time
end
go

create proc DT_Get_IdAndUrlAndTag as
begin
	select id,url, tags from data order by post_time
end
go;
create proc DT_Get_AllFromUrl(@url nvarchar(300)) as
begin
	select * from data where url = @url order by post_time
end

DT_Get_AllFromUrl 'https://dantri.com.vn/the-thao/brighton-14-man-city-thay-tro-guardiola-vo-dich-premier-league-20190512205552024.htm'

create proc DT_Get_AllFromId(@id nvarchar(300)) as
begin
	select * from data where id = @id order by post_time
end

	
-- get data use id ---------------
create proc DT_Get_URL (@id int) as
begin
	select URL from DATA where @id = id;
end

create proc DT_Get_Tags (@id int) as
begin
	select tags from DATA where @id = id;
end

create proc DT_Get_Title (@id int) as
begin
	select title from DATA where @id = id;
end

create proc DT_Get_Description (@id int) as
begin
	select description from DATA where @id = id;
end

create proc DT_Get_Content (@id int) as
begin
	select content from DATA where @id = id;
end

create proc DT_Get_Image (@id int) as
begin
	select image from DATA where @id = id;
end

-- get data ----------------------
create proc DT_GetAll_URL as
begin
	select URL from DATA;
end
go;

create proc DT_GetAll_PostTime as
begin
	select post_time from DATA;
end
go;

create proc DT_GetAll_CrawlTime as
begin
	select crawl_time from DATA;
end
go;

create proc DT_GetAll_TAG as
begin
	select tags from DATA;
end
go;

create proc DT_GetAll_TITLE as
begin
	select title from DATA;
end
go;

create proc DT_GetAll_DESCRIPTION as
begin
	select description from DATA;
end

create proc DT_GetAll_CONTENT as
begin
	select content from DATA;
end
go;

create proc DT_GetAll_TYPE as
begin
	select type from DATA;
end
go;

create proc DT_GetAll_AUTHOR as
begin
	select author from DATA;
end
go;

create proc DT_GetAll_Data as
begin
	select * from DATA;
end
go;

create proc DT_GetData_Use_URL(@URL nvarchar(100)) as
begin
	if not exists (select * from DATA where @URL = URL)
		print 'URL not exists';
	else
		select * from DATA where @URL = URL;
end
go;
DT_GetData_Use_URL 'abc'
go;

create proc DT_GetData_Use_Source(@source nvarchar(100)) as
begin
	if not exists (select * from DATA where @source = source)
		print 'source not exists';
	else
		select * from DATA where @source = source;
end
go;

create proc DT_GetData_InDayPost(@Day nvarchar(10)) as
begin
	select * from DATA where day(post_time) = @Day;
end
go;

create proc DT_GetData_InMonthPost(@Month nvarchar(10)) as
begin
	select * from DATA where month(post_time) = @Month;
end
go;

create proc DT_GetData_InYearPost(@Year nvarchar(10)) as
begin
	select * from DATA where year(post_time) = @Year;
end
go;

create proc DT_GetData_InDatePost(@Date date) as
begin
	select * from DATA where post_time = @Date;
end
go;
-----

create proc DT_GetData_InDayCrawl(@Day nvarchar(10)) as
begin
	select * from DATA where day(crawl_time) = @Day;
end
go;

create proc DT_GetData_InMonthCrawl(@Month nvarchar(10)) as
begin
	select * from DATA where month(crawl_time) = @Month;
end
go;

create proc DT_GetData_InYearCrawl(@Year nvarchar(10)) as
begin
	select * from DATA where year(crawl_time) = @Year;
end
go;

create proc DT_GetData_InDateCrawl(@Date date) as
begin
	select * from DATA where crawl_time = @Date;
end
go;
DT_GetData_InDate '2019/01/04' -- 04/04/2019

go;
create proc DT_Get_UrlInPostTime(@post_time Date) as
begin
	if not exists (select * from DATA where @post_time = post_time)
		print 'source not exists';
	else
		select URL from DATA where @post_time = post_time;
end
go;

create proc DT_Get_TitleInURL(@URL nvarchar(300)) as
begin
	if not exists (select * from DATA where @URL = URL)
		print 'source not exists';
	else
		select title from DATA where @URL = URL;
end
go;

create proc DT_Get_AuthorInURL(@URL nvarchar(300)) as
begin
	if not exists (select * from DATA where @URL = URL)
		print 'source not exists';
	else
		select author from DATA where @URL = URL;
end
go;

create proc DT_Get_TagsInPostTime(@post_time date) as
begin
	if not exists (select * from DATA where @post_time = post_time)
		print 'source not exists';
	else
		select post_time from DATA where @post_time = post_time;
end
go;
create proc DT_Get_AllTags as
begin
	select tags from DATA
end
go;
DT_Get_AllTags;
go;

-- setter -----------------------------------------
create proc DT_Set_URL(@id int, @URL nvarchar(200)) as
begin
	if not exists (select * from DATA where @id = @id)
		print 'source not exists';
	else
		update DATA set URL = @URL where @id = @id;
end
go;

create proc DT_Set_AUTHOR(@id int, @author nvarchar(100)) as
begin
	if not exists (select * from DATA where @id = @id)
		print 'source not exists';
	else
		update DATA set author = @author where @id = @id;
end
go;

create proc DT_Set_TITLE(@id int, @title varchar(200)) as
begin
	if not exists (select * from DATA where @id = @id)
		print 'source not exists';
	else
		update DATA set title = @title where @id = @id;
end
go;
-- tags nvarchar(max)
create proc DT_Set_TAG(@id int, @tags nvarchar(max)) as
begin
	if not exists (select * from DATA where @id = @id)
		print 'source not exists';
	else
		update DATA set tags = @tags where @id = @id;
end
go;

create proc DT_Add(@URL nvarchar(300) , @title nvarchar(300), @type nvarchar(100), @post_time date, @description nvarchar(max), @content nvarchar(max), @tags nvarchar(max), @author nvarchar(100), @image nvarchar(max)) as
begin
	if exists (select * from DATA where @URL = URL)
		print 'URL not exists';
	else
		begin
			insert into DATA(URL, title, type, post_time, crawl_time, description, content, tags, author, image)
			values (@URL, @title, @type, @post_time, getdate(), @description, @content, @tags, @author, @image)
		end
end

select count(*) from DATA
select * from DATA
select top 100 * from DATA order by post_time asc
truncate table DATA
DT_Add N'https://news.zing.vn/nu-sinh-hung-yen-bi-danh-hoi-dong-da-on-dinh-tam-ly-muon-quay-lai-hoc-post931621.html', N'Zing.vn', N'Nữ sinh Hưng Yên bị đánh hội đồng đã ổn định tâm lý, muốn quay lại học - Giáo dục - ZING.VN', N'Giáo dục', N'20:26 01/04/2019', N'Sau gần 5 ngày điều trị, sức khỏe, tâm lý của em N.T.H.Y. đã ổn định. Nữ sinh Hưng Yên mong muốn sớm được xuất viện, trở lại đi học bình thường.', N'Trao đổi với Zing.vn tối 1/4, bác sĩ Trương Thị Huyền - người trực tiếp điều trị cho nữ sinh bị lột đồ, đánh hội đồng tại Bệnh viện Tâm thần kinh Hưng Yên - cho biết chiều nay, bệnh nhân được khám lại, làm các test về tâm lý lo âu, trầm cảm.
Bác sĩ thông tin tình hình của H.Y. tiến triển tốt, tâm lý ổn định bình thường, có thể xuất viện. Sáng nay, khi bạn học đến xin lỗi, biểu hiện của Y. rất thoải mái.
Trong ngày, em ăn, ngủ tốt, cùng bà nội cùng đi mua đồ ăn và chủ động xin ra viện để về đi học. Bác sĩ Huyền lưu ý vì H.Y. đang trong độ tuổi phát triển nên gia đình, nhà trường cần tạo môi trường tốt, kết hợp liệu pháp tâm lý đơn giản như thường xuyên động viên để đảm bảo sức khỏe tinh thần cho Y.
"Nếu bệnh nhân có dấu hiệu bất thường, gia đình cần đưa em đến bệnh viện tái khám", bác sĩ Huyền cho biết.
Trước đó, ngày 28/5, N.T.H.Y. nhập viện với biểu hiện hoảng loạn, mặt sưng tím nhiều chỗ. Bác sĩ chẩn đoán em phản ứng stress cấp, có sang chấn về mặt tâm lý tinh thần. Y. chủ yếu điều trị bằng thuốc uống, thuốc bổ não và các loại vitamin nhóm B.
Trong khi đó, công an tỉnh Hưng Yên phối hợp công an huyện Ân Thi tiếp tục điều tra, làm rõ vụ bạo hành xảy ra ngày 22/3 tại trường THCS Phù Ủng khiến N.T.H.Y. bị thương nặng về thể xác và tinh thần. 5 học sinh đánh Y. cũng kết thúc thời gian kỷ luật đình chỉ một tuần và đi học trở lại.
Trước đó, UBND huyện Ân Thi đã họp, quyết định tạm dừng công tác điều hành đối với hiệu trưởng THCS Phù Ủng - Nhữ Mạnh Phong - và giáo viên chủ nhiệm lớp 9A của trường để tập trung làm rõ vụ việc.
Trong buổi làm việc với Bộ trưởng GD&ĐT Phùng Xuân Nhạ hôm 31/3, Chủ tịch UBND tỉnh Hưng Yên, ông Nguyễn Văn Phóng, cho biết sẽ xem xét làm quy trình cách chức toàn bộ Ban giám hiệu, Chi uỷ, Tổng phụ trách đội, kỷ luật Hội đồng kỷ luật nhà trường vì có dấu hiệu bao che.
Đối với giáo viên chủ nhiệm, lãnh đạo tỉnh cho biết sẽ xử lý bằng hình thức nặng hơn vì không nắm được tâm tư, nguyện vọng, diễn biến tâm lý học sinh.', N'nữ sinh hưng yên bị đánh hội đồng, nữ sinh bị đánh hội đồng ở hưng yên, nữ sinh bị đánh hội đồng, nữ sinh bị lột quần áo, bạo lực học đường', N'Nguyễn Sương', N'https://znews-photo.zadn.vn/w660/Uploaded/zbvunua/2019_04_01/3_2.jpg', N'Bộ trưởng Phùng Xuân Nhạ thăm hỏi, động viên nữ sinh N.T.H.Y. tại Bệnh viện Tâm thần kinh Hưng Yên. Ảnh: N.S.'
