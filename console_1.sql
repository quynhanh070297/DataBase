create database tonghop1;
drop database tonghop1;
use tonghop1;
create table if not exists Department
(
    id   int primary key auto_increment,
    name varchar(100) not null unique check ( LENGTH(name) > 6 )
);
create table if not exists Levels
(
    id              int primary key auto_increment,
    name            varchar(100) not null unique,
    basicsalary     float        not null check ( basicsalary >= 3500000 ),
    allowanceSalary float default 500000
);
create table if not exists Employee
(
    id           int primary key auto_increment,
    name         varchar(150) not null,
    email        varchar(150) not null unique check (email REGEXP '^[^@]+@[^@]+\.[^@]{2,}$'),
    phone        varchar(50)  not null unique,
    address      varchar(255),
    gender       tinyint      not null check ( gender in (1,2,0)),
    birthday     date         not null,
    levelId      int          not null,
    departmentId int          not null,
    foreign key (levelId) references Levels (id),
    foreign key (departmentId) references Department (id)
);
create table if not exists Timesheet
(
    id            int primary key auto_increment,
    attendaceDate date  not null default (curdate()),
    employeeId    int   not null,
    value         float not null default 1 check ( value in (1,0.5,2)),
    foreign key (employeeId) references Employee (id)
);

create table if not exists Salary
(
    id          int auto_increment primary key,
    employeeId  int   not null,
    bonusSalary float          default 0,
    insurrance  float not null default 0,
    foreign key (employeeId) references Employee (id)
);

## Thêm dữ liệu vào bảng Department
insert into Department (name)
values ('Department 1'),
       ('Department 2'),
       ('Department 3'),
       ('Department 4'),
       ('Department 5');

## Thêm dữ liệu vào bảng Levels
insert into Levels (name, basicsalary)
values ('Level 1', 3500000),
       ('Level 2', 3700000),
       ('Level 3', 3900000),
       ('Level 4', 4100000),
       ('Level 5', 4300000);

## Thêm dữ liệu vào bảng Employee
insert into Employee (name, email, phone, address, gender, birthday, levelId, departmentId)
values ('Nguyễn Văn A', 'nguyenvana@example.com', '123456789', ' Quận XYZ, Thành phố HCM', 1,
        '1990-01-01', 1, 1),
       ('Trần Thị B', 'tranthib@example.com', '987654321', '456 Đường XYZ,  Thành phố HCM', 2, '1995-02-02', 2,
        2),
       ('Lê Văn C', 'levanc@example.com', '135792468', '789 Đường XYZ, Quận DEF, Thành phố HCM', 1, '1985-03-03', 3, 1),
       ('Phạm Thị D', 'phamthid@example.com', '246813579', '101 Đường XYZ, Quận ABC, Thành phố HCM', 2, '1988-04-04', 2,
        2),
       ('Vũ Văn E', 'vuvane@example.com', '369258147', '202 Đường XYZ, Quận DEF, Thành phố HCM', 1, '1993-05-05', 3, 1),
       ('Hoàng Thị F', 'hoangthif@example.com', '159263478', '303 Đường XYZ, Quận ABC, Thành phố HCM', 2, '1990-06-06',
        2, 2),
       ('Trần Văn G', 'tranvang@example.com', '753951846', '404 Đường XYZ, Quận DEF, Thành phố HCM', 1, '1987-07-07', 3,
        1),
       ('Nguyễn Thị H', 'nguyenthih@example.com', '852741963', '505 Đường XYZ, Quận ABC, Thành phố HCM', 2,
        '1992-08-08', 2, 2),
       ('Lê Văn I', 'levani@example.com', '987123654', '606 Đường XYZ, Quận DEF, Thành phố HCM', 1, '1989-09-09', 3, 1),
       ('Trần Thị K', 'tranthik@example.com', '654987321', '707 Đường XYZ, Quận ABC, Thành phố HCM', 2, '1994-10-10', 2,
        2),
       ('Nguyễn Văn L', 'nguyenvanl@example.com', '741852963', '808 Đường XYZ, Quận DEF, Thành phố HCM', 1,
        '1991-11-11', 3, 1),
       ('Hoàng Thị M', 'hoangthim@example.com', '852369147', '909 Đường XYZ, Quận ABC, Thành phố HCM', 2, '1986-12-12',
        2, 2),
       ('Vũ Văn N', 'vuvann@example.com', '369852147', '1010 Đường XYZ, Quận DEF, Thành phố HCM', 1, '1995-01-01', 3,
        1),
       ('Trần Thị P', 'tranthip@example.com', '123456987', '1111 Đường XYZ, Quận ABC, Thành phố HCM', 2, '1990-02-02',
        2, 2),
       ('Nguyễn Văn Q', 'nguyenvanq@example.com', '987654123', '1212 Đường XYZ, Quận DEF, Thành phố HCM', 1,
        '1988-03-03', 3, 1);
## Thêm dữ liệu vào bảng Timesheet
insert into Timesheet (attendaceDate, employeeId, value)
values ('2024-04-01', 1, 1),
       ('2024-04-01', 2, 1),
       ('2024-04-01', 3, 1),
       ('2024-04-02', 1, 1),
       ('2024-04-02', 2, 1),
       ('2024-04-02', 3, 1),
       ('2024-04-03', 1, 1),
       ('2024-04-03', 2, 1),
       ('2024-04-03', 3, 1),
       ('2024-04-04', 1, 1),
       ('2024-04-04', 2, 1),
       ('2024-04-04', 3, 1),
       ('2024-04-05', 1, 1),
       ('2024-04-05', 2, 1),
       ('2024-04-05', 3, 1),
       ('2024-04-06', 1, 1),
       ('2024-04-06', 2, 1),
       ('2024-04-06', 3, 1),
       ('2024-04-07', 1, 1),
       ('2024-04-07', 2, 1),
       ('2024-04-07', 3, 1),
       ('2024-04-01', 1, 1),
       ('2024-04-01', 2, 1),
       ('2024-04-01', 3, 1),
       ('2024-04-09', 1, 1),
       ('2024-04-09', 2, 1),
       ('2024-04-09', 3, 1),
       ('2024-04-10', 1, 1),
       ('2024-04-10', 2, 1),
       ('2024-04-10', 3, 1),
       ('2024-04-01', 3, 1),
       ('2024-04-09', 1, 1),
       ('2024-04-09', 2, 1),
       ('2024-04-09', 3, 1),
       ('2024-04-10', 1, 1),
       ('2024-04-10', 2, 1),
       ('2024-04-10', 3, 1);

delimiter //
## Khi thêm mớib thì phải tự động thêm mới 10% lương cơ bản
create trigger auto_create_insurrance
    before insert
    on Salary
    for each row
begin
    declare employeeSalary float;
    select l.basicsalary
    into employeeSalary
    from Levels l
             join Employee E on l.id = E.levelId
    where E.id = new.employeeId;
    set new.insurrance = employeeSalary / 10;
end;
//
delimiter ;

drop trigger auto_create_insurrance;
;
select *
from Salary;
insert into Salary (employeeId, bonusSalary)
values (1, 1000000),
       (2, 1200000),
       (3, 1500000),
       (4, 1000000),
       (5, 1200000),
       (6, 1500000),
       (7, 1200000),
       (8, 1500000),
       (9, 1200000);

drop table Salary;
#Lấy ra danh sách Employee có sắp xếp tăng dần theo Name gồm các cột sau:
# Id, Name, Email, Phone, Address, Gender, BirthDay, Age, DepartmentName, LevelName
select *
from Employee;
select e.id,
       e.name,
       e.email,
       e.phone,
       e.address,
       if(e.gender = 1, 'Nam', (if(e.gender = 0, 'LGBT', 'Nu'))),
       e.birthday,
       FLOOR(DATEDIFF(curdate(), e.birthday) / 365.25) as age,
       D.name,
       e.levelId
from Employee e
         join Department D on D.id = e.departmentId
         join Levels L on e.levelId = L.id
order by e.name;



#Lấy ra danh sách Salary gồm: Id, EmployeeName, Phone, Email,
# BaseSalary,  BasicSalary, AllowanceSalary, BonusSalary, insurrance, TotalSalary
select s.id,
       E.name,
       E.phone,
       E.email,
       L.basicsalary,
       L.allowanceSalary,
       s.bonusSalary,
       (L.basicsalary + L.allowanceSalary + s.bonusSalary - s.insurrance) as Tong
from Salary s
         join Employee E on E.id = s.employeeId
         join Levels L on L.id = E.levelId;




#Truy vấn danh sách Department gồm: Id, Name, TotalEmployee

    select d.id, d.name, count(e.id)  from Department d join Employee E on d.id = E.departmentId
    group by d.id;


#Cập nhật cột BonusSalary lên 10% cho tất cả các Nhân viên có số ngày
# công >= 20 ngày trong tháng 10 năm 2020

## Cập nhật cột BonusSalary lên 10% cho các nhân viên có số ngày công ít nhất là 20 ngày trong tháng 10 năm 2020

update Salary s
set s.bonusSalary = s.bonusSalary * 1.1 ## Cập nhật cột BonusSalary lên 10% bằng cách nhân với 1.1 (tương đương với việc thêm 10%)
where s.employeeId in (
    ## Lấy các employeeId từ bảng Timesheet trong tháng 10 năm 2020, những nhân viên có số ngày công lớn hơn 20.
    select t.employeeId
    from Timesheet t
    where YEAR(t.attendaceDate) = 2020
      AND MONTH(t.attendaceDate) = 10 ## Lọc ra các bản ghi trong tháng 10 năm 2020
    group by t.employeeId
    having COUNT(*) > 20 ## Chỉ lấy những nhân viên có số ngày công lớn hơn 20
);

#Truy vấn xóa Phòng ban chưa có nhân viên nào
delete
from Department D
where d.id not in (select distinct e.departmentId
                   from Employee e);

#Yêu cầu 2 ( Sử dụng lệnh SQL tạo View )

#View v_getEmployeeinfo thực hiện lấy ra danh sách Employee  gồm: Id, Name,
# Email, Phone, Address, Gender, BirthDay, DepartmentNamr, LevelName, Trong đó cột
# Gender hiển thị như sau:
#0 là nữ
#1 là nam


create view v_getEmployeeinfo as
select e.id,
       e.name,
       e.email,
       e.phone,
       e.address,
       case e.gender
           when 1 then 'Nam'
           when 0 then 'Nữ'
           else 'LGBT'
           end as Gender,
       e.birthday,
       d.name  as DepartmentName,
       l.name  as LevelName
from Employee e
         join Department d on e.departmentId = d.id
         join Levels l on e.levelId = l.id;



#View v_getEmployeeSalaryMax hiển thị danh sách nhân viên có số ngày công trong một
# tháng bất kỳ > 18 gòm: Id, Name, Email, Phone, Birthday, TotalDay (TotalDay là tổng
# số ngày công trong tháng đó)

create view v_getEmployeeSalaryMax as
select E.id, E.name, E.email, E.phone, E.birthday, SUM(T.value) as TotalDay
from Employee E
         join Timesheet T on E.id = T.employeeId
where month(T.attendaceDate) = 4
group by E.id, E.name, E.email, E.phone, E.birthday
having TotalDay > 3;



#Yêu cầu 3 ( Sử dụng lệnh SQL tạo thủ tục Stored Procedure )

#Thủ tục addEmployeetinfo thực hiện thêm mới nhân viên, khi gọi thủ tục truyền đầy
# đủ các giá trị của bảng Employee ( Trừ cột tự động tăng )

delimiter //

create procedure addEmployeetinfo(
    emp_name varchar(150),
    emp_email varchar(150),
    emp_phone varchar(50),
    emp_address varchar(255),
    emp_gender tinyint,
    emp_birthday date,
    emp_levelId int,
    emp_departmentId int
)
begin
    insert into Employee (name, email, phone, address, gender, birthday, levelId, departmentId)
    VALUES (emp_name, emp_email, emp_phone, emp_address, emp_gender, emp_birthday, emp_levelId, emp_departmentId);
end //

delimiter ;
call  addEmployeetinfo('Lê Văn C', 'levanc@example.com', '135792468',   '789 Đường XYZ,
Quận DEF,Thành phố HCM', 1, '1985-03-03', 3, 1);


#Thủ tục getSalaryByEmployeeId hiển thị danh sách các bảng lương từng nhân viên
# theo id của nhân viên gồm: Id, EmployeeName, Phone, Email, BaseSalary,  BasicSalary,
# AllowanceSalary, BonusSalary, insurrance, TotalDay, TotalSalary (trong đó TotalDay
# là tổng số ngày công, TotalSalary là tổng số lương thực lãnh)

delimiter //
create procedure getSalaryByEmployeeId(
    employeeId int
)
begin
    select s.id,
           E.name,
           E.phone,
           E.email,
           L.basicsalary,
           L.allowanceSalary,
           s.bonusSalary,
           (L.basicsalary + L.allowanceSalary + s.bonusSalary - s.insurrance)*sum(value)/24 as Tong
    from Salary s
             join Employee E on E.id = s.employeeId
             join Levels L on L.id = E.levelId
            join Timesheet T on E.id = T.employeeId
    where month( month(attendaceDate) = 4 and year(curdate()) = year(attendaceDate)
    group by s.id,attendaceDate );
end
// delimiter
    ;


#Khi gọi thủ tục truyền vào id của nhân viên
#Thủ tục getEmployeePaginate lấy ra danh sách nhân viên có phân trang gồm: Id, Name,
# Email, Phone, Address, Gender, BirthDay, Khi gọi thủ tuc truyền vào limit và page
#
#     create procedure getEmployeePaginate( page int , size int)
#     begin
#         declare off_set int;
#         set
#     end;

#Yêu cầu 4 ( Sử dụng lệnh SQL tạo Trigger )
#Tạo trigger tr_Check_ insurrance_value sao cho khi thêm hoặc sửa trên bảng Salary nếu
# cột insurrance có giá trị != 10% của BasicSalary thì không cho thêm mới hoặc chỉnh sửa
# và in thông báo Giá trị cảu insurrance phải = 10% của BasicSalary
 #   create trigger tr_Check_insurrance_value
#before insert on Salary
       #    for each row begin select Levels.basicsalary from Levels join Employee E on Levels.id = E.levelId
  #  where e.id = NEW.employeeId ;




#Tạo trigger tr_check_basic_salary khi thêm mới hoặc chỉnh sửa bảng Levels nếu giá trị
# cột BasicSalary > 10000000 thì tự động dưa về giá tri
