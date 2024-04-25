#Đề bài:
#Một khách sạn cần xây dựng cơ sở dữ liệu cho ứng dụng quán lý đặt phòng online
# gồm có các bảng như sau:
create database QLKS2;
use QLKS2;


create table if not exists Category
(
    id     int primary key auto_increment,
    name   varchar(100) not null unique,
    status tinyint default 1 check ( status in (0, 1) )
);

create table if not exists Room
(
    id          int primary key auto_increment,
    name        varchar(150) not null,
    status      tinyint default 1 check ( status in (0, 1)),
    price       float        not null check (price > 100000),
    sale_price  float   default 0,
    create_date date    default (curdate()),
    category_id int          not null,
    index (create_date, name, price)
);



create table if not exists Customer
(
    id          int primary key auto_increment,
    name        varchar(150) not null,
    email       varchar(150) not null,
    phone       varchar(50)  not null unique,
    address     varchar(255),
    gender      tinyint default 1 check ( Customer.gender in (0, 1)),
    create_date date    default (curdate()),
    birthday    date         not null
);

create table if not exists Booking
(
    id          int primary key auto_increment,
    customer_Id int not null,
    status      tinyint  default 1 check ( status in (0, 1, 2, 3) ),
    bookingdate datetime default (curdate())
);

create table if not exists Booking_detail
(
    Booking_id int,
    room_id    int,
    price      float    not null,
    start_date datetime not null,
    end_date   datetime not null
);

alter table Room
    add constraint KN_Room1
        foreign key (category_id) references Category (id);

alter table Booking_detail
    add constraint KN_booking
        foreign key (Booking_id) references Booking (id);

alter table Booking_detail
    add constraint KN_booking2
        foreign key (room_id) references Room (id);

alter table Booking
    add constraint KN_booking3
        foreign key (customer_Id) references Customer (id);

delimiter //

create trigger check_sale_price_before_insert_update
    before insert
    on Room
    for each row
begin
    if new.sale_price > new.price then
        signal sqlstate '45000'
            set message_text = 'Giá sale_price không được lớn hơn giá price';
    end if;
end //

delimiter ;


delimiter //

create trigger check_end_date_before_insert_update
    before insert
    on Booking_detail
    for each row
begin
    if new.end_date <= new.start_date then
        signal sqlstate '45000'
            set message_text = 'Ngày kết thúc phải lớn hơn ngày bắt đầu';
    end if;
end //

delimiter ;


# Bảng Category ít nhất là 5 bản ghi dữ liệu phù hợp
insert into Category (name)
    value ('Standard'),
    ('Deluxe'),
    ('Suite'),
    ('Penthouse'),
    ('Economy');


# Bảng Room Ít nhất 15 bản ghi dữ liệu phù hợp

## Dữ liệu mẫu cho bảng Phòng

## Dữ liệu mẫu cho bảng Phòng
insert into Room (name, status, price, category_id)
values ('Phòng Standard 101', 1, 200000, 1),
       ('Phòng Deluxe 201', 1, 350000, 2),
       ('Suite 301', 1, 500000, 3),
       ('Phòng Đặc biệt 401', 1, 800000, 4),
       ('Phòng Tiết kiệm 501', 1, 150000, 5);

# Bảng Customer ít nhất 3 bản ghi dữ liệu phù hợp

## Dữ liệu mẫu cho bảng Khách hàng
insert into Customer (name, email, phone, address, gender, birthday)
values ('Nguyễn Văn A', 'nguyenvana@example.com', '0123456789', '123 Đường ABC, Quận XYZ, TP.HCM', 1, '1990-12-29'),
       ('Trần Thị B', 'tranthib@example.com', '0987654321', '456 Đường XYZ, Quận ABC, Hà Nội', 0, '1985-12-29'),
       ('Lê Văn C', 'levanc@example.com', '0369876543', '789 Đường MNO, Quận DEF, Đà Nẵng', 1, '1988-12-29');

# Bảng Booking ít nhất 3 bản ghi dữ liệu phù hợp, mỗi hóa đơn đặt ít nhất 2 phòng khác nhau
## Dữ liệu mẫu cho bảng Đặt phòng
insert into Booking (customer_Id, status, bookingdate)
values (1, 1, '2024-04-25 10:00:00'),
       (2, 1, '2024-04-26 11:00:00'),
       (3, 1, '2024-04-27 12:00:00');
select *
from Booking;

## Chèn dữ liệu cho các chi tiết đặt phòng (Booking_detail)
## Hóa đơn 1: Đặt phòng cho khách hàng 1
insert into Booking_detail (Booking_id, room_id, price, start_date, end_date)
values (1, 1, 150000, '2024-05-01', '2024-05-03'),
       (1, 2, 250000, '2024-05-01', '2024-05-03');

## Hóa đơn 2: Đặt phòng cho khách hàng 2
insert into Booking_detail (Booking_id, room_id, price, start_date, end_date)
values (2, 3, 400000, '2024-05-02', '2024-05-04'),
       (2, 4, 800000, '2024-05-02', '2024-05-04');

## Hóa đơn 3: Đặt phòng cho khách hàng 3
insert into Booking_detail (Booking_id, room_id, price, start_date, end_date)
values (3, 3, 100000, '2024-05-03', '2024-05-05'),
       (3, 4, 100000, '2024-05-03', '2024-05-05');

# Yêu cầu truy vấn dữ liệu
# Yêu cầu 1 ( Sử dụng lệnh SQL để truy vấn cơ bản ):
# Lấy ra danh phòng có sắp xếp giảm dần theo Price gồm các cột sau: Id, Name, Price, SalePrice, Status, CategoryName, CreatedDate

select *
from Room;

select r.Id, r.Name, r.Price, r.sale_price, r.status, C.name, r.create_date
from Room r
         join Category C on r.category_id = C.id
order by r.price desc;

# Lấy ra danh sách Category gồm: Id, Name, TotalRoom, Status (Trong đó cột Status nếu = 0, Ẩn, = 1 là Hiển thị )

select *
from Category;
select c.Id, c.Name, count(r.id), if(c.status = 0, 'An', 'Hien')
from Category c
         join Room R on c.id = R.category_id
group by c.Id;

# Truy vấn danh sách Customer gồm: Id, Name, Email, Phone, Address, CreatedDate, Gender, BirthDay, Age (Age là cột suy ra từ BirthDay, Gender nếu = 0 là Nam, 1 là Nữ,2 là khác )
select c.Id,
       c.Name,
       c.Email,
       c.Phone,
       c.Address,
       c.create_date,
       if(gender = 1, 'Nam', if(gender = 2, 'Nu', 'Khac')),
       BirthDay,
       year(curdate()) - year(birthday)
from Customer c;
# Truy vấn xóa các sản phẩm chưa được bán
delete
from Room
where id not in (select distinct Booking_detail.room_id
                 from Booking_detail);

# Cập nhật Cột SalePrice tăng thêm 10% cho tất cả các phòng có Price >= 250000
update Room
set sale_price = price * 1.1
where price >= 250000;

# Yêu cầu 2 ( Sử dụng lệnh SQL tạo View )
# View v_getRoominfo Lấy ra danh sách của 10 phòng có giá cao nhất
create view v_getRoominfo as
select *
from Room
order by price desc
limit 10;

# View v_getBookingList hiển thị danh sách phiếu đặt hàng gồm: Id, BookingDate, Status, CusName, Email, Phone,TotalAmount
# ( Trong đó cột Status nếu = 0 Chưa duyệt, = 1  Đã duyệt, = 2 Đã thanh toán, = 3 Đã hủy )
create view v_getBookingList as
select B.id                         as Id,
       B.bookingdate                as BookingDate,
       case
           when B.status = 0 then 'Chưa duyệt'
           when B.status = 1 then 'Đã duyệt'
           when B.status = 2 then 'Đã thanh toán'
           when B.status = 3 then 'Đã hủy'
           else 'Trạng thái không xác định'
           end                      as Status,
       C.name                       as CusName,
       C.email                      as Email,
       C.phone                      as Phone,
       (select SUM(BD.price)
        from Booking_detail BD
        where BD.Booking_id = B.id) as TotalAmount
from Booking B
         join Customer C on B.customer_Id = C.id;

# Yêu cầu 3 ( Sử dụng lệnh SQL tạo thủ tục Stored Procedure )
# Thủ tục addRoominfo thực hiện thêm mới Room, khi gọi thủ tục truyền đầy đủ các giá trị của bảng Room ( Trừ cột tự động tăng )
delimiter //

create procedure addRoominfo(
    in p_name varchar(150),
    in p_status tinyint,
    in p_price float,
    in p_category_id int
)
begin
    insert into Room (name, status, price, category_id)
    values (p_name, p_status, p_price, p_category_id);
end //

delimiter ;

# Thủ tục getBookingByCustomerId hiển thị danh sách phieus đặt phòng của khách hàng theo Id khách hàng gồm:
# Id, BookingDate, Status, TotalAmount (Trong đó cột Status nếu = 0 Chưa duyệt, = 1  Đã duyệt,, = 2 Đã thanh toán, = 3 Đã hủy),
# Khi gọi thủ tục truyền vào id cảu khách hàng
delimiter //

create procedure getBookingByCustomerId(
    in p_customer_id int
)
begin
    select B.id          as Id,
           B.bookingdate as BookingDate,
           CasE
               when B.status = 0 then 'Chưa duyệt'
               when B.status = 1 then 'Đã duyệt'
               when B.status = 2 then 'Đã thanh toán'
               when B.status = 3 then 'Đã hủy'
               ELSE 'Trạng thái không xác định'
               end       as Status,
           SUM(BD.price) as TotalAmount
    from Booking B
             join Booking_detail BD on B.id = BD.Booking_id
    where B.customer_Id = p_customer_id
    group by B.id;
end //

delimiter ;

# Thủ tục getRoomPaginate lấy ra danh sách phòng có phân trang gồm: Id, Name, Price, SalePrice,
# Khi gọi thủ tuc truyền vào limit và page
delimiter //
create procedure getRoomPaginate2(
    in page_in int
)
begin
    select * from Room limit page_in ,5;
end //
delimiter //


# create procedure getRoomPaginate(
#     in p_limit int,
#     in p_page int
# )
# begin
#     declare offset_val int default 0;
#     set offset_val = (p_page - 1) * p_limit;
#
#     select id, name, price, sale_price
#     from Room
#     order by id
#     limit p_limit OFFset offset_val;
# end
//
#
# delimiter ;

# Yêu cầu 4 ( Sử dụng lệnh SQL tạo Trigger )
# Tạo trigger tr_Check_Price_Value sao cho khi thêm hoặc sửa phòng Room nếu nếu giá trị của
# cột Price > 5000000 thì tự động chuyển về 5000000 và in ra thông báo ‘Giá phòng lớn nhất 5 triệu’

delimiter //
create trigger tr_Check_Price_Value
    before insert
    on Room
    for each row
    begin
        if NEW.price > 5000000 then
            set  NEW.price = 5000000 ;
        end if;
    end //
delimiter //

delimiter //
create trigger tr_Check_Price_Value
    before update
    on Room
    for each row
begin
    if NEW.price > 5000000 then
        set  NEW.price = 5000000 ;
    end if;
end //
delimiter //

# Tạo trigger tr_check_Room_NotAllow khi thực hiện đặt pòng, nếu ngày đến (StartDate) và ngày
# đi (endDate) của đơn hiện tại mà phòng đã có người đặt rồi thì báo lỗi “Phòng này đã có người
# đặt trong thời gian này, vui lòng chọn thời gian khác”

delimiter //
create trigger tr_check_Room_NotAllow
    before insert
    on Booking_detail
    for each row
begin
    if
        (NEW.start_date >= any (select d.start_date  from Booking_detail d join Room R on d.room_id = R.id where NEW.room_id = d.room_id) and
       NEW.start_date <= any (select d.end_date  from Booking_detail d join Room R on d.room_id = R.id where NEW.room_id = d.room_id))or
     (  NEW.end_date <= any (select d.end_date from Booking_detail d join Room R on d.room_id = R.id where NEW.room_id = d.room_id) and
       NEW.end_date >= any (select d.start_date from Booking_detail d join Room R on d.room_id = R.id where NEW.room_id = d.room_id) )
    then signal sqlstate  '45000'set message_text = 'Toang roi cu';
    end if;
end //
delimiter //

select * from Booking_detail;