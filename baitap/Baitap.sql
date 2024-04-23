create schema homeWork;
use homeWork;

create table customer ( 
cID int primary key auto_increment , cName varchar(30),cAge int 
);
create table `order` ( 
oID int primary key auto_increment,cID int,  oDate date,oTotalPrice int,
constraint lien_ket_1 foreign key (cID) references customer(cID)
);
create table product ( 
pID int primary key auto_increment,  pName varchar(30) ,pPrice int
);
 create table orderDetail ( 
oID int ,
pID int ,
odQTY float,
constraint lien_ket_2 foreign key (oID) references `order`(oID),
constraint lien_ket_3 foreign key (pID) references `product`(pID)
);

select *  from customer;
select *  from `order`;
select *  from `orderDetail`;
select *  from `product`;
insert into customer (cName,cAge) values
 ('Hoang Quynh',31), 
('Hoang Anh',31), 
('Hoang Quynh Anh',31), 
('Quynh Anh',31), 
('Hoang ',31), 
(' Anh',31);
insert into `order` (cID,oDate,oTotalPrice) values 
(1,'2022-12-29',2000),
(2,'2022-12-29',2000),
(1,'2022-12-29',2000),
(1,'2022-12-29',2000),
(1,'2022-12-29',2000);
insert into product  (pName ,pPrice) values 
('Ao',20),
('Ao',20),
('Ao',20),
('Ao',20),
('Ao',20)
;
insert into orderDetail(oID,pID,odQTY) values 
(1,1,20),
(1,1,20),
(1,1,20),
(1,1,20),
(1,1,20),
(1,1,20);



