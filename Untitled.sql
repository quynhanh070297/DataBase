create table KHACHHANG ( 
MaKH char(4) primary key,
 TenKH varchar(30),
 Diachi varchar(30),
 Ngaysinh date,
 SoDT varchar(15)
);

create table NHANVIEN ( 
MaNV char(4) primary key,
 HoTen varchar(30),
 GioiTinh bit,
 Diachi varchar(30),
 DienThoai varchar(15),
 Email text,
 NoiSinh varchar(20),
 NgayVaoLam date,
 MaNQL char(4)
);

create table NHACUNGCAP ( 
 MaNCC char(5) primary key,
 TenNCC varchar(30),
 Diachi varchar(30),
 DienThoai varchar(15),
 Email varchar(30),
 Website varchar(30)
);

create table LOAISP ( 
 MaloaiSP char(4) primary key,
 TenloaiSP varchar(30),
 Ghichu varchar(30)
 );
 
 create table SANPHAM ( 
 MasP char(4) primary key,
 MaloaiSP char(4),
 TenloaiSP varchar(30),
 Donvitinh varchar(10),
 Ghichu varchar(100)
 );
 
 
 create table PHIEUNHAP ( 
 SoPN char(5),
 MaNV char(4),
 MaNCC char(5),
 Ngaynhap date,
 Ghichu varchar(100)
 );
 
 create table CTPHIEUNHAP ( 
 SoPN char(5) ,
 MaNV char(4) ,
 Soluong smallint,
 Ghichu real
 );
 
 create table PHIEUXUAT ( 
 SoPX char(5),
 MaNV char(4),
 MaKH char(4),
 NgayBan date,
 Ghichu text
 );
 
 create table CTPHIEUXUAT ( 
 SoPX char(5) ,
 MasP char(4) ,
 Soluong smallint,
 GiaBan real
 );
  alter table PHIEUNHAP
add constraint FK_PhieuNhap_NV foreign key (MaNV) references NHANVIEN(MaNV),
add constraint FK_PhieuNhap_NCC foreign key (MaNCC) references NHACUNGCAP(MaNCC);

 alter table CTPHIEUNHAPz
add constraint FK_CTPN_PhieuNhap foreign key (SoPN) references PHIEUNHAP(SoPN),
add constraint FK_CTPN_NV foreign key (MaNV) references NHANVIEN(MaNV);

 alter table PHIEUXUAT
add constraint FK_PhieuXuat_NV foreign key (MaNV) references NHANVIEN(MaNV),
add constraint FK_PhieuXuat_KH foreign key (MaKH) references KHACHHANG(MaKH);

 alter table CTPHIEUXUAT
add constraint FK_CTPX_PhieuXuat foreign key (SoPX) references PHIEUXUAT(SoPX),
add constraint FK_CTPX_SP foreign key (MasP) references SANPHAM(MasP);

## Thêm dữ liệu vào bảng PHIEUNHAP
## Thêm phiếu nhập 1
insert into PHIEUNHAP (SoPN, MaNV, MaNCC, Ngaynhap, Ghichu)
values ('PN001', 'NV001', 'NCC001', GETDATE(), 'ghi chu 1');

## Thêm phiếu nhập 2
insert into PHIEUNHAP (SoPN, MaNV, MaNCC, Ngaynhap, Ghichu)
values ('PN002', 'NV002', 'NCC002', GETDATE(), 'ghi chu 2');

## Thêm dữ liệu vào bảng CTPHIEUNHAP
## Thêm sản phẩm cho phiếu nhập 1
insert into CTPHIEUNHAP (SoPN, MaNV, Soluong, Ghichu)
values ('PN001', 'NV001', 10, 'Ghi chú cho sản phẩm 1 của phiếu nhập 1'),
       ('PN001', 'NV001', 15, 'Ghi chú cho sản phẩm 2 của phiếu nhập 1');

## Thêm sản phẩm cho phiếu nhập 2
insert into CTPHIEUNHAP (SoPN, MaNV, Soluong, Ghichu)
values ('PN002', 'NV002', 20, 'Ghi chú'),
       ('PN002', 'NV002', 25, 'Ghi chú');


 ## Thêm dữ liệu vào bảng PHIEUXUAT
## Thêm phiếu xuất 1
insert into PHIEUXUAT (SoPX, MaNV, MaKH, NgayBan, Ghichu)
values ('PX001', 'NV003', 'KH001', GETDATE(), 'Ghi chú 1');

## Thêm phiếu xuất 2
insert into PHIEUXUAT (SoPX, MaNV, MaKH, NgayBan, Ghichu)
values ('PX002', 'NV004', 'KH002', GETDATE(), 'Ghi chú cho2');

## Thêm dữ liệu vào bảng CTPHIEUXUAT
## Thêm sản phẩm cho phiếu xuất 1
insert into CTPHIEUXUAT (SoPX, MasP, Soluong, GiaBan)
values ('PX001', 'SP001', 5, 100000),  ## Sản phẩm 1
       ('PX001', 'SP002', 7, 150000),  ## Sản phẩm 2
       ('PX001', 'SP003', 8, 200000);  ## Sản phẩm 3

## Thêm sản phẩm cho phiếu xuất 2
insert into CTPHIEUXUAT (SoPX, MasP, Soluong, GiaBan)
values ('PX002', 'SP004', 10, 250000),  ## Sản phẩm 1
       ('PX002', 'SP005', 12, 300000),  ## Sản phẩm 2
       ('PX002', 'SP006', 15, 350000);  ## Sản phẩm 3

insert into NHANVIEN (MaNV, HoTen, GioiTinh, Diachi, DienThoai, Email, NoiSinh, NgayVaoLam, MaNQL)
values ('NV005', 'Nguyen Van Nam', 1, '123 Đường ABC', '0123456789', 'nam@example.com', 'Hà Nội', GETDATE(), 'NV001');

update KHACHHANG
set SoDT = '0987654321' ## Số điện thoại mới
where MaKH = 'KH10';


update NHANVIEN
set Diachi = '456 Đường XYZ' ## Địa chỉ mới
where MaNV = 'NV05';

delete from NHANVIEN
where MaNV = 'NV05';

delete from SANPHAM
where MasP = 'SP15';

## Bai 6
select PHIEUXUAT.SoPX, NHANVIEN.HoTen as TenNV, PHIEUXUAT.NgayBan,
       CTPHIEUXUAT.MasP, SANPHAM.TenSP, SANPHAM.DonViTinh,
       CTPHIEUXUAT.Soluong, CTPHIEUXUAT.GiaBan,
       CTPHIEUXUAT.Soluong * CTPHIEUXUAT.GiaBan as DoanhThu
from PHIEUXUAT
join NHANVIEN on PHIEUXUAT.MaNV = NHANVIEN.MaNV
join CTPHIEUXUAT on PHIEUXUAT.SoPX = CTPHIEUXUAT.SoPX
join SANPHAM on CTPHIEUXUAT.MasP = SANPHAM.MasP
where PHIEUXUAT.NgayBan between '2018-04-15' AND '2018-05-15';

## bai7
select PHIEUXUAT.SoPX, PHIEUXUAT.NgayBan, PHIEUXUAT.MaKH, KHACHHANG.TenKH,
       SUM(CTPHIEUXUAT.Soluong * CTPHIEUXUAT.GiaBan) as TriGia
from PHIEUXUAT
join KHACHHANG on PHIEUXUAT.MaKH = KHACHHANG.MaKH
join CTPHIEUXUAT on PHIEUXUAT.SoPX = CTPHIEUXUAT.SoPX
group by PHIEUXUAT.SoPX, PHIEUXUAT.NgayBan, PHIEUXUAT.MaKH, KHACHHANG.TenKH;

## bai 8
select SUM(Soluong) ## Tính tổng số lượng sản phẩm và đặt tên cột kết quả là TongSoLuong
from CTPHIEUXUAT ## Từ bảng chi tiết phiếu xuất
join SANPHAM on CTPHIEUXUAT.MasP = SANPHAM.MasP ## Kết nối với bảng sản phẩm dựa trên mã sản phẩm
join PHIEUXUAT on CTPHIEUXUAT.SoPX = PHIEUXUAT.SoPX ## Kết nối với bảng phiếu xuất dựa trên số phiếu xuất
where SANPHAM.TenSP = 'Nước xả vải Comfort' ## Chỉ lấy thông tin của sản phẩm
AND YEAR(PHIEUXUAT.NgayBan) = 2018 ## Chỉ lấy dữ liệu từ năm 2018
AND MonTH(PHIEUXUAT.NgayBan) <= 6; ## Chỉ lấy dữ liệu từ 6 tháng đầu tiên của năm 2018

select 
    MonTH(PHIEUXUAT.NgayBan) as Thang,
    PHIEUXUAT.MaKH,
    KHACHHANG.TenKH,
    KHACHHANG.Diachi,
    SUM(CTPHIEUXUAT.Soluong * CTPHIEUXUAT.GiaBan) as TongTien
from PHIEUXUAT
join KHACHHANG on PHIEUXUAT.MaKH = KHACHHANG.MaKH
join CTPHIEUXUAT on PHIEUXUAT.SoPX = CTPHIEUXUAT.SoPX
group by MonTH(PHIEUXUAT.NgayBan), PHIEUXUAT.MaKH, KHACHHANG.TenKH, KHACHHANG.Diachi
order by Thang, PHIEUXUAT.MaKH;
## Cau12
select 
    YEAR(PHIEUXUAT.NgayBan) as Nam,
    MonTH(PHIEUXUAT.NgayBan) as Thang,
    SANPHAM.MasP,
    SANPHAM.TenloaiSP as TenSP,
    SANPHAM.Donvitinh,
    SUM(CTPHIEUXUAT.Soluong) as TongSoLuong
from PHIEUXUAT
join CTPHIEUXUAT on PHIEUXUAT.SoPX = CTPHIEUXUAT.SoPX
join SANPHAM on CTPHIEUXUAT.MasP = SANPHAM.MasP
group by YEAR(PHIEUXUAT.NgayBan), MonTH(PHIEUXUAT.NgayBan), SANPHAM.MasP, SANPHAM.TenloaiSP, SANPHAM.Donvitinh
order by Nam, Thang, SANPHAM.MasP;

select 
    NHANVIEN.MaNV,
    NHANVIEN.HoTen as HoTenNV,
    SANPHAM.MasP,
    SANPHAM.TenloaiSP as TenSP,
    SANPHAM.Donvitinh,
    SUM(CTPHIEUXUAT.Soluong) as TongSoLuong
from NHANVIEN
join PHIEUXUAT on NHANVIEN.MaNV = PHIEUXUAT.MaNV
join CTPHIEUXUAT on PHIEUXUAT.SoPX = CTPHIEUXUAT.SoPX
join SANPHAM on CTPHIEUXUAT.MasP = SANPHAM.MasP
group by NHANVIEN.MaNV, NHANVIEN.HoTen, SANPHAM.MasP, SANPHAM.TenloaiSP, SANPHAM.Donvitinh
order by NHANVIEN.MaNV, SANPHAM.MasP;

#. Liệt kê các sản phẩm chưa bán được trong 6 tháng đầu năm 2018, thông tin
#gồm: mã sản phẩm, tên sản phẩm, loại sản phẩm, đơn vị tính.
select 
    SANPHAM.MasP,
    SANPHAM.TenloaiSP as TenSP,
    SANPHAM.Donvitinh
from 
    SANPHAM
left join 
    CTPHIEUXUAT on SANPHAM.MasP = CTPHIEUXUAT.MasP
left join 
    PHIEUXUAT on CTPHIEUXUAT.SoPX = PHIEUXUAT.SoPX
where 
    YEAR(PHIEUXUAT.NgayBan) = 2018 AND MonTH(PHIEUXUAT.NgayBan) <= 6
    AND PHIEUXUAT.SoPX IS NULL;


#Liệt kê danh sách nhà cung cấp không giao dịch mua bán với cửa hàng trong
#quý 2/2018, gồm thông tin: mã nhà cung cấp, tên nhà cung cấp, địa chỉ, số
#điện thoại.

select 
    NHACUNGCAP.MaNCC,
    NHACUNGCAP.TenNCC,
    NHACUNGCAP.Diachi,
    NHACUNGCAP.DienThoai
from 
    NHACUNGCAP
left join 
    PHIEUNHAP on NHACUNGCAP.MaNCC = PHIEUNHAP.MaNCC
where 
    YEAR(PHIEUNHAP.Ngaynhap) = 2018 AND MonTH(PHIEUNHAP.Ngaynhap) between 4 AND 6
    AND PHIEUNHAP.SoPN IS NULL;


 
 