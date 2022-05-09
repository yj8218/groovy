select *
from tbl_employee

-- 결재 카테고리 등록
insert into TBL_APP_CATEGORY (PK_APL_CATEGORYNO, APL_CATEGORYNAME)
values (1, '구매 신청')
   
insert into TBL_APP_CATEGORY (PK_APL_CATEGORYNO, APL_CATEGORYNAME)
values (2, '휴가')

insert into TBL_APP_CATEGORY (PK_APL_CATEGORYNO, APL_CATEGORYNAME)
values (3, '복리 후생')

insert into TBL_APP_CATEGORY (PK_APL_CATEGORYNO, APL_CATEGORYNAME)
values (4, '비용 처리')

insert into TBL_APP_CATEGORY (PK_APL_CATEGORYNO, APL_CATEGORYNAME)
values (5, '업무 신청')

insert into TBL_APP_CATEGORY (PK_APL_CATEGORYNO, APL_CATEGORYNAME)
values (6, '기타')

commit

select *
from TBL_APP_CATEGORY

-- 결재서류 넣기 
insert into TBL_APPROVAL (APL_CATEGORYNO, APL_NO, APL_NAME, APL_IMG)
values (1, 1, '비품 신청', 'fas fa-file-alt fa-4x')

insert into TBL_APPROVAL (APL_CATEGORYNO, APL_NO, APL_NAME, APL_IMG)
values (3, 2, '경조비 신청', 'fas fa-wallet fa-4x')

insert into TBL_APPROVAL (APL_CATEGORYNO, APL_NO, APL_NAME, APL_IMG)
values (4, 3, '출장비 신청', 'fas fa-briefcase fa-4x')

insert into TBL_APPROVAL (APL_CATEGORYNO, APL_NO, APL_NAME, APL_IMG)
values (3, 4, '식비 사용 내역', 'fas fa-burger-soda fa-4x')

insert into TBL_APPROVAL (APL_CATEGORYNO, APL_NO, APL_NAME, APL_IMG)
values (2, 5, '휴가 신청', 'fal fa-mug-hot fa-4x')

insert into TBL_APPROVAL (APL_CATEGORYNO, APL_NO, APL_NAME, APL_IMG)
values (6, 6, '휴직 신청', 'far fa-archive fa-4x')

insert into TBL_APPROVAL (APL_CATEGORYNO, APL_NO, APL_NAME, APL_IMG)
values (5, 7, '신규 프로젝트', 'fal fa-edit fa-4x')

update TBL_APPROVAL set APL_IMG = 'fas fa-folder-plus fa-3x'
where APL_NO = 7

commit;

-- 결재서류 조회


select apl_no, apl_name, apl_img, apl_categoryno, apl_categoryname 
from TBL_APPROVAL A
join TBL_APP_CATEGORY B
on PK_APL_CATEGORYNO = APL_CATEGORYNO
order by apl_no

-- 승인자 참조자 테이블 만들기
create table tbl_approvalPerson
(fk_documentNO   varchar2(60)   -- 문서번호
,fk_apl_no       varchar2(20)  -- 문서종류번호
,fk_empnum       varchar2(20)  -- 승인자
,writeday   date default sysdate -- 승인날짜
,app_status     varchar2(20) default '0'  -- 문서상태 0참조자  1 승인자
);



--  테이블 만들기
create table tbl_approvaldocument
(PK_documentnum   varchar2(60)   not null  -- 문서번호
,fk_apl_no        varchar2(20)   not null  -- 문서종류번호
,fk_empnum        varchar2(20)   not null  -- 작성자
,writeday   date default sysdate      -- 작성날짜
,status     varchar2(20) default '0'  -- 문서상태 0 대기 1 승인중 2 승인완료 3 반려
);


-- 비품신청 
create table tbl_equipment
(fk_documentnum   varchar2(60)   not null  -- 문서번호
,productName varchar2(60)  not null       -- 제품명
,productLink varchar2(200)  not null      -- 제품링크
,productCnt varchar2(20) not null       -- 수량
,productCost varchar2(50)               -- 단가
,productMoney varchar2(50) not null      -- 금액
,productInfo varchar2(50)  not null     -- 사유
);





--- 문서번호
select to_char(sysdate, 'yyyymmddhh24miss')
from dual



-- 회원목록 조회하기 
select PK_empnum, deptnamekor ,name, fk_spotnum
from tbl_employee A
join tbl_spot B
on B.pk_spotNum = A.fk_spotnum
join tbl_department C
on C.PK_deptnum = A.FK_deptnum
where pk_deptnum = 1
order by fk_spotnum desc

select pk_empnum, deptnamekor ,name, fk_spotnum
		from tbl_employee a
		join tbl_spot b
		on b.pk_spotnum = a.fk_spotnum
		join tbl_department c
		on c.pk_deptnum = a.fk_deptnum
		where pk_deptnum = 1
		order by fk_spotnum desc


select *
from tbl_department

select *
from tbl_employee

select pk_empnum, deptnamekor, name
from tbl_employee A
join TBL_DEPARTMENT B
on A.fK_DEPTNUM = B.PK_DEPTNUM
where 1=1
and pk_empnum in( '0-20150502', '20200902-01', '20210302-01');
order by A.FK_SPOTNUM


select *
from tbl_approvaldocument;

select *
from TBL_APP_EQUIP;

select *
from TBL_APPROVALPERSON
order by fk_documentnum, app_status desc



DELETE FROM tbl_approvaldocument
WHERE pk_documentnum = '20220507024415'

DELETE FROM TBL_APP_EQUIP
WHERE pk_documentnum = '20220507024415'

delete from TBL_APPROVALPERSON

commit;



insert into tbl_approvaldocument(PK_DOCUMENTNUM, FK_APL_NO, FK_EMPNUM, WRITEDAY, STATUS)
		values(to_char(sysdate, 'yyyymmddhh24miss'), '1', '001-01', sysdate, '0')

rollback;


-- 승인자 집어 넣기 
select *
from TBL_APPROVALPERSON

-- 20220507181500  예시
INSERT ALL
into TBL_APPROVALPERSON(FK_DOCUMENTNUM, FK_EMPNUM, WRITEDAY, APP_STATUS)
values('20220507181500', '20200902-01', sysdate, '1')
      ,('20220507032317', '20210302-01', sysdate, '1')

-- 실험
INSERT INTO TBL_APPROVALPERSON(FK_DOCUMENTNUM, FK_EMPNUM, WRITEDAY, APP_STATUS)
SELECT '20220507181500', '20200902-01', sysdate, '1' FROM DUAL
UNION ALL
SELECT '20220507032317', '20210302-01', sysdate, '1' FROM DUAL

delete from TBL_APPROVALPERSON


---- 휴가신청

select *
from TBL_VACATION

select *
from TBL_VACATIONLIST



commit

INSERT INTO TBL_VACATION (PK_VSTATUS, VTYPE)
VALUES ( 4, '공가' )

select nvl(vtype,'휴가 종류 선택') as vtype
from TBL_VACATION  






