/* I. CREATE TABLES */

-- faculty (Khoa trong trường)
create table faculty (
	id number primary key,
	name nvarchar2(30) not null
);

-- subject (Môn học)
create table subject(
	id number primary key,
	name nvarchar2(100) not null,
	lesson_quantity number(2,0) not null -- tổng số tiết học
);

-- student (Sinh viên)
create table student (
	id number primary key,
	name nvarchar2(30) not null,
	gender nvarchar2(10) not null, -- giới tính
	birthday date not null,
	hometown nvarchar2(100) not null, -- quê quán
	scholarship number, -- học bổng
	faculty_id number not null constraint faculty_id references faculty(id) -- mã khoa
);

-- exam management (Bảng điểm)
create table exam_management(
	id number primary key,
	student_id number not null constraint student_id references student(id),
	subject_id number not null constraint subject_id references subject(id),
	number_of_exam_taking number not null, -- số lần thi (thi trên 1 lần được gọi là thi lại) 
	mark number(4,2) not null -- điểm
);



/*================================================*/

/* II. INSERT SAMPLE DATA */

-- subject
insert into subject (id, name, lesson_quantity) values (1, n'Cơ sở dữ liệu', 45);
insert into subject values (2, n'Trí tuệ nhân tạo', 45);
insert into subject values (3, n'Truyền tin', 45);
insert into subject values (4, n'Đồ họa', 60);
insert into subject values (5, n'Văn phạm', 45);


-- faculty
insert into faculty values (1, n'Anh - Văn');
insert into faculty values (2, n'Tin học');
insert into faculty values (3, n'Triết học');
insert into faculty values (4, n'Vật lý');


-- student
insert into student values (1, n'Nguyễn Thị Hải', n'Nữ', to_date('19900223', 'YYYYMMDD'), 'Hà Nội', 130000, 2);
insert into student values (2, n'Trần Văn Chính', n'Nam', to_date('19921224', 'YYYYMMDD'), 'Bình Định', 150000, 4);
insert into student values (3, n'Lê Thu Yến', n'Nữ', to_date('19900221', 'YYYYMMDD'), 'TP HCM', 150000, 2);
insert into student values (4, n'Lê Hải Yến', n'Nữ', to_date('19900221', 'YYYYMMDD'), 'TP HCM', 170000, 2);
insert into student values (5, n'Trần Anh Tuấn', n'Nam', to_date('19901220', 'YYYYMMDD'), 'Hà Nội', 180000, 1);
insert into student values (6, n'Trần Thanh Mai', n'Nữ', to_date('19910812', 'YYYYMMDD'), 'Hải Phòng', null, 3);
insert into student values (7, n'Trần Thị Thu Thủy', n'Nữ', to_date('19910102', 'YYYYMMDD'), 'Hải Phòng', 10000, 1);


-- exam_management
insert into exam_management values (1, 1, 1, 1, 3);
insert into exam_management values (2, 1, 1, 2, 6);
insert into exam_management values (3, 1, 2, 2, 6);
insert into exam_management values (4, 1, 3, 1, 5);
insert into exam_management values (5, 2, 1, 1, 4.5);
insert into exam_management values (6, 2, 1, 2, 7);
insert into exam_management values (7, 2, 3, 1, 10);
insert into exam_management values (8, 2, 5, 1, 9);
insert into exam_management values (9, 3, 1, 1, 2);
insert into exam_management values (10, 3, 1, 2, 5);
insert into exam_management values (11, 3, 3, 1, 2.5);
insert into exam_management values (12, 3, 3, 2, 4);
insert into exam_management values (13, 4, 5, 2, 10);
insert into exam_management values (14, 5, 1, 1, 7);
insert into exam_management values (15, 5, 3, 1, 2.5);
insert into exam_management values (16, 5, 3, 2, 5);
insert into exam_management values (17, 6, 2, 1, 6);
insert into exam_management values (18, 6, 4, 1, 10);

commit;

/*================================================*/

/* III. QUERY */


 /********* A. BASIC QUERY *********/

-- 1. Liệt kê danh sách sinh viên sắp xếp theo thứ tự:
--      a. id tăng dần
SELECT * FROM STUDENT ORDER BY ID;
--      b. giới tính
SELECT * FROM STUDENT ORDER BY GENDER;
--      c. ngày sinh TĂNG DẦN và học bổng GIẢM DẦN
SELECT * FROM STUDENT ORDER BY BIRTHDAY, SCHOLARSHIP DESC;

-- 2. Môn học có tên bắt đầu bằng chữ 'T'
SELECT NAME FROM SUBJECT WHERE NAME LIKE 'T%';
-- 3. Sinh viên có chữ cái cuối cùng trong tên là 'i'
SELECT * FROM STUDENT WHERE NAME LIKE '%i';
-- 4. Những khoa có ký tự thứ hai của tên khoa có chứa chữ 'n'
SELECT * FROM FACULTY WHERE (SUBSTR(NAME, 2,1)) = 'n';
-- 5. Sinh viên trong tên có từ 'Thị'
SELECT * FROM STUDENT WHERE NAME LIKE '%Thị%';
-- 6. Sinh viên có ký tự đầu tiên của tên nằm trong khoảng từ 'a' đến 'm', sắp xếp theo họ tên sinh viên
SELECT * FROM STUDENT 
WHERE (SUBSTR(NAME, 2,1)) BETWEEN 'a' AND 'm'
ORDER BY NAME;
-- 7. Sinh viên có học bổng lớn hơn 100000, sắp xếp theo mã khoa giảm dần
SELECT * FROM STUDENT 
WHERE SCHOLARSHIP > 100000
ORDER BY FACULTY_ID DESC;
-- 8. Sinh viên có học bổng từ 150000 trở lên và sinh ở Hà Nội
SELECT * FROM STUDENT 
WHERE SCHOLARSHIP >= 150000 AND HOMETOWN = 'Hà Nội';
-- 9. Những sinh viên có ngày sinh từ ngày 01/01/1991 đến ngày 05/06/1992
SELECT * FROM STUDENT 
WHERE BIRTHDAY BETWEEN '01-JAN-91' AND '05-JUN-92';
-- 10. Những sinh viên có học bổng từ 80000 đến 150000
SELECT * FROM STUDENT 
WHERE SCHOLARSHIP >= 80000 AND SCHOLARSHIP <= 150000;
-- 11. Những môn học có số tiết lớn hơn 30 và nhỏ hơn 45
SELECT * FROM SUBJECT 
WHERE LESSON_QUANTITY >30 AND LESSON_QUANTITY < 45;




-------------------------------------------------------------------

/********* B. CALCULATION QUERY *********/

-- 1. Cho biết thông tin về mức học bổng của các sinh viên, gồm: Mã sinh viên, Giới tính, Mã 
		-- khoa, Mức học bổng. Trong đó, mức học bổng sẽ hiển thị là “Học bổng cao” nếu giá trị 
		-- của học bổng lớn hơn 500,000 và ngược lại hiển thị là “Mức trung bình”.
ALTER TABLE STUDENT ADD TYPE_SCHOLARSHIP NVARCHAR2(1000);
UPDATE STUDENT SET TYPE_SCHOLARSHIP = 'Học bổng cao' WHERE SCHOLARSHIP >500000;
UPDATE STUDENT SET TYPE_SCHOLARSHIP = 'Mức trung bình' WHERE SCHOLARSHIP <=500000;
SELECT ID,GENDER,FACULTY_ID,TYPE_SCHOLARSHIP FROM STUDENT;
COMMIT;
-- 2. Tính tổng số sinh viên của toàn trường
SELECT COUNT(ID) AS SV_TOAN_TRUONG FROM STUDENT;
-- 3. Tính tổng số sinh viên nam và tổng số sinh viên nữ.
SELECT COUNT(ID) AS SV_NAM_TOAN_TRUONG FROM STUDENT
WHERE GENDER = 'Nam';
SELECT COUNT(ID) AS SV_NAM_TOAN_TRUONG FROM STUDENT
WHERE GENDER = 'Nữ';
-- 4. Tính tổng số sinh viên từng khoa
SELECT FACULTY_ID,COUNT(S.ID)AS SO_LUONG_SV_CUA_KHOA 
FROM STUDENT S
GROUP BY FACULTY_ID;
-- 5. Tính tổng số sinh viên của từng môn học
SELECT SUBJECT_ID, COUNT (DISTINCT STUDENT_ID)AS SO_LUONG_SV
FROM EXAM_MANAGEMENT
GROUP BY SUBJECT_ID
ORDER BY SUBJECT_ID;
-- 6. Tính số lượng môn học mà sinh viên đã học
SELECT STUDENT_ID, COUNT (DISTINCT SUBJECT_ID)AS SO_MON_HOC
FROM EXAM_MANAGEMENT
GROUP BY STUDENT_ID
ORDER BY STUDENT_ID;
-- 7. Tổng số học bổng của mỗi khoa	
SELECT FACULTY_ID, SUM (SCHOLARSHIP)AS TONG_HOC_BONG_CUA_KHOA
FROM STUDENT
GROUP BY FACULTY_ID
ORDER BY FACULTY_ID;
-- 8. Cho biết học bổng cao nhất của mỗi khoa
SELECT FACULTY_ID, MAX (SCHOLARSHIP)AS HOC_BONG_MAX_CUA_KHOA
FROM STUDENT
GROUP BY FACULTY_ID
ORDER BY FACULTY_ID;
-- 9. Cho biết tổng số sinh viên nam và tổng số sinh viên nữ của mỗi khoa
SELECT FACULTY_ID, COUNT (GENDER)AS SV_NAM_CUA_KHOA 
FROM STUDENT
WHERE GENDER = 'Nam'
GROUP BY FACULTY_ID;
SELECT FACULTY_ID, COUNT (GENDER)AS SV_NU_CUA_KHOA 
FROM STUDENT
WHERE GENDER = 'Nữ'
GROUP BY FACULTY_ID;
-- 10. Cho biết số lượng sinh viên theo từng độ tuổi
SELECT (2022- EXTRACT(YEAR FROM BIRTHDAY))AS DO_TUOI, COUNT( ID) AS SO_LUONG_SV_CUNG_TUOI
FROM STUDENT
GROUP BY (2022- EXTRACT(YEAR FROM BIRTHDAY));
-- 11. Cho biết những nơi nào có ít nhất 2 sinh viên đang theo học tại trường
SELECT HOMETOWN,COUNT(ID)
FROM STUDENT
GROUP BY HOMETOWN
HAVING COUNT(ID)>=2;
-- 12. Cho biết những sinh viên thi lại ít nhất 2 lần
SELECT STUDENT_ID, SUBJECT_ID, COUNT(*)
FROM EXAM_MANAGEMENT
GROUP BY STUDENT_ID, SUBJECT_ID
HAVING COUNT(*)>=2;
-- 13. Cho biết những sinh viên nam có điểm trung bình lần 1 trên 7.0 
SELECT STUDENT_ID  ,AVG(MARK)
FROM EXAM_MANAGEMENT
WHERE NUMBER_OF_EXAM_TAKING=1 
GROUP BY  STUDENT_ID
HAVING AVG(MARK) >=7 AND STUDENT_ID IN(SELECT ID FROM STUDENT WHERE GENDER = 'Nam') ;
-- 14. Cho biết danh sách các sinh viên rớt ít nhất 2 môn ở lần thi 1 (rớt môn là điểm thi của môn không quá 4 điểm)
SELECT STUDENT_ID  ,COUNT(SUBJECT_ID) AS SO_MON_THI_ROT_LAN_1
FROM EXAM_MANAGEMENT
WHERE NUMBER_OF_EXAM_TAKING=1 AND MARK <=4
GROUP BY  STUDENT_ID
HAVING COUNT(SUBJECT_ID)>=2 ;
-- 15. Cho biết danh sách những khoa có nhiều hơn 2 sinh viên nam
SELECT FACULTY_ID,COUNT(ID)
FROM STUDENT
WHERE GENDER = 'Nam'
GROUP BY FACULTY_ID
HAVING COUNT(ID) >2;
-- 16. Cho biết những khoa có 2 sinh viên đạt học bổng từ 200000 đến 300000
SELECT FACULTY_ID,COUNT(ID)
FROM STUDENT
WHERE SCHOLARSHIP >=200000 AND SCHOLARSHIP<=300000
GROUP BY FACULTY_ID
HAVING COUNT(ID) =2;
-- 17. Cho biết sinh viên nào có học bổng cao nhất
SELECT *FROM STUDENT
WHERE SCHOLARSHIP = ( SELECT MAX(SCHOLARSHIP)FROM STUDENT);

-------------------------------------------------------------------

/********* C. DATE/TIME QUERY *********/

-- 1. Sinh viên có nơi sinh ở Hà Nội và sinh vào tháng 02
SELECT * FROM STUDENT
WHERE HOMETOWN = 'Hà Nội' AND EXTRACT(MONTH FROM BIRTHDAY)=2;
-- 2. Sinh viên có tuổi lớn hơn 20
SELECT * FROM STUDENT
WHERE(2022- EXTRACT(YEAR FROM BIRTHDAY))>20;
-- 3. Sinh viên sinh vào mùa xuân năm 1990
SELECT * FROM STUDENT
WHERE EXTRACT(MONTH FROM BIRTHDAY)>0 AND EXTRACT(MONTH FROM BIRTHDAY)<4 AND EXTRACT(YEAR FROM BIRTHDAY)=1990;

-------------------------------------------------------------------


/********* D. JOIN QUERY *********/

-- 1. Danh sách các sinh viên của khoa ANH VĂN và khoa VẬT LÝ
SELECT * FROM STUDENT S
JOIN (SELECT ID FROM FACULTY WHERE NAME IN ('Anh - Văn','Vật lý')) F
ON S.FACULTY_ID = F.ID;
-- 2. Những sinh viên nam của khoa ANH VĂN và khoa TIN HỌC
SELECT * FROM (SELECT * FROM STUDENT 
WHERE GENDER = 'Nam') S
JOIN (SELECT ID FROM FACULTY WHERE NAME IN ('Anh - Văn','Vật lý')) F
ON S.FACULTY_ID = F.ID;
-- 3. Cho biết sinh viên nào có điểm thi lần 1 môn cơ sở dữ liệu cao nhất
SELECT *FROM EXAM_MANAGEMENT
WHERE MARK = 
(SELECT MAX(MARK)
FROM (SELECT MARK FROM EXAM_MANAGEMENT WHERE NUMBER_OF_EXAM_TAKING =1 AND SUBJECT_ID =(SELECT ID FROM SUBJECT WHERE NAME = 'Cơ sở dữ liệu')))
AND  NUMBER_OF_EXAM_TAKING =1 
AND SUBJECT_ID =(SELECT ID FROM SUBJECT WHERE NAME = 'Cơ sở dữ liệu');

-- 4. Cho biết sinh viên khoa anh văn có tuổi lớn nhất.
SELECT * FROM STUDENT S
JOIN (SELECT ID FROM FACULTY WHERE NAME ='Anh - Văn') F 
ON S.FACULTY_ID = F.ID
WHERE S.ID IN (SELECT ID FROM STUDENT WHERE EXTRACT(YEAR FROM BIRTHDAY) = (SELECT MIN (EXTRACT(YEAR FROM BIRTHDAY))FROM STUDENT));
-- 5. Cho biết khoa nào có đông sinh viên nhất
SELECT*FROM(SELECT FACULTY_ID,COUNT(*)AS NHIEU_NHAT
FROM STUDENT S
JOIN FACULTY F ON S.FACULTY_ID = F.ID
GROUP BY FACULTY_ID
ORDER BY NHIEU_NHAT DESC)
WHERE ROWNUM = 1;

-- 6. Cho biết khoa nào có đông nữ nhất
SELECT*FROM(SELECT FACULTY_ID,COUNT(*)AS NHIEU_NHAT
FROM STUDENT S
JOIN FACULTY F ON S.FACULTY_ID = F.ID
WHERE GENDER ='Nữ' 
GROUP BY FACULTY_ID
ORDER BY NHIEU_NHAT DESC)
WHERE ROWNUM = 1;

-- 7. Cho biết những sinh viên đạt điểm cao nhất trong từng môn
SELECT * FROM EXAM_MANAGEMENT E
JOIN (SELECT SUBJECT_ID ,MAX(MARK) AS DIEM_MAX
FROM EXAM_MANAGEMENT
GROUP BY (SUBJECT_ID)) Y 
ON E.SUBJECT_ID = Y.SUBJECT_ID AND E.MARK = Y. DIEM_MAX;

-- 8. Cho biết những khoa không có sinh viên học
SELECT * FROM FACULTY
WHERE FACULTY.ID NOT IN (
SELECT FACULTY.ID  FROM FACULTY F
JOIN STUDENT S ON F.ID = S.FACULTY_ID);
-- 9. Cho biết sinh viên chưa thi môn cơ sở dữ liệu
SELECT*FROM STUDENT 
WHERE ID NOT IN(
SELECT STUDENT_ID 
FROM EXAM_MANAGEMENT E
JOIN SUBJECT S
ON E.SUBJECT_ID = S.ID
WHERE S.NAME = 'Cơ sở dữ liệu');

-- 10. Cho biết sinh viên nào không thi lần 1 mà có dự thi lần 2
--TH1: KHÔNG CÙNG MÔN HỌC, KHÔNG THI LẦN 1, THI LẦN 2
SELECT B.STUDENT_ID
FROM (SELECT STUDENT_ID 
FROM EXAM_MANAGEMENT
WHERE NUMBER_OF_EXAM_TAKING =2)B
WHERE B.STUDENT_ID NOT IN (SELECT STUDENT_ID 
FROM EXAM_MANAGEMENT
WHERE NUMBER_OF_EXAM_TAKING =1);
--TH2: CÙNG MÔN HỌC, KHÔNG THI LẦN 1, THI LẦN 2
SELECT STUDENT_ID 
FROM (SELECT SUBJECT_ID,STUDENT_ID 
FROM EXAM_MANAGEMENT
WHERE NUMBER_OF_EXAM_TAKING =2)
WHERE STUDENT_ID NOT IN (

SELECT DISTINCT A.STUDENT_ID 
FROM (SELECT SUBJECT_ID,STUDENT_ID 
FROM EXAM_MANAGEMENT
WHERE NUMBER_OF_EXAM_TAKING =1)A
JOIN(SELECT SUBJECT_ID,STUDENT_ID 
FROM EXAM_MANAGEMENT
WHERE NUMBER_OF_EXAM_TAKING =2)B
ON A.STUDENT_ID = B.STUDENT_ID AND A.SUBJECT_ID = B.SUBJECT_ID
);