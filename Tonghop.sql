create database SS4Bai1;
use SS4Bai1;



create table class
(
    id        int auto_increment primary key,
    className varchar(100),
    startDate date,
    status    bit
);

create table student
(
    id          int primary key auto_increment,
    studentName varchar(100),
    address     varchar(255),
    phone       varchar(11),
    status      bit,
    class_id    int,
    foreign key (class_id) references class (id)

);


create table subject
(
    id          int primary key auto_increment,
    subjectName varchar(100),
    credit      int,
    status      bit

);
create table mark
(
    id         int primary key auto_increment,
    subject_id int,
    student_id int,
    point      double,
    examTime   datetime,
    foreign key mark (subject_id) references subject (id)
);


insert into subject(subjectName, credit, status)
values ('Toán học', 4, 1),
       ('Vật lý', 3, 1),
       ('Hóa học', 3, 1),
       ('Sinh học', 3, 1),
       ('Tiếng Anh', 2, 1),
       ('Ngữ văn', 3, 1),
       ('Lịch sử', 2, 1),
       ('Địa lý', 2, 1),
       ('Giáo dục công dân', 2, 1),
       ('Công nghệ', 2, 1),
       ('Tin học', 2, 1),
       ('Thể dục', 1, 1),
       ('Âm nhạc', 1, 1),
       ('Mỹ thuật', 1, 1),
       ('GDQP-AN', 2, 1);

insert into class (className, startDate, status)
values ('Lớp A', '2024-01-15', 1),
       ('Lớp B', '2024-02-10', 1),
       ('Lớp C', '2024-03-05', 1),
       ('Lớp D', '2024-01-20', 1),
       ('Lớp E', '2024-02-25', 1);

insert into student (studentName, address, phone, status, class_id)
values ('Nguyễn Văn A', '123 Đường ABC, Quận XYZ, Thành phố HCM', '0123456789', 1, 1),
       ('Trần Thị B', '456 Đường DEF, Quận UVW, Thành phố HCM', '0987654321', 1, 1),
       ('Lê Thanh C', '789 Đường GHI, Quận KLM, Thành phố HCM', '0369852147', 1, 2),
       ('Phạm Văn D', '123 Đường ABC, Quận XYZ, Thành phố HCM', '0753126498', 1, 2),
       ('Hoàng Thị E', '111 Đường MNO, Quận PQR, Thành phố HCM', '0925487163', 1, 3),
       ('Nguyễn Văn F', '222 Đường STU, Quận VWX, Thành phố HCM', '0847563921', 1, 3),
       ('Trần Thị G', '123 Đường ABC, Quận XYZ, Thành phố HCM', '0639852471', 1, 4),
       ('Lê Thị H', '444 Đường WXY, Quận OPQ, Thành phố HCM', '0974125368', 1, 4),
       ('Phạm Văn I', '555 Đường CBA, Quận NML, Thành phố HCM', '0369852147', 1, 5),
       ('Hoàng Văn K', '123 Đường ABC, Quận XYZ, Thành phố HCM', '0753126498', 1, 5);

alter table mark
    modify column id int auto_increment;

insert into mark (subject_id, student_id, point, examTime)
values (1, 1, 8.5, now()),
       (2, 3, 9.0, now()),
       (2, 4, 6.8, now()),
       (3, 5, 8.0, now()),
       (3, 6, 8.7, now()),
       (4, 7, 7.5, now()),
       (4, 8, 9.2, now()),
       (5, 9, 8.9, now()),
       (5, 10, 7.1, now());
insert into mark (subject_id, student_id, point, examTime)
values (1, 1, 5, now()),
       (2, 3, 5, now()),
       (2, 4, 5, now()),
       (3, 5, 5, now()),
       (3, 6, 5, now()),
       (4, 7, 5, now()),
       (4, 8, 5, now()),
       (5, 9, 5, now()),
       (5, 10, 7.1, now());
select *
from class;
select *
from subject;
select *
from mark;
select *
from student;


## Hiển thị số lượng sinh viên theo từng địa chỉ nơi ở.

select address, COUNT(id)
from student
group by address;

## Hiển thị các thông tin môn học có điểm thi lớn nhất.


select *
from subject
where subject.id = (select m.subject_id
                    from mark m
                    where m.point = (select max(m.point) from mark m));

## Tính điểm trung bình các môn học của từng học sinh.
##B1 : Mình phải in ra từng học sinh
select s.studentName, AVG(m.point)
from student s
         join mark m on m.student_id = s.id
group by m.student_id;

## Hiển thị những bạn học viên có điểm trung bình các môn học nhỏ hơn bằng 70.
select s.studentName, AVG(m.point)
from student s
         join mark m on m.student_id = s.id
group by m.student_id
having AVG(m.point) < 7;

## Hiển thị thông tin học viên có điểm trung bình các môn lớn nhất.

select s.*, AVG(m.point)
from student s
         join mark m on m.student_id = s.id
group by m.student_id
having AVG(m.point) >= all (select AVG(m.point)
                            from student s
                                     join mark m on m.student_id = s.id
                            group by m.student_id);


## Hiển thị các thông tin sinh viên và điểm trung bình của mỗi sinh viên, xếp hạng theo thứ tự điểm giảm dần
select student.studentName, AVG(m.point)
from student
         join mark m on student.id = m.student_id
group by student.id
order by AVG(m.point) desc;




