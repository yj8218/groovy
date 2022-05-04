select * from tbl_employee;

show user;

desc tbl_employee ;


pk_empnum         not null varchar2(20)  
pwd               not null varchar2(200) 
name              not null varchar2(20)  
address           not null varchar2(100) 
detailaddress              varchar2(100) 
extraaddress               varchar2(100) 
postcode          not null varchar2(20)  
phone             not null varchar2(200) 
email             not null varchar2(200) 
birthday          not null date          
gender            not null varchar2(10)  
registerday       not null date          
startday          not null date          
resignationstatus          number(1)     
resignationday             date          
fk_vstatus                 number(1)     
fk_deptnum        not null number        
fk_spotnum        not null number        
emppicturename    not null varchar2(20)  
salary            not null number(20)    


SELECT *
from tbl_employee;

select *
from USER_TAB_COMMENTS
WHERE comments IS NOT NULL;

SELECT * FROM USER_COL_COMMENTS WHERE comments IS NOT NULL; 

SELECT * FROM USER_COL_COMMENTS WHERE comments IS NOT NULL; 

desc tbl_employee;

desc tbl_spot;    
    
select *
from tbl_spot;

select *
from TBL_DEPARTMENT


select *
from tbl_employee;
    
insert into tbl_employee( pk_empnum, pwd, name,  address,  detailaddress,
			 extraaddress, postcode, phone,  email,  birthday, gender,
			 registerday, startday, 
			  fk_deptnum,  fk_spotnum,  emppicturename,  salary)
values('001-01', 'qwer1234$', '관리자', '주소1','주소2','주소3','우편번호','010-1111-1111', 'admin@groovy.com',sysdate,'1',sysdate,sysdate, '01',1,'logo.png','100')

SELECT  pk_empnum, pwd, name,  address,  detailaddress,
			 extraaddress, postcode, phone,  email,  birthday, gender,
			 registerday, startday, resignationstatus,  nvl(resignationday,'2030-12-11'),  fk_vstatus,
			  fk_deptnum,  fk_spotnum,  emppicturename,  salary
		from tbl_employee
		where pk_empnum = '001-01' and pwd= 'qwer1234$';


-- tbl_employee 테이블 lastpwdchangedate  컬럼추가 
-- lastpwdchangedate  date default sysdate     -- 마지막으로 암호를 변경한 날짜 
-- 
alter table tbl_employee add lastpwdchangedate date default sysdate; -- 마지막으로 암호를 변경한 날짜 
COMMENT ON COLUMN tbl_employee.lastpwdchangedate IS '최근암호변경일';


select *
from tbl_employee
order by pk_empnum;

-- 로그인기록 테이블 생성
create table tbl_loginhistory
(fk_empnum   varchar2(20)  not null 
,logindate   date default sysdate not null
,clientip    varchar2(20) not null
,constraint FK_tbl_loginhistory foreign key(fk_empnum) references tbl_employee(pk_empnum)  
);

COMMENT ON TABLE tbl_loginhistory IS '로그인기록';
COMMENT ON COLUMN tbl_loginhistory.fk_empnum IS '사원번호(아이디)';
COMMENT ON COLUMN tbl_loginhistory.clientip IS '사용자 ip';
COMMENT ON COLUMN tbl_loginhistory.logindate IS '로그인일시';


select *
from tbl_loginhistory



    
insert into tbl_employee( pk_empnum, pwd, name,  address,  detailaddress,
			 extraaddress, postcode, phone,  email,  birthday, gender,
			 registerday, startday, 
			  fk_deptnum,  fk_spotnum,  emppicturename,  salary ,lastpwdchangedate)
values('001-02', 'qwer1234$', '이재희', '주소1','주소2','주소3','우편번호','010-3261-3081',
'0jaehui@gmail.com','1996-05-17','2',sysdate,sysdate, '01', '02', '로고그루비.png','100',sysdate)


commit;


select pk_empnum
		from tbl_employee
		where email = '0jaehui@gmail.com' and pk_empnum = '001-02';
        


        
alter table tbl_department add lastpwdchangedate date default sysdate; -- 마지막으로 암호를 변경한 날짜 
COMMENT ON COLUMN tbl_employee.lastpwdchangedate IS '최근암호변경일';

insert into tbl_department( pk_deptnum, deptnameeng, deptnamekor)
values(0, 'Executives', '임원');

commit;

INSERT INTO tbl_employee (pk_empnum,pwd,name,phone,email,birthday,gender,address,detailaddress,extraaddress,postcode,startday,fk_deptnum,fk_spotnum,emppicturename,salary) VALUES ('20170222-01', '9695b88a59a1610320897fa84cb7e144cc51f2984520efb77111d94b402a8382', '김태연', '010-1989-0309', 'ty0309@naver.com', '1989-03-09', '2', '서울 송파구 가락로33길 2', '330호', ' (방이동)', '05643', '2017-02-22', '1', '4', '김태연.jpg', '4500000');
INSERT INTO tbl_employee (pk_empnum,pwd,name,phone,email,birthday,gender,address,detailaddress,extraaddress,postcode,startday,fk_deptnum,fk_spotnum,emppicturename,salary) VALUES ('20170222-02', '9695b88a59a1610320897fa84cb7e144cc51f2984520efb77111d94b402a8382', '이순규', '010-1989-0515', 'sk0515@naver.com', '1989-05-15', '2', '서울 송파구 가락로33길 2', '331호', ' (방이동)', '05643', '2017-02-22', '2', '4', '이순규.jpg', '4500000');
INSERT INTO tbl_employee (pk_empnum,pwd,name,phone,email,birthday,gender,address,detailaddress,extraaddress,postcode,startday,fk_deptnum,fk_spotnum,emppicturename,salary) VALUES ('20170911-01', '9695b88a59a1610320897fa84cb7e144cc51f2984520efb77111d94b402a8382', '티파니', '010-1989-0801', 'fn0801@naver.com', '1989-08-01', '2', '서울 송파구 가락로33길 2', '332호', ' (방이동)', '05643', '2017-09-11', '3', '4', '티파니.jpg', '4500000');
INSERT INTO tbl_employee (pk_empnum,pwd,name,phone,email,birthday,gender,address,detailaddress,extraaddress,postcode,startday,fk_deptnum,fk_spotnum,emppicturename,salary) VALUES ('20171130-01', '9695b88a59a1610320897fa84cb7e144cc51f2984520efb77111d94b402a8382', '김효연', '010-1989-0922', 'hy0922@naver.com', '1989-09-22', '2', '서울 송파구 가락로33길 2', '334호', ' (방이동)', '05643', '2017-11-30', '4', '4', '김효연.jpg', '4500000');
INSERT INTO tbl_employee (pk_empnum,pwd,name,phone,email,birthday,gender,address,detailaddress,extraaddress,postcode,startday,fk_deptnum,fk_spotnum,emppicturename,salary) VALUES ('20171130-02', '9695b88a59a1610320897fa84cb7e144cc51f2984520efb77111d94b402a8382', '권유리', '010-1989-1205', 'yr1205@naver.com', '1989-12-05', '2', '서울 송파구 가락로33길 2', '335호', ' (방이동)', '05643', '2017-11-30', '1', '3', '권유리.jpg', '4000000');
INSERT INTO tbl_employee (pk_empnum,pwd,name,phone,email,birthday,gender,address,detailaddress,extraaddress,postcode,startday,fk_deptnum,fk_spotnum,emppicturename,salary) VALUES ('20180305-01', '9695b88a59a1610320897fa84cb7e144cc51f2984520efb77111d94b402a8382', '최수영', '010-1990-0210', 'sy0210@naver.com', '1990-02-10', '2', '서울 송파구 가락로33길 2', '336호', ' (방이동)', '05643', '2018-03-05', '2', '3', '최수영.jpg', '4000000');
INSERT INTO tbl_employee (pk_empnum,pwd,name,phone,email,birthday,gender,address,detailaddress,extraaddress,postcode,startday,fk_deptnum,fk_spotnum,emppicturename,salary) VALUES ('20180306-01', '9695b88a59a1610320897fa84cb7e144cc51f2984520efb77111d94b402a8382', '임윤아', '010-1990-0530', 'ya0530@naver.com', '1990-05-30', '2', '서울 송파구 가락로33길 2', '337호', ' (방이동)', '05643', '2018-03-06', '3', '3', '임윤아.jpg', '4000000');
INSERT INTO tbl_employee (pk_empnum,pwd,name,phone,email,birthday,gender,address,detailaddress,extraaddress,postcode,startday,fk_deptnum,fk_spotnum,emppicturename,salary) VALUES ('20180522-01', '9695b88a59a1610320897fa84cb7e144cc51f2984520efb77111d94b402a8382', '서주현', '010-1991-0628', 'jh0628@naver.com', '1991-06-28', '2', '서울 송파구 가락로33길 2', '338호', ' (방이동)', '05643', '2018-05-22', '4', '3', '서주현.jpg', '4000000');
INSERT INTO tbl_employee (pk_empnum,pwd,name,phone,email,birthday,gender,address,detailaddress,extraaddress,postcode,startday,fk_deptnum,fk_spotnum,emppicturename,salary) VALUES ('20180522-02', '9695b88a59a1610320897fa84cb7e144cc51f2984520efb77111d94b402a8382', '김석진', '010-1992-1204', 'sj1204@naver.com', '1992-12-04', '1', '서울 동대문구 안암로 6', '210호', ' (신설동)', '18577', '2018-05-22', '1', '3', '김석진.jpg', '4000000');
INSERT INTO tbl_employee (pk_empnum,pwd,name,phone,email,birthday,gender,address,detailaddress,extraaddress,postcode,startday,fk_deptnum,fk_spotnum,emppicturename,salary) VALUES ('20180522-03', '9695b88a59a1610320897fa84cb7e144cc51f2984520efb77111d94b402a8382', '민윤기', '010-1993-0309', 'yk0309@naver.com', '1993-03-09', '1', '서울 동대문구 안암로 6', '211호', ' (신설동)', '18577', '2018-05-22', '2', '3', '민윤기.jpg', '4000000');
INSERT INTO tbl_employee (pk_empnum,pwd,name,phone,email,birthday,gender,address,detailaddress,extraaddress,postcode,startday,fk_deptnum,fk_spotnum,emppicturename,salary) VALUES ('20180711-01', '9695b88a59a1610320897fa84cb7e144cc51f2984520efb77111d94b402a8382', '정호석', '010-1994-0218', 'hs0218@naver.com', '1994-02-18', '1', '서울 동대문구 안암로 6', '212호', ' (신설동)', '18577', '2018-07-11', '3', '3', '정호석.JPG', '4000000');
INSERT INTO tbl_employee (pk_empnum,pwd,name,phone,email,birthday,gender,address,detailaddress,extraaddress,postcode,startday,fk_deptnum,fk_spotnum,emppicturename,salary) VALUES ('20180711-02', '9695b88a59a1610320897fa84cb7e144cc51f2984520efb77111d94b402a8382', '김남준', '010-1994-0912', 'nj0912@naver.com', '1994-09-12', '1', '서울 동대문구 안암로 6', '213호', ' (신설동)', '18577', '2018-07-11', '4', '3', '김남준.jpg', '4000000');
INSERT INTO tbl_employee (pk_empnum,pwd,name,phone,email,birthday,gender,address,detailaddress,extraaddress,postcode,startday,fk_deptnum,fk_spotnum,emppicturename,salary) VALUES ('20180711-03', '9695b88a59a1610320897fa84cb7e144cc51f2984520efb77111d94b402a8382', '박지민', '010-1995-1013', 'jm1013@naver.com', '1995-10-13', '1', '서울 동대문구 안암로 6', '214호', ' (신설동)', '18577', '2018-07-11', '1', '3', '박지민.jpg', '4000000');
INSERT INTO tbl_employee (pk_empnum,pwd,name,phone,email,birthday,gender,address,detailaddress,extraaddress,postcode,startday,fk_deptnum,fk_spotnum,emppicturename,salary) VALUES ('20180711-04', '9695b88a59a1610320897fa84cb7e144cc51f2984520efb77111d94b402a8382', '김태형', '010-1995-1230', 'th1230@naver.com', '1995-12-30', '1', '서울 동대문구 안암로 6', '215호', ' (신설동)', '18577', '2018-07-11', '2', '3', '김태형.jpg', '4000000');
INSERT INTO tbl_employee (pk_empnum,pwd,name,phone,email,birthday,gender,address,detailaddress,extraaddress,postcode,startday,fk_deptnum,fk_spotnum,emppicturename,salary) VALUES ('20180909-01', '9695b88a59a1610320897fa84cb7e144cc51f2984520efb77111d94b402a8382', '전정국', '010-1997-0901', 'jk0901@naver.com', '1997-09-01', '1', '서울 동대문구 안암로 6', '216호', ' (신설동)', '18577', '2018-09-09', '3', '3', '전정국.JPG', '4000000');
INSERT INTO tbl_employee (pk_empnum,pwd,name,phone,email,birthday,gender,address,detailaddress,extraaddress,postcode,startday,fk_deptnum,fk_spotnum,emppicturename,salary) VALUES ('20180909-02', '9695b88a59a1610320897fa84cb7e144cc51f2984520efb77111d94b402a8382', '임나영', '010-1995-1218', 'ny1218@naver.com', '1995-12-18', '2', '서울 은평구 갈현로33가길 2', '1호', ' (갈현동, 성원주택)', '03319', '2018-09-09', '4', '3', '임나영.jpg', '4000000');
INSERT INTO tbl_employee (pk_empnum,pwd,name,phone,email,birthday,gender,address,detailaddress,extraaddress,postcode,startday,fk_deptnum,fk_spotnum,emppicturename,salary) VALUES ('20181201-01', '9695b88a59a1610320897fa84cb7e144cc51f2984520efb77111d94b402a8382', '김청하', '010-1996-0209', 'ch0209@naver.com', '1996-02-09', '2', '서울 은평구 갈현로33가길 2', '2호', ' (갈현동, 성원주택)', '03319', '2018-09-09', '1', '2', '김청하.jpg', '3500000');
INSERT INTO tbl_employee (pk_empnum,pwd,name,phone,email,birthday,gender,address,detailaddress,extraaddress,postcode,startday,fk_deptnum,fk_spotnum,emppicturename,salary) VALUES ('20190201-01', '9695b88a59a1610320897fa84cb7e144cc51f2984520efb77111d94b402a8382', '김세정', '010-1996-0828', 'sj0828@naver.com', '1996-08-28', '2', '서울 은평구 갈현로33가길 2', '3호', ' (갈현동, 성원주택)', '03319', '2019-02-01', '2', '2', '김세정.jpg', '3500000');
INSERT INTO tbl_employee (pk_empnum,pwd,name,phone,email,birthday,gender,address,detailaddress,extraaddress,postcode,startday,fk_deptnum,fk_spotnum,emppicturename,salary) VALUES ('20190201-02', '9695b88a59a1610320897fa84cb7e144cc51f2984520efb77111d94b402a8382', '정채연', '010-1997-1201', 'cy1201@naver.com', '1997-12-01', '2', '서울 은평구 갈현로33가길 2', '4호', ' (갈현동, 성원주택)', '03319', '2019-02-01', '3', '2', '정채연.jpg', '3500000');
INSERT INTO tbl_employee (pk_empnum,pwd,name,phone,email,birthday,gender,address,detailaddress,extraaddress,postcode,startday,fk_deptnum,fk_spotnum,emppicturename,salary) VALUES ('20190201-03', '9695b88a59a1610320897fa84cb7e144cc51f2984520efb77111d94b402a8382', '주결경', '010-1998-1216', 'kk1216@naver.com', '1998-12-16', '2', '서울 은평구 갈현로33가길 2', '5호', ' (갈현동, 성원주택)', '03319', '2019-02-01', '4', '2', '주결경.png', '3500000');
INSERT INTO tbl_employee (pk_empnum,pwd,name,phone,email,birthday,gender,address,detailaddress,extraaddress,postcode,startday,fk_deptnum,fk_spotnum,emppicturename,salary) VALUES ('20200302-01', '9695b88a59a1610320897fa84cb7e144cc51f2984520efb77111d94b402a8382', '김소혜', '010-1999-0719', 'sh0719@naver.com', '1999-07-19', '2', '서울 은평구 갈현로33가길 2', '6호', ' (갈현동, 성원주택)', '03319', '2020-03-02', '1', '2', '김소혜.jpg', '3500000');
INSERT INTO tbl_employee (pk_empnum,pwd,name,phone,email,birthday,gender,address,detailaddress,extraaddress,postcode,startday,fk_deptnum,fk_spotnum,emppicturename,salary) VALUES ('20200302-02', '9695b88a59a1610320897fa84cb7e144cc51f2984520efb77111d94b402a8382', '유연정', '010-1999-0803', 'yj0803@naver.com', '1999-08-03', '2', '서울 은평구 갈현로33가길 2', '7호', ' (갈현동, 성원주택)', '03319', '2020-03-02', '2', '2', '유연정.jpg', '3500000');
INSERT INTO tbl_employee (pk_empnum,pwd,name,phone,email,birthday,gender,address,detailaddress,extraaddress,postcode,startday,fk_deptnum,fk_spotnum,emppicturename,salary) VALUES ('20200302-03', '9695b88a59a1610320897fa84cb7e144cc51f2984520efb77111d94b402a8382', '최유정', '010-1999-1112', 'yj1112@naver.com', '1999-11-12', '2', '서울 은평구 갈현로33가길 2', '8호', ' (갈현동, 성원주택)', '03319', '2020-03-02', '3', '2', '최유정.jpg', '3500000');
INSERT INTO tbl_employee (pk_empnum,pwd,name,phone,email,birthday,gender,address,detailaddress,extraaddress,postcode,startday,fk_deptnum,fk_spotnum,emppicturename,salary) VALUES ('20200302-04', '9695b88a59a1610320897fa84cb7e144cc51f2984520efb77111d94b402a8382', '강미나', '010-1999-1204', 'mn1204@naver.com', '1999-12-04', '2', '서울 은평구 갈현로33가길 2', '9호', ' (갈현동, 성원주택)', '03319', '2020-03-02', '4', '2', '강미나.jpg', '3500000');
INSERT INTO tbl_employee (pk_empnum,pwd,name,phone,email,birthday,gender,address,detailaddress,extraaddress,postcode,startday,fk_deptnum,fk_spotnum,emppicturename,salary) VALUES ('20200609-01', '9695b88a59a1610320897fa84cb7e144cc51f2984520efb77111d94b402a8382', '김도연', '010-1999-1205', 'dy1205@naver.com', '1999-12-05', '2', '서울 은평구 갈현로33가길 2', '10호', ' (갈현동, 성원주택)', '03319', '2020-06-09', '1', '2', '김도연.JPG', '3500000');
INSERT INTO tbl_employee (pk_empnum,pwd,name,phone,email,birthday,gender,address,detailaddress,extraaddress,postcode,startday,fk_deptnum,fk_spotnum,emppicturename,salary) VALUES ('20200609-02', '9695b88a59a1610320897fa84cb7e144cc51f2984520efb77111d94b402a8382', '전소미', '010-2001-0309', 'sm0309@naver.com', '2001-03-09', '2', '서울 은평구 갈현로33가길 2', '11호', ' (갈현동, 성원주택)', '03319', '2020-06-09', '2', '2', '전소미.jpg', '3500000');
INSERT INTO tbl_employee (pk_empnum,pwd,name,phone,email,birthday,gender,address,detailaddress,extraaddress,postcode,startday,fk_deptnum,fk_spotnum,emppicturename,salary) VALUES ('20200609-03', '9695b88a59a1610320897fa84cb7e144cc51f2984520efb77111d94b402a8382', '윤지성', '010-1991-0308', 'js0308@naver.com', '1991-03-08', '1', '서울 강북구 4.19로 1', '9동 9호', ' (수유동)', '01026', '2020-06-09', '3', '2', '윤지성.jpg', '3500000');
INSERT INTO tbl_employee (pk_empnum,pwd,name,phone,email,birthday,gender,address,detailaddress,extraaddress,postcode,startday,fk_deptnum,fk_spotnum,emppicturename,salary) VALUES ('20200902-01', '9695b88a59a1610320897fa84cb7e144cc51f2984520efb77111d94b402a8382', '하성운', '010-1994-0322', 'sw0322@naver.com', '1994-03-22', '1', '서울 강북구 4.19로 1', '9동 10호', ' (수유동)', '01026', '2020-09-02', '4', '2', '하성운.jpg', '3500000');
INSERT INTO tbl_employee (pk_empnum,pwd,name,phone,email,birthday,gender,address,detailaddress,extraaddress,postcode,startday,fk_deptnum,fk_spotnum,emppicturename,salary) VALUES ('20210302-01', '9695b88a59a1610320897fa84cb7e144cc51f2984520efb77111d94b402a8382', '황민현', '010-1995-0809', 'mh0809@naver.com', '1995-08-09', '1', '서울 강북구 4.19로 1', '9동 11호', ' (수유동)', '01026', '2021-03-02', '1', '2', '황민현.jpg', '3500000');
INSERT INTO tbl_employee (pk_empnum,pwd,name,phone,email,birthday,gender,address,detailaddress,extraaddress,postcode,startday,fk_deptnum,fk_spotnum,emppicturename,salary) VALUES ('20210302-02', '9695b88a59a1610320897fa84cb7e144cc51f2984520efb77111d94b402a8382', '옹성우', '010-1995-0825', 'sw0825@naver.com', '1995-08-25', '1', '서울 강북구 4.19로 1', '9동 12호', ' (수유동)', '01026', '2021-03-02', '2', '2', '옹성우.jpg', '3500000');
INSERT INTO tbl_employee (pk_empnum,pwd,name,phone,email,birthday,gender,address,detailaddress,extraaddress,postcode,startday,fk_deptnum,fk_spotnum,emppicturename,salary) VALUES ('20210810-01', '9695b88a59a1610320897fa84cb7e144cc51f2984520efb77111d94b402a8382', '김재환', '010-1996-0527', 'jh0527@naver.com', '1996-05-27', '1', '서울 강북구 4.19로 1', '9동 13호', ' (수유동)', '01026', '2021-08-10', '3', '2', '김재환.jpg', '3500000');
INSERT INTO tbl_employee (pk_empnum,pwd,name,phone,email,birthday,gender,address,detailaddress,extraaddress,postcode,startday,fk_deptnum,fk_spotnum,emppicturename,salary) VALUES ('20210810-02', '9695b88a59a1610320897fa84cb7e144cc51f2984520efb77111d94b402a8382', '강다니엘', '010-1996-1210', 'ne1210@naver.com', '1996-12-10', '1', '서울 강북구 4.19로 1', '9동 14호', ' (수유동)', '01026', '2021-08-10', '4', '2', '강다니엘.jpg', '3500000');
INSERT INTO tbl_employee (pk_empnum,pwd,name,phone,email,birthday,gender,address,detailaddress,extraaddress,postcode,startday,fk_deptnum,fk_spotnum,emppicturename,salary) VALUES ('20220502-01', '9695b88a59a1610320897fa84cb7e144cc51f2984520efb77111d94b402a8382', '박지훈', '010-1999-0529', 'jh0529@naver.com', '1999-05-29', '1', '서울 강북구 4.19로 1', '9동 15호', ' (수유동)', '01026', '2022-05-02', '1', '1', '박지훈.jpg', '3000000');
INSERT INTO tbl_employee (pk_empnum,pwd,name,phone,email,birthday,gender,address,detailaddress,extraaddress,postcode,startday,fk_deptnum,fk_spotnum,emppicturename,salary) VALUES ('20220502-02', '9695b88a59a1610320897fa84cb7e144cc51f2984520efb77111d94b402a8382', '박우진', '010-1999-1102', 'wj1102@naver.com', '1999-11-02', '1', '서울 강북구 4.19로 1', '9동 16호', ' (수유동)', '01026', '2022-05-02', '2', '1', '박우진.jpg', '3000000');
INSERT INTO tbl_employee (pk_empnum,pwd,name,phone,email,birthday,gender,address,detailaddress,extraaddress,postcode,startday,fk_deptnum,fk_spotnum,emppicturename,salary) VALUES ('20220502-03', '9695b88a59a1610320897fa84cb7e144cc51f2984520efb77111d94b402a8382', '배진영', '010-2000-0510', 'jy0510@naver.com', '2000-05-10', '1', '서울 강북구 4.19로 1', '9동 17호', ' (수유동)', '01026', '2022-05-02', '3', '1', '배진영.jpg', '3000000');
INSERT INTO tbl_employee (pk_empnum,pwd,name,phone,email,birthday,gender,address,detailaddress,extraaddress,postcode,startday,fk_deptnum,fk_spotnum,emppicturename,salary) VALUES ('20220502-04', '9695b88a59a1610320897fa84cb7e144cc51f2984520efb77111d94b402a8382', '이대휘', '010-2001-0129', 'dh0129@naver.com', '2001-01-29', '1', '서울 강북구 4.19로 1', '9동 18호', ' (수유동)', '01026', '2022-05-02', '4', '1', '이대휘.jpg', '3000000');
INSERT INTO tbl_employee (pk_empnum,pwd,name,phone,email,birthday,gender,address,detailaddress,extraaddress,postcode,startday,fk_deptnum,fk_spotnum,emppicturename,salary) VALUES ('20220502-05', '9695b88a59a1610320897fa84cb7e144cc51f2984520efb77111d94b402a8382', '라이관린', '010-2001-0923', 'kl0923@naver.com', '2001-09-23', '1', '서울 강북구 4.19로 1', '9동 19호', ' (수유동)', '01026', '2022-05-02', '4', '1', '라이관린.jpg', '3000000');
INSERT INTO tbl_employee (pk_empnum,pwd,name,phone,email,birthday,gender,address,detailaddress,extraaddress,postcode,startday,fk_deptnum,fk_spotnum,emppicturename,salary) VALUES ('20150502-02', '9695b88a59a1610320897fa84cb7e144cc51f2984520efb77111d94b402a8382', '장근석', '010-1987-0926', 'ks0926@naver.com', '1987-09-26', '1', '서울 강북구 4.19로 1', '9동 20호', ' (수유동)', '01026', '2015-05-02', '0', '7', '장근석.jpg', '6000000');
INSERT INTO tbl_employee (pk_empnum,pwd,name,phone,email,birthday,gender,address,detailaddress,extraaddress,postcode,startday,fk_deptnum,fk_spotnum,emppicturename,salary) VALUES ('20150502-03', '9695b88a59a1610320897fa84cb7e144cc51f2984520efb77111d94b402a8382', '권보아', '010-1986-1105', 'ba1105@naver.com', '1986-11-05', '2', '서울 강북구 4.19로 1', '9동 21호', ' (수유동)', '01026', '2015-05-02', '0', '7', '권보아.jpg', '6000000');
INSERT INTO tbl_employee (pk_empnum,pwd,name,phone,email,birthday,gender,address,detailaddress,extraaddress,postcode,startday,fk_deptnum,fk_spotnum,emppicturename,salary) VALUES ('20150502-04', '9695b88a59a1610320897fa84cb7e144cc51f2984520efb77111d94b402a8382', '이승기', '010-1987-0113', 'sk0113@naver.com', '1987-01-13', '1', '서울 강북구 4.19로 1', '9동 22호', ' (수유동)', '01026', '2015-05-02', '1', '6', '이승기.jpg', '5500000');
INSERT INTO tbl_employee (pk_empnum,pwd,name,phone,email,birthday,gender,address,detailaddress,extraaddress,postcode,startday,fk_deptnum,fk_spotnum,emppicturename,salary) VALUES ('20150502-05', '9695b88a59a1610320897fa84cb7e144cc51f2984520efb77111d94b402a8382', '이동욱', '010-1981-1106', 'dw1106@naver.com', '1981-11-06', '1', '서울 강북구 4.19로 1', '9동 23호', ' (수유동)', '01026', '2015-05-02', '2', '6', '이동욱.jpg', '5500000');
INSERT INTO tbl_employee (pk_empnum,pwd,name,phone,email,birthday,gender,address,detailaddress,extraaddress,postcode,startday,fk_deptnum,fk_spotnum,emppicturename,salary) VALUES ('20150822-01', '9695b88a59a1610320897fa84cb7e144cc51f2984520efb77111d94b402a8382', '박가희', '010-1980-1225', 'kh1225@naver.com', '1980-12-25', '2', '서울 강북구 4.19로 1', '9동 24호', ' (수유동)', '01026', '2015-08-22', '3', '6', '박가희.jpg', '5500000');
INSERT INTO tbl_employee (pk_empnum,pwd,name,phone,email,birthday,gender,address,detailaddress,extraaddress,postcode,startday,fk_deptnum,fk_spotnum,emppicturename,salary) VALUES ('20151016-01', '9695b88a59a1610320897fa84cb7e144cc51f2984520efb77111d94b402a8382', '배윤정', '010-1980-0218', 'yj0218@naver.com', '1980-02-18', '2', '서울 강북구 4.19로 1', '9동 25호', ' (수유동)', '01026', '2015-08-22', '4', '6', '배윤정.jpg', '5500000');
INSERT INTO tbl_employee (pk_empnum,pwd,name,phone,email,birthday,gender,address,detailaddress,extraaddress,postcode,startday,fk_deptnum,fk_spotnum,emppicturename,salary) VALUES ('20151016-02', '9695b88a59a1610320897fa84cb7e144cc51f2984520efb77111d94b402a8382', '이석훈', '010-1984-0221', 'sh0221@naver.com', '1984-02-21', '1', '서울 강북구 4.19로 1', '9동 26호', ' (수유동)', '01026', '2015-08-22', '1', '5', '이석훈.jpg', '5000000');
INSERT INTO tbl_employee (pk_empnum,pwd,name,phone,email,birthday,gender,address,detailaddress,extraaddress,postcode,startday,fk_deptnum,fk_spotnum,emppicturename,salary) VALUES ('20160130-01', '9695b88a59a1610320897fa84cb7e144cc51f2984520efb77111d94b402a8382', '신유미', '010-1984-0321', 'ym0321@naver.com', '1984-03-21', '2', '서울 강북구 4.19로 1', '9동 27호', ' (수유동)', '01026', '2016-01-30', '2', '5', '신유미.jpg', '5000000');
INSERT INTO tbl_employee (pk_empnum,pwd,name,phone,email,birthday,gender,address,detailaddress,extraaddress,postcode,startday,fk_deptnum,fk_spotnum,emppicturename,salary) VALUES ('20160225-01', '9695b88a59a1610320897fa84cb7e144cc51f2984520efb77111d94b402a8382', '최영준', '010-1985-0513', 'yj0513@naver.com', '1985-05-13', '1', '서울 강북구 4.19로 1', '9동 28호', ' (수유동)', '01026', '2016-01-30', '3', '5', '최영준.jpg', '5000000');
INSERT INTO tbl_employee (pk_empnum,pwd,name,phone,email,birthday,gender,address,detailaddress,extraaddress,postcode,startday,fk_deptnum,fk_spotnum,emppicturename,salary) VALUES ('20160225-02', '9695b88a59a1610320897fa84cb7e144cc51f2984520efb77111d94b402a8382', '이홍기', '010-1990-0302', 'hk0302@naver.com', '1990-03-02', '1', '서울 강북구 4.19로 1', '9동 29호', ' (수유동)', '01026', '2016-01-30', '4', '5', '이홍기.jpg', '5000000');
INSERT INTO tbl_employee (pk_empnum,pwd,name,phone,email,birthday,gender,address,detailaddress,extraaddress,postcode,startday,fk_deptnum,fk_spotnum,emppicturename,salary) VALUES ('20160225-03', '9695b88a59a1610320897fa84cb7e144cc51f2984520efb77111d94b402a8382', '권재승', '010-1988-0822', 'js0822@naver.com', '1988-08-22', '1', '서울 강북구 4.19로 1', '9동 30호', ' (수유동)', '01026', '2016-01-30', '1', '4', '권재승.jpg', '4500000');
INSERT INTO tbl_employee (pk_empnum,pwd,name,phone,email,birthday,gender,address,detailaddress,extraaddress,postcode,startday,fk_deptnum,fk_spotnum,emppicturename,salary) VALUES ('20160820-01', '9695b88a59a1610320897fa84cb7e144cc51f2984520efb77111d94b402a8382', '김제아', '010-1981-0918', 'ja0918@naver.com', '1981-09-18', '2', '서울 강북구 4.19로 1', '9동 31호', ' (수유동)', '01026', '2016-08-20', '2', '4', '김제아.jpg', '4500000');
INSERT INTO tbl_employee (pk_empnum,pwd,name,phone,email,birthday,gender,address,detailaddress,extraaddress,postcode,startday,fk_deptnum,fk_spotnum,emppicturename,salary) VALUES ('20160820-02', '9695b88a59a1610320897fa84cb7e144cc51f2984520efb77111d94b402a8382', '김치타', '010-1990-0525', 'ct0525@naver.com', '1990-05-25', '2', '서울 강북구 4.19로 1', '9동 32호', ' (수유동)', '01026', '2016-08-20', '3', '4', '김치타.jpg', '4500000');
INSERT INTO tbl_employee (pk_empnum,pwd,name,phone,email,birthday,gender,address,detailaddress,extraaddress,postcode,startday,fk_deptnum,fk_spotnum,emppicturename,salary) VALUES ('20160820-03', '9695b88a59a1610320897fa84cb7e144cc51f2984520efb77111d94b402a8382', '강소유', '010-1991-0912', 'sy0912@naver.com', '1991-09-12', '2', '서울 강북구 4.19로 1', '9동 33호', ' (수유동)', '01026', '2016-08-20', '4', '4', '강소유.jpg', '4500000');
INSERT INTO tbl_employee (pk_empnum,pwd,name,phone,email,birthday,gender,address,detailaddress,extraaddress,postcode,startday,fk_deptnum,fk_spotnum,emppicturename,salary) VALUES ('20150502-01', '9695b88a59a1610320897fa84cb7e144cc51f2984520efb77111d94b402a8382', '이국민', '010-1980-0101', 'km0101@naver.com', '1980-01-01', '1', '서울 강북구 4.19로 1', '9동 34호', ' (수유동)', '01026', '2015-05-02', '0', '8', '이국민.jpg', '6500000');
INSERT INTO tbl_employee (pk_empnum,pwd,name,phone,email,birthday,gender,address,detailaddress,extraaddress,postcode,startday,fk_deptnum,fk_spotnum,emppicturename,salary) VALUES ('admin', '9695b88a59a1610320897fa84cb7e144cc51f2984520efb77111d94b402a8382', '한관리', '010-1995-0502', 'lee517jh@google.com', '1995-05-02', '2', '서울 강북구 4.19로 1', '9동 35호', ' (수유동)', '01026', '2019-03-03', '3', '0', '한관리.jpg', '4000000');

rollback;