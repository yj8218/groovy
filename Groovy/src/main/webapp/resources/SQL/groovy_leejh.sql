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

desc tbl_employee;
        
        
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
from tbl_employee;


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
		where email = '0jaehui@gmail.com' and pk_empnum = '001-02'