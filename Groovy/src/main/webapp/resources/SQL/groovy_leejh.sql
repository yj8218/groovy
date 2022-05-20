select * from tbl_employee;

show user;

desc tbl_employee ;

desc tbl_department;

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


SELECT pk_empnum 
from tbl_employee


SELECT * 
from tbl_employee
   
SELECT * 
from tbl_department     
        
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






		select  pk_empnum, name, address, detailaddress, postcode, 
		        phone, email, birthday, gender, registerday, 
		        startday, resignationstatus,  
		        resignationday,  fk_vstatus,     
		        emppicturename,  salary, lastpwdchangedate, emppicturefilename,
		        spotnamekor, deptnamekor, pk_spotnum
		from
		(
			SELECT  E.pk_empnum, E.name, E.address, E.detailaddress, E.postcode, 
			        E.phone, E.email, E.birthday, E.gender, E.registerday, 
			        to_char(E.startday, 'yyyy-mm-dd') as startday, E.resignationstatus,  
			        E.resignationday,  E.fk_vstatus,     
			        E.emppicturename,  E.salary, E.lastpwdchangedate, E.emppicturefilename,
			        s.spotnamekor, s.pk_spotnum,
			        d.deptnamekor, d.pk_deptnum
			from tbl_employee E
			JOIN TBL_SPOT S 
			ON E.fk_spotnum = S.pk_spotnum
			JOIN TBL_DEPARTMENT D 
			ON E.fk_deptnum = D.pk_deptnum
		) V
		--where 1=1
        	--and pk_deptnum = 1 
        order by pk_deptnum , pk_spotnum desc;
        
        
        
select *
from tbl_department
      
select *
from TBL_LOGINHISTORY
      
select  pk_empnum, pwd, name, address, detailaddress, postcode, 
		        phone, email, birthday, gender, registerday, 
		        startday, resignationstatus,  
		        resignationday,  fk_vstatus,     
		        emppicturename,  salary, lastpwdchangedate, emppicturefilename,
		        spotnamekor, deptnamekor, pk_spotnum
		from
		(
			SELECT  E.pk_empnum, E.pwd, E.name, E.address, E.detailaddress, E.postcode, 
			        E.phone, E.email, E.birthday, E.gender, E.registerday, 
			        to_char(E.startday, 'yyyy-mm-dd') as startday, E.resignationstatus,  
			        E.resignationday,  E.fk_vstatus,     
			        E.emppicturename,  E.salary, E.lastpwdchangedate, E.emppicturefilename,
			        s.spotnamekor, s.pk_spotnum,
			        d.deptnamekor, d.pk_deptnum
			from tbl_employee E
			JOIN TBL_SPOT S 
			ON E.fk_spotnum = S.pk_spotnum
			JOIN TBL_DEPARTMENT D 
			ON E.fk_deptnum = D.pk_deptnum
		) V
		where pk_empnum = '20160225-03' and pwd= '9695b88a59a1610320897fa84cb7e144cc51f2984520efb77111d94b402a8382'
        
        
        
        				select  pk_empnum, name, address, detailaddress, postcode, 
				        phone, email, birthday, gender, registerday, 
				        startday, resignationstatus,  
				        resignationday,  fk_vstatus,     
				        emppicturename,  salary, lastpwdchangedate, emppicturefilename,
				        spotnamekor, deptnamekor, pk_spotnum, pk_deptnum
				from
				(
					SELECT  E.pk_empnum, E.name, E.address, E.detailaddress, E.postcode, 
					        E.phone, E.email, E.birthday, E.gender, E.registerday, 
					        to_char(E.startday, 'yyyy-mm-dd') as startday, E.resignationstatus,  
					        E.resignationday,  E.fk_vstatus,     
					        E.emppicturename,  E.salary, E.lastpwdchangedate, E.emppicturefilename,
					        s.spotnamekor, s.pk_spotnum,
					        d.deptnamekor, d.pk_deptnum
					from tbl_employee E
					JOIN TBL_SPOT S 
					ON E.fk_spotnum = S.pk_spotnum
					JOIN TBL_DEPARTMENT D 
					ON E.fk_deptnum = D.pk_deptnum
				) V
		        order by pk_deptnum , pk_spotnum desc
                
                
                
                
    select deptnamekor
      from tbl_department
      order by  pk_deptnum
      
      
      update tbl_employee set phone = '010-1988-0823'
		where pk_empnum = '20160225-03'
        
        select *
        from tbl_employee
        where email = 'If/PwmT/XzL7aqcQAt2Pdb0A9fQooOGKlE454253+qM='
        where pk_empnum = '20160225-02'
        
        
CREATE TABLE tbl_board (
	pk_board_num      NUMBER         NOT NULL, 
	fk_empnum     NUMBER         NOT NULL,
	fk_deptnum    NUMBER   NOT NULL,    
	subject     VARCHAR2(20)   NOT NULL, -- 게시글 제목
	re_date      DATE           DEFAULT sysdate, -- 작성일자
	re_readcount NUMBER         DEFAULT 0, -- 조회수
	re_grade     NUMBER         NOT NULL, -- 평점
	re_contents  VARCHAR2(1000) NOT NULL, -- 게시글 내용
	re_passwd    VARCHAR2(20)   NOT NULL, -- 글비밀번호
	re_writer    VARCHAR2(10)   NOT NULL,  -- 작성자
    isdelete     VARCHAR2(10)   NOT NULL  -- 삭제유무(0:삭제안함, 1:삭제함)
);


create table tbl_board
(pk_board_seq  number                not null    -- 글번호
,fk_empnum     VARCHAR2(20)                NOT NULL    -- 사용자ID

,b_subject       Nvarchar2(200)        not null    -- 글제목
,b_content       Nvarchar2(2000)       not null    -- 글내용   
,b_pw            varchar2(20)          not null    -- 글암호
,b_readCount     number default 0      not null    -- 글조회수
,b_regDate       date default sysdate  not null    -- 글쓴시간
,b_status        number(1) default 1   not null    -- 글삭제여부   1:사용가능한 글,  0:삭제된글
,b_commentCount  number default 0      not null    -- 댓글의 개수 

,groupno       number                not null    -- 답변글쓰기에 있어서 그룹번호 
                                                 -- 원글(부모글)과 답변글은 동일한 groupno 를 가진다.
                                                 -- 답변글이 아닌 원글(부모글)인 경우 groupno 의 값은 groupno 컬럼의 최대값(max)+1 로 한다.

,fk_seq         number default 0      not null   -- fk_seq 컬럼은 절대로 foreign key가 아니다.!!!!!!
                                                 -- fk_seq 컬럼은 자신의 글(답변글)에 있어서 
                                                 -- 원글(부모글)이 누구인지에 대한 정보값이다.
                                                 -- 답변글쓰기에 있어서 답변글이라면 fk_seq 컬럼의 값은 
                                                 -- 원글(부모글)의 seq 컬럼의 값을 가지게 되며,
                                                 -- 답변글이 아닌 원글일 경우 0 을 가지도록 한다.

,depthno        number default 0       not null  -- 답변글쓰기에 있어서 답변글 이라면
                                                 -- 원글(부모글)의 depthno + 1 을 가지게 되며,
                                                 -- 답변글이 아닌 원글일 경우 0 을 가지도록 한다.

,b_fileName       varchar2(255)                    -- WAS(톰캣)에 저장될 파일명(2020120809271535243254235235234.png)                                       
,b_orgFilename    varchar2(255)                    -- 진짜 파일명(강아지.png)  // 사용자가 파일을 업로드 하거나 파일을 다운로드 할때 사용되어지는 파일명 
,b_fileSize       number                           -- 파일크기  

,constraint PK_tbl_board_seq primary key(pk_board_seq)
,constraint FK_tbl_board_fk_empnum foreign key(fk_empnum) references tbl_employee(pk_empnum)
,constraint CK_tbl_board_status check( b_status in(0,1) )
);
--Table TBL_BOARD이(가) 생성되었습니다.


create sequence boardSeq
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;
--Sequence BOARDSEQ이(가) 생성되었습니다.


-- >> tbl_board 테이블에서 content 컬럼의 데이터타입을 CLOB 타입으로 변경하기 << -- Character Large OBject 4기가까지 해줌.

create table tbl_board_copy
as
select *
from tbl_board;
-- Table TBL_BOARD_COPY이(가) 생성되었습니다.

desc tbl_board;
-- CONTENT      NOT NULL NVARCHAR2(2000)

-- >> CLOB(4GB 까지 저장 가능한 데이터 타입) 타입을 가지는 새로운 컬럼 추가하기 << --
alter table tbl_board
add imsi_content clob;
-- Table TBL_BOARD이(가) 변경되었습니다.

-- >> 기존 컬럼 삭제하기 << --
alter table tbl_board 
drop column b_content;

-- >> 새로 추가한 컬럼의 이름을 변경하기 << --
alter table tbl_board
rename column imsi_content to b_content;

-- >> 새로 추가한 컬럼에 NOT NULL 로 설정하기 << --
alter table tbl_board
modify b_content not null;


select *
from tbl_board;

select *
from TBL_SPOT;

select *
from tbl_employee

select *
from tbl_department

select previousseq, previoussubject
		     , pk_board_seq, fk_empnum,  b_subject, b_content, b_readCount, b_regDate, b_pw 
		     , nextseq, nextsubject 
		     , groupno, fk_seq, depthno
		     , b_fileName, b_orgFilename, b_fileSize
		from 
		(
		    select lag(pk_board_seq,1) over(order by pk_board_seq desc) AS previousseq 
		         , lag(b_subject,1) over(order by pk_board_seq desc) AS previoussubject 
		         
		         , pk_board_seq, fk_empnum, b_subject, b_content, b_readCount
		         , to_char(b_regDate, 'yyyy-mm-dd hh24:mi:ss') as b_regDate
		         , b_pw 
		         
		         , lead(pk_board_seq,1) over(order by pk_board_seq desc) AS nextseq
		         , lead(b_subject,1) over(order by pk_board_seq desc) AS nextsubject
		         
		         , groupno, fk_seq, depthno
		         
		         , b_fileName, b_orgFilename, b_fileSize
		    from tbl_board
		    where b_status = 1
		  --  <if test='searchType != "" and searchWord != "" '>
		  --  and lower(${searchType}) like '%'|| lower(#{searchWord}) ||'%'
		   -- </if>
		) V
		where V.pk_board_seq = 2
        
        
        
        
    
		select seq, fk_userid, name, subject, readCount, regDate, commentCount, 
		       groupno, fk_seq, depthno,
		       fileName
		from 
		(
		    select rownum AS rno,
		           seq, fk_userid, name, subject, readCount, regDate, commentCount,
		           groupno, fk_seq, depthno,
		           fileName 
		    from 
		    ( 
		       select seq, fk_userid, name, subject, readCount,
		              to_char(regDate, 'yyyy-mm-dd hh24:mi:ss') AS regDate, 
		              commentCount,
		              groupno, fk_seq, depthno,
		              fileName 
		        from tbl_board
		        where status = 1
		        <if test='searchType != "" and searchWord != ""'>
		        and lower(${searchType}) like '%'|| lower(#{searchWord}) ||'%'
		        </if>
		        start with fk_seq = 0
		        connect by prior seq = fk_seq 
		        order siblings by groupno desc, seq asc                   
		    ) V 
		) T 
		where rno between #{startRno} and #{endRno}


select pk_empnum , name , deptnamekor,spotnamekor , pk_spotnum , pk_deptnum
from
				(
					SELECT  E.pk_empnum,E.name,
					         s.spotnamekor, s.pk_spotnum,
					        d.deptnamekor, d.pk_deptnum
					from tbl_employee E
					JOIN TBL_SPOT S 
					ON E.fk_spotnum = S.pk_spotnum
					JOIN TBL_DEPARTMENT D 
					ON E.fk_deptnum = D.pk_deptnum
				) V
 order by  pk_spotnum desc , pk_deptnum asc;    
		where pk_empnum = #{pk_empnum} and pwd= #{pwd}
        
delete from tbl_employee 
where pk_empnum = '0-20150502';

commit;

select * 
from tbl_board;

select 
		      PK_BOARD_SEQ, FK_EMPNUM, name, B_SUBJECT, B_CONTENT, B_READCOUNT, B_REGDATE, B_PW 
		     
		     , groupno, fk_seq, depthno
		     , B_FILENAME, B_ORGFILENAME, B_FILESIZE
		from 
		(
		    select 
                  B.PK_BOARD_SEQ, B.FK_EMPNUM, E.name, B.B_SUBJECT, B.B_CONTENT, B.B_READCOUNT
                 ,to_char(B.B_REGDATE, 'yyyy-mm-dd hh24:mi:ss') as  B_REGDATE
                 , B.B_PW 
		     
                 , B.groupno, B.fk_seq, B.depthno
                 , B.B_FILENAME, B.B_ORGFILENAME, B.B_FILESIZE
		         
		    from tbl_board B
            JOIN tbl_employee E
			ON B.FK_EMPNUM = E.PK_EMPNUM
		    where b_status = 1
            order by B.PK_BOARD_SEQ desc
		 --   <if test='searchType != "" and searchWord != "" '>
		--    and lower(${searchType}) like '%'|| lower(#{searchWord}) ||'%'
		  --  </if>
		) V
		where V.PK_BOARD_SEQ = 1


----------------------댓글

create table tbl_board_comment
(pk_cmt_seq           number               not null   -- 댓글번호
,fk_empnum     varchar2(20)         not null   -- 사용자ID
,cmt_name          varchar2(20)         not null   -- 성명
,cmt_content       varchar2(1000)       not null   -- 댓글내용
,cmt_regDate       date default sysdate not null   -- 작성일자
,fk_board_seq     number               not null   -- 원게시물 글번호
,cmt_status        number(1) default 1  not null   -- 글삭제여부
                                               -- 1 : 사용가능한 글,  0 : 삭제된 글
                                               -- 댓글은 원글이 삭제되면 자동적으로 삭제되어야 한다.
,constraint PK_tbl_comment_seq primary key(pk_cmt_seq)
,constraint FK_tbl_comment_userid foreign key(fk_empnum) references tbl_employee(pk_empnum)
,constraint FK_tbl_comment_fk_board_seq foreign key(fk_board_seq) references tbl_board(pk_board_seq) on delete cascade
,constraint CK_tbl_comment_status check( cmt_status in(1,0) ) 
);

create sequence commentSeq
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

desc tbl_board;

alter table tbl_board_comment
add cmt_fileName varchar2(255); -- WAS(톰캣)에 저장될 파일명(2020120809271535243254235235234.png)


alter table tbl_board_comment
add cmt_orgFilename varchar2(255) ;-- 진짜 파일명(강아지.png)  // 사용자가 파일을 업로드 하거나 파일을 다운로드 할때 사용되어지는 파일명  


alter table tbl_board_comment
add cmt_fileSize number; --파일크기

select *
from tbl_employee

select *
from tbl_board_comment;

select *
from tbl_calendar_comment

select pk_cmt_seq, cmt_name, cmt_content, cmt_regDate
    		 , cmt_fileName, cmt_orgFilename, cmt_fileSize 
		from 
		(
		  select row_number() over(order by pk_cmt_seq desc) AS rno
		  		, pk_cmt_seq, cmt_name, cmt_content, to_char(cmt_regDate, 'yyyy-mm-dd hh24:mi:ss') AS cmt_regDate
		    	, nvl(cmt_fileName,' ') AS cmt_fileName
     			, nvl(cmt_orgFilename, ' ') AS cmt_orgFilename
    			, nvl(to_char(cmt_fileSize), ' ') AS cmt_fileSize 
		  from tbl_board_comment
		  where cmt_status = 1 
          and fk_board_seq = 19
		) V 
		where rno between 1 and 3
        
        
 update tbl_board set b_subject = '수정본'
		                   , b_content = '수정합니다'
		where pk_board_seq = 2
        
select *
from tbl_employee
        
update tbl_employee set email= 'BkDdZlgSTZUDVnQL2ysBwijiYaO0uRWV3RLrXnqTwbk' where pk_empnum = '20160130-01';
update tbl_employee set email= 'BkDdZlgSTZUDVnQL2ysBwijiYaO0uRWV4RLrXnqTwbk' where pk_empnum = '20160225-01';
update tbl_employee set email= 'BkDdZlgSTZUDVnQL2ysBwijiYaO0uRWV5RLrXnqTwbk' where pk_empnum = '20160225-02';
update tbl_employee set email= 'BkDdZlgSTZUDVnQL2ysBwijiYaO0uRWV6RLrXnqTwbk' where pk_empnum = '20160225-03';
update tbl_employee set email= 'BkDdZlgSTZUDVnQL2ysBwijiYaO0uRWV7RLrXnqTwbk' where pk_empnum = '20160820-01';
update tbl_employee set email= 'BkDdZlgSTZUDVnQL2ysBwijiYaO0uRWV8RLrXnqTwbk' where pk_empnum = '20160820-02';
update tbl_employee set email= 'BkDdZlgSTZUDVnQL2ysBwijiYaO0uRWV9RLrXnqTwbk' where pk_empnum = '20160820-03';
update tbl_employee set email= 'BkDdZlgSTZUDVnQL2ysBwijiYaO0uRWV10RLrXnqTwbk' where pk_empnum = '20150502-01';
update tbl_employee set email= 'BkDdZlgSTZUDVnQL2ysBwijiYaO0uRWV11RLrXnqTwbk' where pk_empnum = '20170222-01';

commit;