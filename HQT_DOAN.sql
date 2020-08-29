CREATE TABLE TAIKHOAN
(
    TENTK CHAR(5) NOT NULL PRIMARY KEY,
    MATKHAU NVARCHAR2(20),
    LOAITK NVARCHAR2(20)
);
CREATE TABLE DOCGIA
(
	MADOCGIA CHAR(5) PRIMARY KEY NOT NULL,
	TEN NVARCHAR2(40),
	NGAYSINH DATE,
	SDT CHAR(10),
	DIACHI NVARCHAR2(30),
	LOP INT,
	DOITUONG NVARCHAR2(30),
    GIOITINH NVARCHAR2(3),
    EMAIL VARCHAR(30)
)
ALTER TABLE DOCGIA ADD CONSTRAINT CK_DOITUONGDOC CHECK(DOITUONG='Hoc sinh' OR DOITUONG='Giao vien');
ALTER TABLE DOCGIA ADD CONSTRAINT FK_DOCGIA_TK FOREIGN KEY(MADOCGIA) REFERENCES TAIKHOAN(TENTK);

CREATE TABLE THETHUVIEN 
(
	MATHE CHAR(5) PRIMARY KEY NOT NULL,
	NGAYBD DATE, 
	NGAYHETHAN DATE, 
	GHICHU NVARCHAR2(50)
);

alter table THETHUVIEN add constraints FK_THETHUVIEN_MATHE FOREIGN key(MATHE) references DOCGIA(MADOCGIA);
alter table THETHUVIEN add constraint FK_THETV_DOCGIA foreign key (MADOCGIA) references DOCGIA(MADOCGIA) on delete CASCADE;
    
CREATE TABLE NHANVIEN
(
	MANHANVIEN CHAR(5) PRIMARY KEY NOT NULL,
	HOTEN NVARCHAR2(30),
	NGAYSINH DATE,
	SDT CHAR(10),
    email varchar2(30),
    gioitinh nvarchar2(3),
    chucvu nvarchar2(10) not null,
    DIACHI NVARCHAR2(40)
)

--ALTER TABLE NHANVIEN DROP COLUMN TINHTRANG;
ALTER TABLE NHANVIEN ADD CONSTRAINT FK_NHANVIEN_TK FOREIGN KEY(MANHANVIEN) REFERENCES TAIKHOAN(TENTK);

CREATE TABLE NHAXUATBAN 
(
	MANXB CHAR(5) PRIMARY KEY NOT NULL,
	TENNXB NVARCHAR2(30),
    DIACHI NVARCHAR2(40),
    SDT VARCHAR2(10)
)

create TABLE PHIEUNHAPSACH
(
	MANHAP CHAR(5) NOT NULL,
	TENSACH NVARCHAR2(50),
	SL INT,
	DONGGIA NUMBER,
	NGAYGIAO DATE,
	MANHANVIEN CHAR(5) NULL,
	MANXB CHAR(5) NOT NULL
)
ALTER TABLE PHIEUNHAPSACH ADD CONSTRAINT PK_PHIEUNHAPSACH PRIMARY KEY (MANHAP);
ALTER TABLE PHIEUNHAPSACH ADD CONSTRAINT FK_NHAPSACH_NXB FOREIGN KEY (MANXB) REFERENCES NHAXUATBAN(MANXB);
ALTER TABLE PHIEUNHAPSACH ADD CONSTRAINT FK_NHAPSACH_NHANVIEN FOREIGN KEY(MANHANVIEN) REFERENCES NHANVIEN(MANHANVIEN);

CREATE TABLE SACH
(
	MASACH CHAR(7) PRIMARY KEY NOT NULL,
	MANXB char(5) NOT NULL,
	TENSACH NVARCHAR2(50),
	TACGIA NVARCHAR2(30),
	NAMXB NUMBER,
	TRANGTHAI NVARCHAR2(15),
    NGONNGU VARCHAR2(20),
    MANHAP CHAR(5) NOT NULL,
    THELOAI NVARCHAR2(30),
    TAIBAN NVARCHAR2(10)
)
ALTER TABLE SACH ADD CONSTRAINT FK_SACH_NHAP FOREIGN KEY(MANHAP) REFERENCES PHIEUNHAPSACH(MANHAP);
alter table SACH add constraint FK_SACH_NXB foreign key(MANXB) references NHAXUATBAN(MANXB);

--alter table THETHUVIEN add constraint FK_THETV_DOCGIA foreign key (MADOCGIA) references DOCGIA(MADOCGIA) on delete CASCADE;

CREATE TABLE PHIEUMUON
(
    MAPHIEUMUON CHAR(5) NOT NULL,
	MASACH CHAR(7) NOT NULL,
	MADOCGIA CHAR(5) NOT NULL,
	NGAYMUON DATE
)
ALTER TABLE PHIEUMUON ADD NGAYHETHAN DATE;
ALTER TABLE PHIEUMUON ADD CONSTRAINT PHIEUMUON_PK PRIMARY KEY(MAPHIEUMUON,MASACH);
ALTER TABLE PHIEUMUON ADD CONSTRAINT FK_PM_SACH FOREIGN KEY (MASACH) REFERENCES SACH(MASACH);
ALTER TABLE PHIEUMUON ADD CONSTRAINT FK_PM_DOCGIA FOREIGN KEY (MADOCGIA) REFERENCES DOCGIA(MADOCGIA);

CREATE TABLE QTMUON 
(
	MASACH CHAR(7) NOT NULL,
	NGAYMUON DATE NOT NULL,
	MADOCGIA CHAR(5) NOT NULL,
	NGAYHETHAN DATE,
	NGAYTRA DATE,
    GHICHU VARCHAR(30),
    TRANGTHAI NVARCHAR2(10)
)
ALTER TABLE QTMUON ADD 
	CONSTRAINT QTMUON_PK PRIMARY KEY(MASACH,NGAYMUON);
	ALTER TABLE QTMUON ADD CONSTRAINT FK_QTM_SACH FOREIGN KEY (MASACH) REFERENCES SACH(MASACH);
	ALTER TABLE QTMUON ADD CONSTRAINT FK_QTM_DOCGIA FOREIGN KEY (MADOCGIA) REFERENCES DOCGIA(MADOCGIA);

CREATE TABLE PHIEUPHAT
(
	MAPHIEUPHAT CHAR(5) NOT NULL PRIMARY KEY ,
	MADOCGIA CHAR(5) NOT NULL,
	MANHANVIEN CHAR(5) NULL,
	MASACH CHAR(7) NOT NULL,
	TIENPHAT NUMBER,
    NGAYTRA_pp DATE,
    NGAYHETHAN_pp DATE
)
ALTER TABLE PHIEUPHAT ADD 
	CONSTRAINT FK_PP_DOCGIA FOREIGN KEY (MADOCGIA) REFERENCES DOCGIA(MADOCGIA);
ALTER TABLE PHIEUPHAT ADD CONSTRAINT FK_PP_NHANVIEN FOREIGN KEY (MANHANVIEN) REFERENCES NHANVIEN(MANHANVIEN);
ALTER TABLE PHIEUPHAT ADD CONSTRAINT FK_PP_SACH FOREIGN KEY (MASACH) REFERENCES SACH(MASACH);

CREATE TABLE BAOCAO
(
	
	MABAOCAO CHAR(5) NOT NULL PRIMARY KEY,
	MANHANVIEN CHAR(5) NULL,
	NGAYBC DATE, 
	NOIDUNG NVARCHAR2(100),
	TOMTAT NVARCHAR2(50),
    TONGTIENPHAT NUMBER,
    SOSACHMUON NUMBER
)

ALTER TABLE BAOCAO ADD 
	CONSTRAINT FK_BC_NHANVIEN FOREIGN KEY (MANHANVIEN) REFERENCES NHANVIEN(MANHANVIEN);

insert into TAIKHOAN values('DG001','123','doc gia');
insert into TAIKHOAN values('DG002','123','doc gia');
insert into TAIKHOAN values('DG003','123','doc gia');
insert into TAIKHOAN values('DG004','123','doc gia');
insert into TAIKHOAN values('DG005','123','doc gia');
insert into TAIKHOAN values('DG007','123','doc gia');
insert into TAIKHOAN values('DG008','123','doc gia');
insert into TAIKHOAN values ('TT001','123','thu thu');
insert into TAIKHOAN values ('TT002','123','thu thu');
insert into TAIKHOAN values ('TT003','123','thu thu');
insert into TAIKHOAN values ('TT004','123','thu thu');
insert into TAIKHOAN values ('TT005','123','thu thu');
select * from TAIKHOAN

insert into DOCGIA values('DG001','Le A',TO_DATE('3/4/2001','dd/MM/yyyy'),'0111111111','01,Duong Le Loi',10,'Hoc sinh','nam','email');
insert into DOCGIA values('DG002','Le C',to_date('12/2/2002','dd/mm/yyyy'),'0121111111','02,Duong Le Loi',11,'Hoc sinh','nu','email');
insert into DOCGIA values('DG003','Le B',to_date('11/4/2003','dd/mm/yyyy'),'0131111111','03,Duong Le Loi',12,'Hoc sinh','nu','email');
insert into DOCGIA values('DG004','Le D',to_date('10/7/1978','dd/mm/yyyy'),'0141111111','04,Duong Le Loi',NULL,'Giao vien','nam','email');
insert into DOCGIA values('DG005','Le V',to_date('3/8/2001','dd/mm/yyyy'),'0151111111','05,Duong Le Loi',10,'Hoc sinh','nu','email');
insert into DOCGIA values('DG006','Le V',to_date('3/8/2001','dd/mm/yyyy'),'0151111111','05,Duong Le Loi',null,'Giao vien','nam','email');
insert into DOCGIA values('DG007','Le V',to_date('3/8/2001','dd/mm/yyyy'),'0151111111','05,Duong Le Loi',null,'Giao vien','nam','email');
insert into DOCGIA values('DG008','Le V',to_date('3/8/2001','dd/mm/yyyy'),'0151111111','05,Duong Le Loi',null,'Giao vien','nam','email');
select * from DOCGIA;



insert into NHANVIEN values ('TT001','Vu A',to_date('12/12/1980','dd/mm/yyyy'),'0161111111','mail1@gmail.com','nam','thu thu','a');
insert into NHANVIEN values ('TT002','Vu B',to_date('11/12/1980','dd/mm/yyyy'),'0171111111','mail2@gmail.com','nam','thu thu','b');
insert into NHANVIEN values ('TT003','Vu C',to_date('12/10/1980','dd/mm/yyyy'),'0181111111','mail3@gmail.com','nam','admin','c');
insert into NHANVIEN values ('TT004','Vu D',to_date('12/11/1980','dd/mm/yyyy'),'0191111111','mail4@gmail.com','nam','thu thu','d');
insert into NHANVIEN values ('TT005','Vu E',to_date('21/3/1979','dd/mm/yyyy'),'053222222','mail1@5mail.com','nam','thu thu','e');
select * from NHANVIEN


insert into NHAXUATBAN values('CC001','Cong ty sach Kien Giang','a','1111111111');
insert into NHAXUATBAN values('CC002','Cong ty sach My Linh','a','1111111111');
insert into NHAXUATBAN values('CC003','Cong ty sach Thao Nguyen','a','1111111111');
insert into NHAXUATBAN values('CC004','Cong ty sach Kim Thao','a','1111111111');
insert into NHAXUATBAN values('CC005','Cong ty sach Kim Dong','a','1111111111');
select * from NHAXUATBAN

INSERT INTO PHIEUNHAPSACH VALUES('N0001','Nu kiet Tong Khanh Linh',15,200000,'1/2/2019','TT001','CC001');
INSERT INTO PHIEUNHAPSACH VALUES('N0002','Tu Hy Thai Hau',30,550000,'1/4/2019','TT002','CC002');
INSERT INTO PHIEUNHAPSACH VALUES('N0003','Ho Quy Ly',38,400000,'1/3/2019','TT003','CC003');
INSERT INTO PHIEUNHAPSACH VALUES('N0004','Tren manh dat nguoi doi',50,750000,'1/4/2019','TT001','CC004');
INSERT INTO PHIEUNHAPSACH VALUES('N0005','Chuong nguyen hon ai',10,320000,'1/3/2019','TT004','CC005');
INSERT INTO PHIEUNHAPSACH VALUES('N0006','Chuong nguyen hon ai',10,320000,'1/3/2015','TT003','CC005');
INSERT INTO PHIEUNHAPSACH VALUES('N0007','Chuong nguyen hon ai',10,320000,'1/3/2016','TT004','CC001');
select * from PHIEUNHAPSACH

insert into SACH values('MS00001','CC001','Nu kiet Tong Khanh Linh','James Fenimore Cooper','2009','Da muon','vn','N0001','theloai1','tai ban');
insert into SACH values('MS00002','CC002','Ho Quy Ly', 'Doan Gioi','2008','Da muon','vn','N0003','theloai2','tai ban');
insert into SACH values('MS00003','CC003','Tren manh dat nguoi doi', 'Nguyen Hung','2009','Chua muon','vn','N0004','theloai3','tai ban');
insert into SACH values('MS00004','CC004','Chuong nguyen hon ai', 'Tuong Hong Ban','2009','vn','Chua muon','N0005','theloai4','tai ban');
insert into SACH values('MS00005','CC005','Tu Hy Thai Hau', 'Pearl S. Buck','2009','Da muon','vn','N0002','theloai5','tai ban');
insert into SACH values('MS00006','CC001','Tu Hy Thai Hau', 'Pearl S. Buck','2009','Da muon','vn','N0002','theloai5','tai ban');
insert into SACH values('MS00007','CC002','Tu Hy Thai Hau', 'Pearl S. Buck','2009','Da muon','vn','N0002','theloai5','tai ban');
insert into SACH values('MS00008','CC003','Tu Hy Thai Hau', 'Pearl S. Buck','2009','Da muon','vn','N0002','theloai5','tai ban');
insert into SACH values('MS00009','CC004','Tu Hy Thai Hau', 'Pearl S. Buck','2009','Da muon','vn','N0002','theloai5','tai ban');
insert into SACH values('MS00010','CC005','Tu Hy Thai Hau', 'Pearl S. Buck','2009','Da muon','vn','N0002','theloai5','tai ban');
insert into SACH values('MS00011','CC005','Tu Hy Thai Hau', 'Pearl S. Buck','2009','Da muon','vn','N0006','theloai5','tai ban');
insert into SACH values('MS00012','CC001','Tu Hy Thai Hau', 'Pearl S. Buck','2009','Da muon','vn','N0007','theloai5','tai ban');
select * from SACH
select * from PHIEUNHAPSACH

select count(*)
from SACH
where masach not in ( select masach from  QTMUON, PHIEUNHAPSACH where QTMUON.masach=SACH.masach and extract( year from(sysdate))- extract(year from (ngaygiao))<2 and SACH.manhap=PHIEUNHAPSACH.manhap);

insert into THETHUVIEN values('DG001','5/9/2016','5/9/2019','NULL');
insert into THETHUVIEN values('DG002','5/9/2017','5/9/2020','NULL');
insert into THETHUVIEN values('DG003','5/9/2018','5/9/2021','NULL');
insert into THETHUVIEN values('DG004','5/9/2016','5/9/2030','NULL');
insert into THETHUVIEN values('DG005','5/9/2016','5/9/2019','NULL');
select * from THETHUVIEN




INSERT INTO PHIEUMUON VALUES ('PM001','MS00001','DG002','9/3/2019','9/6/2019');
INSERT INTO PHIEUMUON VALUES ('PM002','MS00002','DG004','7/3/2019','7/6/2019');
INSERT INTO PHIEUMUON VALUES ('PM003','MS00005','DG003','12/3/2019','12/6/2019');
INSERT INTO PHIEUMUON VALUES ('PM004','MS00004','DG001','5/3/2019','5/6/2019');
INSERT INTO PHIEUMUON VALUES ('PM005','MS00003','DG002','5/3/2019','5/6/2019');
select *from PHIEUMUON

delete from PHIEUMUON
where masach='MS00002';

INSERT INTO QTMUON VALUES ('MS00001','5/3/2019','DG002','12/3/2019','26/3/2019',null,null);
INSERT INTO QTMUON VALUES ('MS00002','5/2/2019','DG002','1/3/2019','15/3/2019',null,null);
INSERT INTO QTMUON VALUES ('MS00004','5/3/2019','DG001','10/3/2019','24/3/2019',null,null);
INSERT INTO QTMUON VALUES ('MS00005','12/2/2019','DG003','2/3/2019','16/3/2019',null,null);
INSERT INTO QTMUON VALUES ('MS00003','5/3/2019','DG002','12/3/2019','26/3/2019',null,null);
INSERT INTO QTMUON VALUES ('MS00006','5/3/2019','DG002','12/3/2019','1/4/2019',null,null);
INSERT INTO QTMUON VALUES ('MS00007','5/3/2019','DG002','15/6/2019','21/06/2019',null,null);
INSERT INTO QTMUON VALUES ('MS00008','1/6/2019','DG002','15/6/2019','20/06/2019',null,null);
INSERT INTO QTMUON VALUES ('MS00009','5/6/2019','DG002','19/6/2019','19/06/2019',null,null);
INSERT INTO QTMUON VALUES ('MS00010','5/6/2019','DG002','19/6/2019','21/06/2019',null,null);
select * from QTMUON

                        
INSERT INTO PHIEUPHAT VALUES ('PP001','DG001','TT001','MS00001',5000,'1/2/2019','15/2/2019');
INSERT INTO PHIEUPHAT VALUES ('PP002','DG005','TT003','MS00003',5000,'2/2/2019','16/2/2019');
INSERT INTO PHIEUPHAT VALUES ('PP003','DG004','TT003','MS00002',5000,'10/2/2019','24/2/2019');
INSERT INTO PHIEUPHAT VALUES ('PP004','DG002','TT001','MS00003',5000,'2/3/2019','16/3/2019');
INSERT INTO PHIEUPHAT VALUES ('PP005','DG003','TT002','MS00004',5000,'12/3/2019','28/3/2019');
select * from PHIEUPHAT

INSERT INTO BAOCAO VALUES ('BC001','TT002','1/3/2019','Bao cao thong ke muon tra sach thang 02/2019','Day du','15000','30');
INSERT INTO BAOCAO VALUES ('BC002','TT003','1/4/2019','Bao cao thong ke muon tra sach thang 03/2019','Day du','5000','15');

select * from BAOCAO

set serveroutput on;
------------------------------------PROCEDURE TIME----------------------------------
CREATE OR REPLACE PROCEDURE sleep (in_time number)
AS
 v_now date;
BEGIN
 SELECT SYSDATE
 INTO v_now
 FROM DUAL;

 LOOP
 EXIT WHEN v_now + (in_time * (1/86400)) <= SYSDATE;
 END LOOP;
end;

-----------------------------PROCEDURE XOA SACH TRONG THU VIEN MA KHONG AI MUON TRONG 2 NAM------------------------------------
create or replace procedure xoa_sach_khong_ai_muon 
as
count_row_ma_sach_khong_muon number;
count_row_phieu_nhap number;
begin
select count(*)into count_row_ma_sach_khong_muon
from SACH
where masach not in ( select masach 
                      from QTMUON, PHIEUNHAPSACH 
                      where QTMUON.masach=SACH.masach and extract( year from(sysdate))- extract(year from (ngaygiao))<2 
                      and SACH.manhap=PHIEUNHAPSACH.manhap);   
                      
select count(*) into count_row_phieu_nhap
from PHIEUNHAPSACH
where PHIEUNHAPSACH.manhap  in (select PHIEUNHAPSACH.manhap 
                                from SACH, PHIEUNHAPSACH
                                where SACH.manhap=PHIEUNHAPSACH.manhap and 
                                SACH.masach not in ( select SACH.masach 
                                                     from QTMUON, PHIEUNHAPSACH, sach 
                                                     where QTMUON.masach=SACH.masach and
                                                     extract( year from(sysdate))- extract(year from (ngaygiao))<2 
                                                     and SACH.manhap=PHIEUNHAPSACH.manhap));
                  
delete from SACH
where masach not in ( select masach 
                      from QTMUON, PHIEUNHAPSACH 
                      where QTMUON.masach=SACH.masach and extract( year from(sysdate))- extract(year from (ngaygiao))<2 
                      and SACH.manhap=PHIEUNHAPSACH.manhap);             
delete from PHIEUNHAPSACH
where manhap  in (select PHIEUNHAPSACH.manhap 
                                from SACH, PHIEUNHAPSACH
                                where SACH.manhap=PHIEUNHAPSACH.manhap and 
                                SACH.masach not in ( select SACH.masach 
                                                     from QTMUON, PHIEUNHAPSACH, sach 
                                                     where QTMUON.masach=SACH.masach and
                                                     extract( year from(sysdate))- extract(year from (ngaygiao))<2 
                                                     and SACH.manhap=PHIEUNHAPSACH.manhap));

if(count_row_ma_sach_khong_muon>0) then
dbms_output.put_line('----------THU VIEN TRUONG THPT DUONG DIEM-------------------');
dbms_output.put_line('----------So luong sach khong ai muon: '|| count_row_ma_sach_khong_muon);
dbms_output.put_line('----------So phieu nhap sach xoa: '||count_row_phieu_nhap );
else
dbms_output.put_line('----------THU VIEN TRUONG THPT DUONG DIEM-------------------');
dbms_output.put_line('----------Khong co sach nao de xoa');
end if;
end;  


set serveroutput on;
--drop procedure xoa_sach_khong_ai_muon;
declare
begin
xoa_sach_khong_ai_muon;
end;
insert into PHIEUNHAPSACH values ('N0008','HE QUAN TRI CSDL',20,50000,'12/10/2015','TT002','CC001');
insert into PHIEUNHAPSACH values ('N0009','HE QUAN TRI CSDL',20,50000,'12/10/2015','TT002','CC001');
insert into PHIEUNHAPSACH values ('N0010','PHAN TICH THIET KE HE THONG THONG TIN',10,400000,'11/10/2016','TT001','CC002');
insert into SACH values ('MS00017','CC001','HE QUAN TRI CSDL',' NXB DHQG',2005,'Chua muon','Viet Nam','N0008','theloai1','lan 1');
insert into SACH values ('MS00018','CC001','HE QUAN TRI CSDL',' NXB DHQG',2005,'Chua muon','Viet Nam','N0009','theloai1','lan 1');
insert into SACH values ('MS00019','CC001','HE QUAN TRI CSDL',' NXB DHQG',2005,'Chua muon','Viet Nam','N0009','theloai1','lan 1');
insert into SACH values ('MS00020','CC001','HE QUAN TRI CSDL',' NXB DHQG',2005,'Chua muon','Viet Nam','N0010','theloai1','lan 1');
select * from PHIEUNHAPSACH
select * from SACH

--------------------------------trigger khong cho muon sach khi dang giu sach qua han-------------------------------------------
create or replace trigger khong_muon_sach 
before insert on QTMUON
for each row
declare 
v_ngayhethan date;
v_ngaytra date;
cursor cur is select ngayhethan, ngaytra from QTMUON where :NEW.MADOCGIA=MADOCGIA; 
begin
    open cur;
    loop
    fetch cur into v_ngayhethan, v_ngaytra;
    EXIT WHEN cur%NOTFOUND;
    IF((v_ngaytra IS NULL) AND (v_ngayhethan<SYSDATE)) THEN
    RAISE_APPLICATION_ERROR(-20000,'LOI KHONG THE MUON KHI DANG GIU SACH QUA HAN');
    END IF;
    END LOOP;
    CLOSE cur;
END;
drop trigger khong_muon_sach;
select * from QTMUON



------------------------ procedure thong ke tien phat theo doc gia-------------------------------------------------------------


set serveroutput on;
create or replace procedure thong_ke_tien_phat(in_madocgia DOCGIA.madocgia%type)
as
v_tong_tienphat number;
begin
set transaction isolation level read committed;
select sum(tienphat)
into v_tong_tienphat
from Phieuphat
where phieuphat.madocgia=in_madocgia;
dbms_output.put_line('Tong so tien phat:' || v_tong_tienphat); 
commit;
end;

drop procedure thong_ke_tien_phat;
declare
begin
thong_ke_tien_phat('DG003');
end;




------------------------procedure mot doc gia den tra sach <=> them phieu phat--------------------------------

create or replace procedure them_phieu_phat(in_maphieuphat_pp phieuphat.maphieuphat%type, 
in_madocgia_pp DOCGIA.madocgia%type, in_mathuthu_pp PHIEUPHAT.manhanvien%type, in_masach_pp SACH.masach%type, 
in_tienphat_pp phieuphat.tienphat%type, in_ngaytra_pp phieuphat.ngaytra_pp%type,in_ngayhethan_pp phieuphat.ngayhethan_pp%type) 
as
v_maphieuphat PHIEUPHAT.maphieuphat%type;
v_loi exception;
begin

select maphieuphat into v_maphieuphat 
from PHIEUPHAT
where PHIEUPHAT.maphieuphat=in_maphieuphat_pp;
if v_maphieuphat IS NOT NULL THEN RAISE v_loi;
end if;   
EXCEPTION 
    WHEN V_LOI THEN
    DBMS_OUTPUT.PUT_LINE('Phieu phat da ton tai');
    WHEN NO_DATA_FOUND THEN 
    INSERT INTO PHIEUPHAT VALUES(in_maphieuphat_pp, in_madocgia_pp, in_mathuthu_pp, in_masach_pp, in_tienphat_pp, in_ngaytra_pp, in_ngayhethan_pp);
    DBMS_OUTPUT.PUT_LINE('Them phieu phat thanh cong!'); 
end;


select *from PHIEUPHAT
set serveroutput on;
declare
begin
them_phieu_phat('PP023','DG003','TT002','MS00004',20000,'9/3/2019','11/3/2019');
end;

------------------------------------------------PHANTOM-------------------------------------------------------------------------
-----Mô t? tình hu?ng: Khi m?t th? th? ?ang th?c hi?n th?ng kê t?ng s? l??ng sách trong th? vi?n thì m?t th? th? khác th?c hi?n vi?c nh?p sách m?i vào th? vi?n
---------------------THONG KE SL SACH TRONG THU VIEN----------------------------------------------------------------------------
create or replace procedure DEM_SACH 
as
v_sl number;
begin
set transaction isolation level read committed;
select count(*)
into v_sl
from SACH,PHIEUNHAPSACH,NHAXUATBAN
where SACH.manhap=PHIEUNHAPSACH.manhap and sach.manxb=nhaxuatban.manxb;
dbms_output.put_line(' SO LUONG SACH CO TRONG THU VIEN:' || v_sl);
commit;
end;
SET SERVEROUTPUT ON;
declare 
begin
DEM_SACH;
end;
ROLLBACK;
select * from SACH

--------------------------------THEM SACH--------------------------------------
drop procedure them_sach_thu_vien;

create or replace procedure them_sach_thu_vien(in_masach SACH.masach%type, 
in_manxb SACH.manxb%type, in_tensach SACH.tensach%type, in_tacgia SACH.tacgia%type, 
in_namxb SACH.namxb%type, in_trangthai SACH.trangthai%type, in_ngonngu SACH.ngonngu%type, 
in_manhap SACH.manhap%type, in_theloai SACH.theloai%type, in_taiban SACH.taiban%type) 
as
v_masach SACH.masach%type;
v_loi exception;
begin

select masach into v_masach
from SACH
where SACH.masach=v_masach;
if v_masach IS NOT NULL THEN RAISE v_loi;
end if;   
EXCEPTION 
    WHEN V_LOI THEN
    DBMS_OUTPUT.PUT_LINE('Sach da ton tai trong thu vien');
    WHEN NO_DATA_FOUND THEN 
    INSERT INTO SACH VALUES(in_masach, in_manxb, in_tensach, in_tacgia, in_namxb, in_trangthai, in_ngonngu,in_manhap,in_theloai, in_taiban);
    DBMS_OUTPUT.PUT_LINE('Them sach thanh cong!'); 
end;
select * from SACH
delete from SACH
where masach ='MS00021';
commit;
declare 
begin
them_sach_thu_vien('MS00023','CC001','Tu Hy Thai Hau', 'Pearl S. Buck','2009','Da muon','vn','N0007','theloai5','tai ban');
end;
commit;
ROLLBACK;


-----------------------STORED PROCEDURE cho phep nhap vao MaNXB =>IN RA: --Ten nha xuat ban( Ma NXB)--------------------------
                                                                         --Chi tiet NXB
                                                                         --Ten sach
                                                                         --So luong sach 

CREATE OR REPLACE PROCEDURE SP_NXB( IN_MANXB NHAXUATBAN.MANXB %TYPE)
IS
  CURSOR C_NXB IS SELECT NHAXUATBAN.MANXB, TENNXB
                  FROM NHAXUATBAN
                  WHERE NHAXUATBAN.MANXB= IN_MANXB ;      
      V_MANXB NHAXUATBAN.MANXB%TYPE; 
      V_TENNXB NHAXUATBAN.TENNXB%TYPE;
BEGIN
   OPEN C_NXB;
   LOOP
       FETCH C_NXB INTO V_MANXB, V_TENNXB;
       EXIT WHEN C_NXB%NOTFOUND;
       DBMS_OUTPUT.PUT_LINE('NHA XUAT BAN:'||V_TENNXB||'( MaNXB:'||V_MANXB||')'); 
       DBMS_OUTPUT.PUT_LINE('======CHI TIET SACH NHAP TU NXB========');  
    DECLARE 
          CURSOR C_SACH IS SELECT COUNT(SACH.MASACH),TENSACH
                  FROM SACH 
                  WHERE SACH.MANXB=V_MANXB   GROUP BY TENSACH;         
          V_TENSACH SACH.TENSACH%TYPE;
          V_COUNT1 NUMBER;  
BEGIN
   OPEN C_SACH;
   LOOP
       FETCH C_SACH INTO V_COUNT1,V_TENSACH;
       EXIT WHEN C_SACH%NOTFOUND;       
       IF C_SACH%FOUND THEN         
       DBMS_OUTPUT.PUT_LINE('Ten sach:'||V_TENSACH||'_ so luong cuon:'||V_COUNT1);         
       END IF;
   END LOOP;
   CLOSE C_SACH;
   END;
 END LOOP;
 CLOSE C_NXB;
 END;




SET SERVEROUTPUT ON    
DECLARE
BEGIN
sp_nxb('CC001');
END;


CREATE OR REPLACE TRIGGER AFTER_SOSACH FOR UPDATE OF MASACH,MADOCGIA,NGAYTRA
ON QTMUON 
COMPOUND TRIGGER
DEM1 NUMBER:=0;
DEM2 NUMBER:=0;
MA1 QTMUON.MADOCGIA%TYPE;
MA2 CHAR(5);
AFTER EACH ROW IS
BEGIN
MA1:=:NEW.MADOCGIA;
END AFTER EACH ROW;
AFTER STATEMENT IS
BEGIN 
DBMS_OUTPUT.PUT_LINE(DEM1||' '||DEM2);
IF((DEM1>=3)OR(DEM2>=5)) THEN RAISE_APPLICATION_ERROR(-20000,'LOI MUON QUA SO SACH');
    END IF;
END AFTER STATEMENT;
END;
--------------------------------------UNREPEATABLE READ ----------------------------------------------------------------
--Mô t? tình hu?ng: Trong khi 1 th? th? ?ang xem báo cáo ti?n ph?t c?a ??c gi? th??ng thì cùng lúc ?ó 1 th? th? khác ?ang thêm m?t phi?u ph?t. X?y ra tình hu?ng Unrepeatable read
--sp_themphieuphat
CREATE OR REPLACE PROCEDURE sp_themphieuphat(in_maphieuphat phieuphat.maphieuphat%TYPE,in_madocgia phieuphat.madocgia%TYPE,
                                             in_manhanvien phieuphat.manhanvien%TYPE,in_masach phieuphat.masach%TYPE,
                                             in_tienphat phieuphat.tienphat%TYPE,in_ngaytra_pp phieuphat.ngaytra_pp%TYPE,
                                             in_ngayhethan_pp phieuphat.ngayhethan_pp%TYPE,in_mabaocao baocao.mabaocao%TYPE)
AS
   v_maphieuphat phieuphat.maphieuphat%TYPE;

   v_loi EXCEPTION;
BEGIN
SET  TRANSACTION ISOLATION LEVEL READ COMMITTED; 
   SELECT maphieuphat  INTO v_maphieuphat
   FROM phieuphat,baocao
   WHERE maphieuphat=in_maphieuphat AND mabaocao=in_mabaocao;
   IF v_maphieuphat IS NOT NULL THEN RAISE v_loi;
   END IF;
   
   EXCEPTION WHEN v_loi THEN
   dbms_output.put_line('phieu phat da ton tai');
   WHEN no_data_found THEN
   INSERT INTO phieuphat VALUES(in_maphieuphat,in_madocgia ,in_manhanvien,in_masach,in_tienphat,in_ngaytra_pp,in_ngayhethan_pp);
   dbms_output.put_line('Them thanh cong!');  
  
   UPDATE baocao
   SET tongtienphat=tongtienphat+ in_tienphat
   WHERE mabaocao=in_mabaocao;  
   COMMIT;
END;
SET SERVEROUTPUT ON
BEGIN
  sp_themphieuphat('PP006','DG003','TT002','MS00004',5000,'12/3/2019','1/4/2019','BC001');
END;

  --PROCEDURE SP_THONGKETIENPHAT
CREATE OR REPLACE PROCEDURE SP_THONGKETIENPHAT
IS
CURSOR C IS SELECT mabaocao,tongTIENPHAT
           FROM  BAOCAO;
           v_mabaocao baocao.mabaocao%TYPE;
           v_tien baocao.mabaocao%type;
  TONGTIEN BAOCAO.tongtienphat %TYPE;
BEGIN   
set  transaction isolation level read committed; 
     SELECT  sum(TONGTIENPHAT)
     INTO TONGTIEN
     FROM BAOCAO;
OPEN C;
   LOOP
       FETCH C  INTO v_mabaocao,v_tien;
       EXIT WHEN C%NOTFOUND;       
       IF C%FOUND THEN         
       DBMS_OUTPUT.PUT_LINE('mabaocao: '||V_MAbaocao ||'-Tien:'||v_tien);         
       END IF;
   END LOOP;
CLOSE C;
    DBMS_OUTPUT.PUT_LINE('TONG TIEN PHAT LA :'||TONGTIEN); 
    COMMIT;
END;

-----------------------------------DEADLOCK-------------------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE CHOMUON_SACH (CHOMUON_SACH PHIEUMUON.MAPHIEUMUON%TYPE,
V_MASACH SACH.MASACH%TYPE, V_MADOCGIA DOCGIA.MADOCGIA%TYPE)
IS
DEM NUMBER:=0;
BEGIN
SELECT COUNT(*) INTO DEM
FROM SACH
WHERE TRANGTHAI='Chua muon' AND MASACH=V_MASACH;
IF(DEM>0) THEN
UPDATE SACH SET TRANGTHAI='Da muon' WHERE MASACH=V_MASACH;
INSERT INTO PHIEUMUON VALUES(V_MAPHIEU,V_MASACH,V_MADOCGIA,SYSDATE,ADD_MONTHS(SYSDATE,3));
INSERT INTO QTMUON VALUES(V_MASACH,SYSDATE,V_MADOCGIA,ADD_MONTHS(SYSDATE,3),null,null,null);
ELSE RAISE_APPLICATION_ERROR(-20000,'SACH DA DUOC MUON');
END IF;
commit;
END;
--------------------------------PROCEDURE TRA SACH------------------------------------------------------------------------------
--PROCEDURE TRASACH
CREATE OR REPLACE PROCEDURE TRASACH(V_MASACH SACH.MASACH%TYPE, V_MADOCGIA 
DOCGIA.MADOCGIA%TYPE, V_MAPHIEUPHAT PHIEUPHAT.MAPHIEUPHAT%TYPE, V_MANHANVIEN NHANVIEN.MANHANVIEN%TYPE,
V_NGAYTRA DATE)
IS
PHAT NUMBER;
temp DATE;
BEGIN
SELECT NGAYHETHAN INTO TEMP FROM QTMUON WHERE MASACH=V_MASACH AND MADOCGIA=V_MADOCGIA AND NGAYTRA IS NULL;
-----TÍNH TI?N PH?T C?A ??C GI?------
PHAT:=TINH_PHAT(V_MADOCGIA,2000);
-----C?P NH?T NGÀY TR?-----------
    UPDATE QTMUON SET NGAYTRA=SYSDATE 
    WHERE MASACH=V_MASACH AND MADOCGIA=V_MADOCGIA AND NGAYTRA IS NULL;
------KI?M TRA S? TI?N PH?T ------
    IF (PHAT>1000) THEN 
-------THÊM PHI?U PH?T-------
    INSERT INTO PHIEUPHAT VALUES(V_MAPHIEUPHAT,V_MADOCGIA,V_MANHANVIEN,
    V_MASACH,PHAT,SYSDATE,TEMP);
    END IF;
-------C?P NH?T L?I TR?NG THÁI SÁCH------------
    UPDATE SACH SET TRANGTHAI='Chua muon'
    WHERE MASACH=V_MASACH;
-------C?P NH?T L?I TR?NG THÁI QUÁ TRÌNH M??N--------
    UPDATE QTMUON SET TRANGTHAI=null 
    WHERE MADOCGIA=V_MADOCGIA AND TRANGTHAI='phat'AND MASACH=V_MASACH;
END;
---------------------------------DEADLOCK---------------------------------------------------------------------------------------
---------------------------------TRIGGER----------------------------------------------------------------------------------------
---------------------------PROCEDURE SO LUONG DOC GIA MUON SÁCH TRONG MOT NGÀY CU THE---------------------------------------------
create or replace procedure count_doc_gia (v_ngay QTMUON.NGAYMUON%type)
as
count_docgia number;
begin
select count(madocgia) into count_docgia
from QTMUON
where QTMUON.ngaymuon = v_ngay;
dbms_output.put_line('**----------THU VIEN TRUONG THPT DUONG DIEM-----------**');
dbms_output.put_line('***---------NGÀY MUON SACH: ' || v_ngay );
dbms_output.put_line('****SO LUONG NGUOI MUON SACH : ' || count_docgia );
exception 
when no_data_found then
dbms_output.put_line(' DATA NO FOUND');
end;

set serveroutput on;
declare
begin
count_doc_gia(to_date('05/04/2019','dd/mm/yyyy'));
end; 
select * from QTMUON

----------------------PROCEDURE SO LUONG SACH DANG O TRONG THAI MUON-------------------------------------------------

create or replace procedure so_sach_muon
as
count_sach_muon int;
begin
select count(*) 
into count_sach_muon
from sach
where trangthai='Da muon';
dbms_output.put_line('THU VIEN TRUONG THPT DUONG DIEM');
dbms_output.put_line('So luong sach muon:' || count_sach_muon);
end;

declare 
begin
so_sach_muon;
end;
select * from SACH

---------------------------PROCEDURE SO LUONG SACH DANG O TRANG THAI CHUA MUON--------------------------------------------

create or replace procedure so_sach_chua_muon
as
count_sach_chua_muon int;
begin
select count(*) 
into count_sach_chua_muon
from sach
where trangthai='Chua muon';
dbms_output.put_line('THU VIEN TRUONG THPT DUONG DIEM');
dbms_output.put_line(' So luong sach chua muon:' || count_sach_chua_muon);
end;

declare 
begin
so_sach_chua_muon;
end;
select * from SACH


-------------------------PROCEDURE XEM THONG TIN SACH (CO THAM SO)----------------------------

create or replace procedure xem_thong_tin_sach(in_masach SACH.masach%type)
as
v_manhap SACH.MANHAP%type;
v_manxb SACH.manxb%type;
v_tensach SACH.tensach%type;
v_tacgia SACH.tacgia%type;
v_namxb SACH.namxb%type;
v_trangthai SACH.trangthai%type;
v_ngonngu SACH.ngonngu%type;
v_tentheloai SACH.theloai%type;
v_taiban SACH.taiban%type;
begin
select manhap, manxb, tensach, tacgia, namxb, trangthai, ngonngu,theloai, taiban
into  v_manhap, v_manxb, v_tensach, v_tacgia, v_namxb, v_trangthai, v_ngonngu,v_tentheloai, v_taiban
from SACH
where SACH.masach=in_masach;
dbms_output.put_line('THU VIEN TRUONG THPT DUONG DIEM');
dbms_output.put_line('Thong tin sach : ' ||  in_masach  || ' # ' || v_manhap || ' # ' || v_manxb || ' # ' || v_tensach || ' # ' || v_tacgia ||' # '|| v_namxb ||' # '|| v_trangthai ||' # '|| v_ngonngu|| ' # ' || v_tentheloai ||' # '|| v_taiban);
dbms_output.put_line('******************************************************************');
end;

declare
begin
xem_thong_tin_sach('MS00004');
end;
select *from SACH


-------------------------------Trigger cap nhat tinh trang sach la chua muon----------------------------------------------------
drop trigger trg_ChuaMuon;
CREATE TRIGGER trg_ChuaMuon AFTER DELETE ON PHIEUMUON
FOR EACH ROW
declare
    out_masach SACH.MASACH%type;
    cursor cs is select masach from SACH;
BEGIN	
open cs;
loop
    fetch cs into out_masach;
    exit when cs%NOTFOUND;
	UPDATE SACH
	SET TRANGTHAI='Chua muon'
	WHERE MASACH=:OLD.MASACH;
end loop;
close cs;
END;




--Trigger cap nhat tình trang sách là da muon
create or replace trigger trg_insert_sach
before update of trangthai on SACH
for each row
declare
    out_trangthai1 SACH.TRANGTHAI%type;
    out_masach1 SACH.MASACH%type;
    cursor cur is select masach from SACH;
begin
open cur;
loop
    fetch cur into out_masach1;
    exit when cur%NOTFOUND;
    select TRANGTHAI 
    into out_trangthai1
    from SACH
    where MASACH=out_masach1;    
    update SACH
    set trangthai='Da muon'
    where masach=out_masach ;
end loop;
close cs;
end;
select * from SACH;
delete from PHIEUMUON
where masach='MS00002';



--------------------------------------LOST UPDATE------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE ADD_DOCGIA(VTENTK TAIKHOAN.TENTK%TYPE,VMATKHAU TAIKHOAN.MATKHAU%TYPE, VLOAITK TAIKHOAN.LOAITK%TYPE, VMADOCGIA DOCGIA.MADOCGIA%TYPE,
VTEN DOCGIA.TEN%TYPE, VNGAYSINH nvarchar2/*DOCGIA.NGAYSINH%TYPE*/, VSDT DOCGIA.SDT%TYPE, VDIACHI DOCGIA.DIACHI%TYPE, VLOP DOCGIA.LOP%TYPE, VDOITUONG DOCGIA.DOITUONG%TYPE, VGIOITINH DOCGIA.GIOITINH%TYPE
, VGHICHU THETHUVIEN.GHICHU%TYPE, VEMAIL DOCGIA.EMAIL%TYPE)
IS
BEGIN
commit;
SAVEPOINT BEFORE_PRO;
    insert into taikhoan values(VTENTK,VMATKHAU,'doc gia');
    insert into docgia values(VMADOCGIA,VTEN,TO_DATE(VNGAYSINH,'dd-MM-yyyy'),VSDT,VDIACHI,VLOP,VDOITUONG,VGIOITINH,VEMAIL);
    INSERT INTO THETHUVIEN VALUES(VMADOCGIA,SYSDATE,ADD_MONTHS(SYSDATE,36),NULL);
EXCEPTION 
WHEN OTHERS THEN
ROLLBACK TO BEFORE_PRO;
COMMIT;
END;

select count(madocgia)
from docgia
where lop=12;


execute ADD_DOCGIA('DG013','DG013','doc gia','DG013','KIM THAOOOO','02-09-2010','1111111111','KHU B',12,'Hoc sinh','nam','DG013',null,'gmail');

--drop trigger THE_DUYNHAT;

SELECT *
FROM DOCGIA
WHERE MADOCGIA ='';


-------------------------Procedure liet ke doc gia muon sach qua han nhung da tra--------------------------------------------
DROP PROCEDURE sp_DocGiaDaTraSachQHan;
CREATE OR REPLACE PROCEDURE sp_DocGiaDaTraSachQHan
AS
COUNT_ROW NUMBER;
BEGIN
  SELECT COUNT(*)
   INTO COUNT_ROW
   FROM DOCGIA
   WHERE  EXISTS (SELECT PHIEUMUON.MADOCGIA
                  FROM PHIEUMUON
                  WHERE PHIEUMUON.MADOCGIA=DOCGIA.MADOCGIA AND  EXISTS( SELECT QTMUON.MADOCGIA
                                                                        FROM QTMUON
                                                                        WHERE QTMUON.MADOCGIA = PHIEUMUON.MADOCGIA 
                                                                        AND (To_date(NGAYHETHAN)< to_date(QTMUON.NGAYTRA)) AND
                                                                        (To_date(SYSDATE)> to_date(QTMUON.NGAYTRA))));
DBMS_OUTPUT.PUT_LINE('Tong so doc gia muon sach qua han nhung da tra: '||COUNT_ROW); 
END;
drop procedure sp_DocGiaDaTraSachQHan;

SET SERVEROUTPUT ON
BEGIN
sp_DocGiaDaTraSachQHan;
END;
select * from QTMUON;
------------------------------Stored procedure muon sach qua han nhung chua tra-------------------------------------------------
DROP PROCEDURE sp_DocGiaChuTraSachQHan;
CREATE OR REPLACE PROCEDURE sp_DocGiaChuTraSachQHan
AS
COUNT_ROW NUMBER;
BEGIN
   SELECT COUNT(*)
   INTO COUNT_ROW
   FROM DOCGIA
   WHERE  EXISTS (SELECT PHIEUMUON.MADOCGIA
                  FROM PHIEUMUON
                  WHERE PHIEUMUON.MADOCGIA=DOCGIA.MADOCGIA AND  EXISTS( SELECT QTMUON.MADOCGIA
                                                                FROM QTMUON
                                                                WHERE QTMUON.MADOCGIA = PHIEUMUON.MADOCGIA AND (To_date(SYSDATE)> to_date(QTMUON.NGAYHETHAN)) AND QTMUON.NGAYTRA IS NULL));
    DBMS_OUTPUT.PUT_LINE('Tong so doc gia muon sach qua han chua tra: '||COUNT_ROW); 
END;  


SET SERVEROUTPUT ON
BEGIN
sp_DocGiaChuTraSachQHan;
END;

------------------------------------Stored procedure so doc gia dang muon sach-------------------------------------------------
DROP PROCEDURE sp_DocGiaDangMuonSach;
CREATE OR REPLACE PROCEDURE sp_DocGiaDangMuonSach
AS
COUNT_ROW NUMBER;
BEGIN
  SELECT COUNT(*)
   INTO COUNT_ROW
   FROM DOCGIA
   WHERE  EXISTS (SELECT PHIEUMUON.MADOCGIA
                  FROM PHIEUMUON
                  WHERE PHIEUMUON.MADOCGIA=DOCGIA.MADOCGIA AND  EXISTS( SELECT QTMUON.MADOCGIA
                                                                        FROM QTMUON
                                                                       WHERE QTMUON.MADOCGIA = PHIEUMUON.MADOCGIA and QTMUON.NGAYTRA IS NULL ));
    DBMS_OUTPUT.PUT_LINE('Tong so doc gia dang muon sach chua tra: '||COUNT_ROW); 
END;
SET SERVEROUTPUT ON
BEGIN
sp_DocGiaDangMuonSach;
END;

-----------------Store procedure xoa sach----------------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE SP_XOASACH(IN_MASACH SACH.MASACH%TYPE)
AS 
 V_MASACH SACH.MASACH%TYPE;
  
BEGIN
   SELECT MASACH INTO V_MASACH
   FROM SACH
   WHERE SACH.MASACH=IN_MASACH;
   DELETE FROM PHIEUMUON
   WHERE PHIEUMUON.MASACH=IN_MASACH;
   DELETE FROM PHIEUPHAT
   WHERE PHIEUPHAT.MASACH=IN_MASACH;
   DELETE FROM QTMUON
   WHERE QTMUON.MASACH=IN_MASACH; 
   DELETE FROM SACH
   WHERE SACH.MASACH=IN_MASACH;
   DBMS_OUTPUT.PUT_LINE('Xoa sach thanh cong!');
  END;
  
  
select * from SACH
declare
begin
sp_xoasach('MS00011');
end;


--TRIGGER KI?M TRA S? L??NG SÁCH CHO M??N ---
-----TRIGGER CHECK NGÀY M??N TR?---
CREATE OR REPLACE TRIGGER CHECKNGAY_MUONTRA BEFORE INSERT OR UPDATE OF NGAYHETHAN,NGAYTRA
ON QTMUON FOR EACH ROW
DECLARE
NMUON QTMUON.NGAYMUON%TYPE;
NHETHAN QTMUON.NGAYHETHAN%TYPE;
NTRA QTMUON.ngaytra%TYPE;
BEGIN
    IF((:NEW.NGAYHETHAN<:NEW.NGAYMUON)OR(:NEW.NGAYTRA<:NEW.NGAYMUON)) THEN
    RAISE_APPLICATION_ERROR(-20000,'LOI NGAY TRA');
    END IF;
END CHECKNGAY_MUONTRA;

----TRIGGER XÁC DINH LOP CHO HOC SINH---
CREATE OR REPLACE TRIGGER TRI_LOP BEFORE INSERT OR UPDATE OF LOP,DOITUONG
ON DOCGIA
FOR EACH ROW
BEGIN
    IF(((:NEW.DOITUONG='Hoc sinh')AND(:NEW.LOP NOT IN(10,11,12))) OR(:NEW.DOITUONG='Giao vien' AND :NEW.LOP IS NOT NULL)) THEN
    RAISE_APPLICATION_ERROR(-20000,'LOI KO KHOP LOP VS DOI TUONG');
    END IF;
END;

-----FUNTION TÍNH TI?N PH?T-----
CREATE OR REPLACE FUNCTION TINH_PHAT (MA IN QTMUON.MADOCGIA%TYPE,TIEN IN NUMBER)
RETURN NUMBER
IS
DEM NUMBER :=0;
--TEMP QTMUON%ROWTYPE;
PHAT NUMBER :=0;
TRADAY DATE;
HANDAY DATE;
CURSOR CUR IS SELECT NGAYHETHAN,NGAYTRA FROM QTMUON WHERE MA=MADOCGIA and NGAYHETHAN < SYSDATE AND TRANGTHAI='phat';
BEGIN
    OPEN CUR;
    LOOP
    FETCH CUR INTO HANDAY,TRADAY;
    EXIT WHEN CUR%NOTFOUND;   
    IF(TRADAY IS NULL) THEN    
    DEM:=SYSDATE-HANDAY; 
     DBMS_OUTPUT.PUT_LINE('NGAY:'||DEM);
    PHAT:=PHAT+DEM*TIEN;
    END IF;
    END LOOP;
    CLOSE CUR;
    RETURN PHAT;
    EXCEPTION
    WHEN NO_DATA_FOUND THEN
    RETURN 0;
END;

--- TRIGGER NGÀY CUA THE THU VIEN---------
CREATE OR REPLACE TRIGGER NGAY_THE BEFORE INSERT OR UPDATE OF NGAYBD,NGAYHETHAN
ON THETHUVIEN
FOR EACH ROW
BEGIN
    IF(:NEW.NGAYBD>=:NEW.NGAYHETHAN) THEN
    RAISE_APPLICATION_ERROR(-20000,'LOI NGAY CUA THE THU VIEN');
    END IF;
END;
----TRIGGER CHi CHO PHÉP 1 DOC GIA SO HUU 1 THE THU VIEN DUY NHAT -------------
CREATE OR REPLACE TRIGGER insert_THE_DUYNHAT BEFORE INSERT ON THETHUVIEN
FOR EACH ROW
DECLARE
DEM NUMBER;
BEGIN
    SELECT COUNT(MATHE) INTO DEM FROM THETHUVIEN WHERE :NEW.MADOCGIA=MADOCGIA;
    IF(DEM =1) THEN
    RAISE_APPLICATION_ERROR(-20000,'LOI:DOC GIA DA CO THE THU VIEN');
    END IF;
END;
--UPDATE_THE_DUYNHAT
CREATE OR REPLACE TRIGGER UPDATE_THE_DUYNHAT FOR UPDATE OF MATHE,MADOCGIA ON THETHUVIEN
COMPOUND TRIGGER
DEM NUMBER:=0;
MA QTMUON.MADOCGIA%TYPE;
AFTER EACH ROW IS
BEGIN
 MA:=:NEW.MADOCGIA;
 DBMS_OUTPUT.PUT_LINE(MA);
 END AFTER EACH ROW;
 AFTER STATEMENT IS
 BEGIN
 SELECT COUNT(MATHE) INTO DEM FROM THETHUVIEN WHERE MA=MADOCGIA;
 IF(DEM>=1) THEN RAISE_APPLICATION_ERROR(-20000,'LOI DOC GIA CHI DUOC CO 1 THE THU VIEN');
 END IF;
 END AFTER STATEMENT;
 END;
OSE CUR_MUON;
END;

----------------procedure XÓA ??C GI?------------------------
CREATE OR REPLACE PROCEDURE XOA_DOCGIA (MA DOCGIA.MADOCGIA%TYPE)
IS
TEMP DOCGIA.MADOCGIA%TYPE;
BEGIN
SELECT MADOCGIA INTO TEMP FROM DOCGIA WHERE DOCGIA.MADOCGIA=MA;
DELETE FROM PHIEUPHAT WHERE PHIEUPHAT.MADOCGIA=TEMP;
DELETE FROM PHIEUMUON WHERE PHIEUMUON.MADOCGIA=TEMP;
DELETE FROM QTMUON WHERE QTMUON.MADOCGIA=TEMP;
DELETE FROM DOCGIA WHERE DOCGIA.MADOCGIA=TEMP;
DELETE FROM TAIKHOAN WHERE TAIKHOAN.TENTK=TEMP;
DELETE FROM THETHUVIEN WHERE MADOCGIA=TEMP;
EXCEPTION
WHEN NO_DATA_FOUND THEN
RAISE_APPLICATION_ERROR(-20000,'KHONG TIM THAY DOC GIA DE XOA');
END;
---------------PROCEDURE XEM THÔNG TIN ??C GI?-------------
CREATE OR REPLACE PROCEDURE SHOW_DOCGIA (MA DOCGIA.MADOCGIA%TYPE)
IS
TEMP DOCGIA%ROWTYPE;
BEGIN
    SELECT DOCGIA.* INTO TEMP FROM DOCGIA WHERE MADOCGIA=MA;
    DBMS_OUTPUT.put_line(TEMP.MADOCGIA||' '||TEMP.TEN||' '||TEMP.NGAYSINH||' '||TEMP.SDT||' '||TEMP.DIACHI||' '||TEMP.LOP||' '||TEMP.DOITUONG||' '||TEMP.GIOITINH);
END;
--------------PROCEDURE LIET KE CAC DOC GIA DANG MUON SACH-------------
--EXECUTE SHOW_DANGMUONSACH;
CREATE OR REPLACE PROCEDURE SHOW_DANGMUONSACH
IS
v_ma QTMUON.MADOCGIA%TYPE;
BEGIN
    for rec in(select madocgia from qtmuon where ngaytra is null) loop
    dbms_output.put_line(rec.madocgia);
    end loop;
END;
------------PROCEDURE LIET KE CAC DOC GIA DANG MUON SACH QUA HAN------------
CREATE OR REPLACE PROCEDURE SHOW_DANGMUONSACHQUAHAN
IS
v_ma QTMUON.MADOCGIA%TYPE;
BEGIN
    for rec in(select madocgia from qtmuon where ngaytra is null AND SYSDATE > NGAYHETHAN) loop
    dbms_output.put_line(rec.madocgia);
    end loop;
END;
declare
begin
show_dangmuonsachquahan;
end;
----------PROCEDURE XOA NHAN VIEN-------------------------------
CREATE OR REPLACE PROCEDURE XOA_NHANVIEN(MA NHANVIEN.MANHANVIEN%TYPE)
IS
BEGIN
UPDATE PHIEUPHAT SET MANHANVIEN=NULL WHERE MANHANVIEN=MA;
UPDATE BAOCAO SET MANHANVIEN=NULL WHERE MANHANVIEN=MA;
UPDATE PHIEUNHAPSACH SET MANHANVIEN=NULL WHERE MANHANVIEN=MA;
DELETE NHANVIEN WHERE MANHANVIEN=MA;
DELETE FROM TAIKHOAN WHERE TENTK=MA;
COMMIT;
END;
----------TRIGGER RANG BUOC CHUC VU TRONG TAIKHOAN PHAI GIONG TRONG NHANVIEN---------------
CREATE OR REPLACE TRIGGER TRI_CHUCVU BEFORE INSERT OR UPDATE OF CHUCVU
ON NHANVIEN
FOR EACH ROW
DECLARE
    V_TK TAIKHOAN.LOAITK%TYPE;
BEGIN
    SELECT LOAITK INTO V_TK FROM TAIKHOAN where :NEW.MANHANVIEN=TENTK;
    IF(V_TK != :NEW.CHUCVU) THEN RAISE_APPLICATION_ERROR(-20000,'NHAP NHAN VIEN CO CHUC VU KO KHOP VS TAI KHOAN');
    END IF;
END;


---------TRIGGER CAP NHAT CHUC VU TRONG TAI KHOAN-------------------------
CREATE OR REPLACE TRIGGER UPDATE_CHUCVU_TK BEFORE UPDATE OF CHUCVU ON NHANVIEN
FOR EACH ROW
DECLARE 
V_MA NHANVIEN.MANHANVIEN%TYPE;
BEGIN
    V_MA:=:NEW.MANHANVIEN;
    UPDATE TAIKHOAN SET LOAITK=:NEW.CHUCVU WHERE TENTK=V_MA;
END;



 
---------PROCEDURE THEM 1 NHAN VIEN-----------------------
CREATE OR REPLACE PROCEDURE ADD_NHANVIEN(VTENTK TAIKHOAN.TENTK%TYPE, VMATKHAU TAIKHOAN.MATKHAU%TYPE, VLOAITK TAIKHOAN.LOAITK%TYPE, VMANHANVIEN NHANVIEN.MANHANVIEN%TYPE,
VHOTEN NHANVIEN.HOTEN%TYPE, VNGAYSINH NVARCHAR2, VSDT NHANVIEN.SDT%TYPE, VEMAIL NHANVIEN.EMAIL%TYPE, VGIOITINH NHANVIEN.GIOITINH%TYPE, VCHUCVU NHANVIEN.CHUCVU%TYPE, 
VDIACHI NHANVIEN.DIACHI%TYPE)
IS
BEGIN
COMMIT;
    insert into taikhoan values(VTENTK,VMATKHAU,VLOAITK);
    INSERT INTO NHANVIEN VALUES(VMANHANVIEN,VHOTEN,TO_DATE(VNGAYSINH,'dd-MM-yyyy'),VSDT,VEMAIL,VGIOITINH,VCHUCVU,VDIACHI);

COMMIT;
END;


CREATE SEQUENCE masach
 MINVALUE 1
   MAXVALUE 9999999 
   INCREMENT BY 1 
   START WITH 10
   NOCACHE 
   NOORDER 
   NOCYCLE;
   

   CREATE OR REPLACE TRIGGER Trg_MaSachTang
    BEFORE INSERT ON SACH
    REFERENCING NEW AS NEW OLD AS OLD
    FOR EACH ROW
BEGIN
   IF INSERTING AND :NEW.MASACH IS NULL THEN
   SELECT 'MS0'|| TO_CHAR (masach.NEXTVAL) INTO :NEW.MASACH
   FROM SYS.DUAL;
    END IF;
END ;
