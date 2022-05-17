---------------------------
select SD.pk_scheduleno
		     , to_char(SD.startdate,'yyyy-mm-dd hh24:mi') as startdate
		     , to_char(SD.enddate,'yyyy-mm-dd hh24:mi') as enddate  
		     , SD.subject
		     , SD.color
		     , nvl(SD.place,'-') as place
		     , nvl(SD.joinuser,'공유자가 없습니다.') as joinuser
		     , nvl(SD.content,'') as content
		     , SD.fk_smcatgono
		     , SD.fk_lgcatgono
		     , SD.fk_empnum
		     , M.name
		     , SC.smcatgoname
		     , LC.lgcatgoname
		     , SD.vote
		     , nvl(SD.placename, '') as placename
		     , nvl(SD.addressname, '') as addressname
		     , nvl(SD.placephone, '') as placephone
		     , nvl(SD.roadaddressname, '-') as roadaddressname
		     , SD.regdate
		     , nvl(SD.orgfilename, '-') as orgfilename
		     , M.emppicturename
		     , S.spotnamekor
		     , D.deptnamekor
		from tbl_calendar_schedule SD 
		JOIN tbl_employee M
		ON SD.fk_empnum = M.pk_empnum
		JOIN tbl_calendar_small_category SC
		ON SD.fk_smcatgono = SC.pk_smcatgono
		JOIN tbl_calendar_large_category LC
		ON SC.fk_lgcatgono = LC.pk_lgcatgono
		JOIN tbl_spot S
		ON M.fk_spotnum = S.pk_spotnum
		JOIN tbl_department D
		ON M.fk_deptnum = D.pk_deptnum
		
		where SD.pk_scheduleno = 25

---------------
--pk_empnum
--fk_empnum

--pk_lgcatgono
--pk_scheduleno
--pk_smcatgono

--세션
ALTER TABLE FINALORAUSER2.TBL_CALENDAR_SCHEDULE MODIFY VOTE NUMBER(2);

select pk_empnum, name
		from tbl_employee
		where lower(name) like '%'|| lower('a') ||'%' or lower(pk_empnum) like '%'|| lower('a') ||'%'
        
select pk_empnum, name
from tbl_employee
where lower(name) like '%'|| lower('') ||'%'       
------------- >>>>>>>> 일정관리(풀캘린더) 시작 <<<<<<<< -------------

-- *** 캘린더 대분류(내캘린더, 사내캘린더  분류) ***
create table tbl_calendar_large_category 
(pk_lgcatgono   number(3) not null      -- 캘린더 대분류 번호
,lgcatgoname varchar2(50) not null   -- 캘린더 대분류 명
,constraint PK_tbl_calendar_large_category primary key(pk_lgcatgono)
);
-- Table TBL_CALENDAR_LARGE_CATEGORY이(가) 생성되었습니다.

insert into tbl_calendar_large_category(pk_lgcatgono, lgcatgoname)
values(1, '내캘린더');

insert into tbl_calendar_large_category(pk_lgcatgono, lgcatgoname)
values(2, '사내캘린더');

commit;
-- 커밋 완료.

select * 
from tbl_calendar_large_category;


-- *** 캘린더 소분류 *** 
-- (예: 내캘린더중 점심약속, 내캘린더중 저녁약속, 내캘린더중 운동, 내캘린더중 휴가, 내캘린더중 여행, 내캘린더중 출장 등등) 
-- (예: 사내캘린더중 플젝주제선정, 사내캘린더중 플젝요구사항, 사내캘린더중 DB모델링, 사내캘린더중 플젝코딩, 사내캘린더중 PPT작성, 사내캘린더중 플젝발표 등등) 
create table tbl_calendar_small_category 
(pk_smcatgono    number(8) not null      -- 캘린더 소분류 번호
,fk_lgcatgono number(3) not null      -- 캘린더 대분류 번호
,smcatgoname  varchar2(400) not null  -- 캘린더 소분류 명
,fk_empnum    varchar2(20) not null   -- 캘린더 소분류 작성자 유저아이디
,constraint PK_tbl_calendar_small_category primary key(pk_smcatgono)
,constraint FK_small_category_fk_lgcatgono foreign key(fk_lgcatgono) 
            references tbl_calendar_large_category(pk_lgcatgono) on delete cascade
,constraint FK_small_category_fk_userid foreign key(fk_empnum) references tbl_employee(pk_empnum)
);
-- Table TBL_CALENDAR_SMALL_CATEGORY이(가) 생성되었습니다.


create sequence seq_smcatgono
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;
-- Sequence SEQ_SMCATGONO이(가) 생성되었습니다.


select *
from tbl_calendar_small_category
order by smcatgono desc;


-- *** 캘린더 일정 *** 
create table tbl_calendar_schedule 
(pk_scheduleno    number                 -- 일정관리 번호
,startdate     date                   -- 시작일자
,enddate       date                   -- 종료일자
,subject       varchar2(400)          -- 제목
,color         varchar2(50)           -- 색상
,place         varchar2(200)          -- 장소
,joinuser      varchar2(4000)         -- 공유자	
,content       varchar2(4000)         -- 내용	
,fk_smcatgono  number(8)              -- 캘린더 소분류 번호
,fk_lgcatgono  number(3)              -- 캘린더 대분류 번호
,fk_empnum     varchar2(40) not null  -- 캘린더 일정 작성자 유저아이디
,constraint PK_schedule_scheduleno primary key(pk_scheduleno)
,constraint FK_schedule_fk_smcatgono foreign key(fk_smcatgono) 
            references tbl_calendar_small_category(pk_smcatgono) on delete cascade
,constraint FK_schedule_fk_lgcatgono foreign key(fk_lgcatgono) 
            references tbl_calendar_large_category(pk_lgcatgono) on delete cascade	
,constraint FK_schedule_fk_userid foreign key(fk_empnum) references tbl_employee(pk_empnum)
);
-- Table TBL_CALENDAR_SCHEDULE이(가) 생성되었습니다.

create sequence seq_scheduleno
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;
-- Sequence SEQ_SCHEDULENO이(가) 생성되었습니다.

select *
from tbl_calendar_schedule 
order by scheduleno desc;


-- 일정 상세 보기
select SD.scheduleno
     , to_char(SD.startdate,'yyyy-mm-dd hh24:mi') as startdate
     , to_char(SD.enddate,'yyyy-mm-dd hh24:mi') as enddate  
     , SD.subject
     , SD.color
     , nvl(SD.place,'-') as place
     , nvl(SD.joinuser,'공유자가 없습니다.') as joinuser
     , nvl(SD.content,'') as content
     , SD.fk_smcatgono
     , SD.fk_lgcatgono
     , SD.fk_userid
     , M.name
     , SC.smcatgoname
from tbl_calendar_schedule SD 
JOIN tbl_member M
ON SD.fk_userid = M.userid
JOIN tbl_calendar_small_category SC
ON SD.fk_smcatgono = SC.smcatgono
where SD.scheduleno = 21;

------------- >>>>>>>> 일정관리(풀캘린더) 끝 <<<<<<<< -------------