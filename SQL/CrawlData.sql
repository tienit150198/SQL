create database CrawlData;
use CrawlData;
go;

create table DATA(URL nvarchar(200) primary key not null, source nvarchar(100), title nvarchar(200), type nvarchar(100), post_time nvarchar(100), crawl_time date default getdate(), description nvarchar(max), content nvarchar(max), tags nvarchar(max), author nvarchar(100), link_image nvarchar(max), caption_image nvarchar(max));
go;

-- get data ----------------------
create proc DT_GetAll_URL as
begin
	select URL from DATA;
end
go;

create proc DT_GetAll_SOURCE as
begin
	select source from DATA;
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

create proc DT_GetData_InDay(@Day nvarchar(10)) as
begin
	select * from DATA where day(crawl_time) = @Day;
end
go;

create proc DT_GetData_InMonth(@Month nvarchar(10)) as
begin
	select * from DATA where month(crawl_time) = @Month;
end
go;

create proc DT_GetData_InYear(@Year nvarchar(10)) as
begin
	select * from DATA where year(crawl_time) = @Year;
end
go;

create proc DT_GetData_InDate(@Date date) as
begin
	select * from DATA where crawl_time = @Date;
end
go;
DT_GetData_InDate '2019/01/04' -- 04/04/2019

go;
create proc DT_Get_URL(@source nvarchar(100)) as
begin
	if not exists (select * from DATA where @source = source)
		print 'source not exists';
	else
		select URL from DATA where @source = source;
end
go;

create proc DT_Get_TITLE(@source nvarchar(100)) as
begin
	if not exists (select * from DATA where @source = source)
		print 'source not exists';
	else
		select title from DATA where @source = source;
end
go;

create proc DT_Get_AUTHOR(@source nvarchar(100)) as
begin
	if not exists (select * from DATA where @source = source)
		print 'source not exists';
	else
		select author from DATA where @source = source;
end
go;

create proc DT_Get_DESCRIPTION(@source nvarchar(100)) as
begin
	if not exists (select * from DATA where @source = source)
		print 'source not exists';
	else
		select description from DATA where @source = source;
end
go;

create proc DT_Get_CONTENT(@source nvarchar(100)) as
begin
	if not exists (select * from DATA where @source = source)
		print 'source not exists';
	else
		select description from DATA where @source = source;
end
go;

create proc DT_Get_POSTIME(@source nvarchar(100)) as
begin
	if not exists (select * from DATA where @source = source)
		print 'source not exists';
	else
		select post_time from DATA where @source = source;
end

-- setter -----------------------------------------
create proc DT_Set_URL(@source nvarchar(100), @URL nvarchar(200)) as
begin
	if not exists (select * from DATA where @source = source)
		print 'source not exists';
	else
		update DATA set URL = @URL where @source = source;
end
go;

create proc DT_Set_AUTHOR(@source nvarchar(100), @author nvarchar(100)) as
begin
	if not exists (select * from DATA where @source = source)
		print 'source not exists';
	else
		update DATA set author = @author where @source = source;
end
go;

create proc DT_Set_TITLE(@source nvarchar(100), @title varchar(200)) as
begin
	if not exists (select * from DATA where @source = source)
		print 'source not exists';
	else
		update DATA set title = @title where @source = source;
end
go;
-- tags nvarchar(max)
create proc DT_Set_TAG(@source nvarchar(100), @tags nvarchar(max)) as
begin
	if not exists (select * from DATA where @source = source)
		print 'source not exists';
	else
		update DATA set tags = @tags where @source = source;
end
go;

create proc DT_Add(@URL nvarchar(200) , @source nvarchar(100), @title nvarchar(200), @type nvarchar(100), @post_time nvarchar(100), @description nvarchar(max), @content nvarchar(max), @tags nvarchar(max), @author nvarchar(100), @link_image nvarchar(max), @caption_image nvarchar(max)) as
begin
	if exists (select * from DATA where @URL = URL)
		print 'URL not exists';
	else
		begin
			insert into DATA(URL, source, title, type, post_time, crawl_time, description, content, tags, author, link_image, caption_image)
			values (@URL, @source, @title, @type, @post_time, getdate(), @description, @content, @tags, @author, @link_image, @caption_image)
		end
end

select count(*) from DATA
select * from DATA
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
