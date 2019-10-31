create database CheckSkill

create table Jobs(JobNo varchar(5) not null primary key, Skill varchar(20) not null, Req_num int)
create table Emps(Eno varchar(5) not null primary key, Ename varchar(20), Skill varchar(20), Salary int, Gender bit default 0)

select * from Jobs
select * from Emps
order by Skill
go

-- lấy các kĩ năng và tổng lương của các kĩ năng đó trong Emps
select count(*), Skill, sum(salary) as 'Sum' from Emps
group by Skill

-- lấy danh sách skill của Emps và Jobs trùng nhau
select * from Emps join Jobs on
Emps.skill = Jobs.skill
select * from Emps
-- lấy thông tin nhân viên có cùng kĩ năng với nhau trong Emps
select distinct E1.* from Emps as E1, Emps as E2
where E1.Eno <> E2.Eno AND E1.Skill = E2.Skill

select distinct E1.* from Emps as E1 inner join Emps as E2
on E1.Skill = E2.Skill and e1.Eno != e2.eno

-- lấy thông tin nhân viên nhân viên không trùng kĩ năng với bất cứ ai
select * from Emps
Except
select distinct E1.* from Emps as E1, Emps as E2
where E1.Eno <> E2.Eno AND E1.Skill = E2.Skill

insert into Jobs
values ('J01', 'Java', 10), ('J02', 'SQL', 8), ('J03', 'Python', 3), ('J04', 'CSS', 4)

insert into Emps
values ('E001', 'Nam', 'SQL', 1440, 1), ('E002', 'Hoa', 'Java', 1080, 0), ('E003', 'Nga', 'SQL', 1200, 0), 
('E004', 'Chuc', 'SQL', 1500, 1), ('E005', 'Khoa', 'Java', 1200, 1), ('E006', 'Ngoc', 'Python', 1400, 0), 
('E007', 'Thai', 'C#', 14400, 1), ('E008', 'Nguyet', 'R', 1100, 0)

select Skill, count(Skill) as 'Emp_num' from Emps
group by Skill
union
(select 'abc',Count(Skill) as 'Total_Sal' from Emps)

select count(*), Skill, sum(salary) as 'Sum' from Emps
group by Skill
union

select top 3 ename, skill from Emps
union 
select top 3 ename, skill from Emps

select * from emps
intersect
select top 3 * from emps

select * from emps as e1
where eno in (select top 3 eno from emps)