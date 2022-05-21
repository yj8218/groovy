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
from tbl_approvaldocument
order by writeday

select *
from TBL_APP_EQUIP;

select *
from TBL_APPROVALPERSON
where 
order by fk_documentnum, app_status desc



DELETE FROM tbl_approvaldocument
WHERE pk_documentnum in ('20220518000605596',
'20220518000628761',
'20220518000635194',
'20220518000641026',
'20220518000642123',
'20220518001509473',
'20220518001527108',
'20220518001528141',
'20220518001537410',
'20220518001539667',
'20220518001547459',
'20220518002710052',
'20220518002945282',
'20220518151803012',
'20220518151835526',
'20220518151859748',
'20220518152434876',
'20220518153547367')

DELETE FROM TBL_APP_EQUIP
WHERE pk_documentnum in ('20220518000635194',
'20220518000605596',
'20220518000628761',
'20220518000641026',
'20220518000642123',
'20220518001528141',
'20220518001509473',
'20220518001527108',
'20220518001537410',
'20220518001539667',
'20220518001547459',
'20220518002710052',
'20220518002945282',
'20220518153547367',
'20220518151803012',
'20220518151835526') 

delete from TBL_APPROVALPERSON
WHERE fk_documentnum = '20220512171146349'
commit;

rollback

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


DELETE FROM tbl_approvaldocument


DELETE FROM TBL_VACATIONLIST


delete from TBL_APPROVALPERSON


commit

INSERT INTO TBL_VACATION (PK_VSTATUS, VTYPE)
VALUES ( 4, '공가' )

select nvl(vtype,'휴가 종류 선택') as vtype
from TBL_VACATION  

select *
from tbl_approvaldocument;
select *
from TBL_APP_BUSINESS

DELETE FROM tbl_approvaldocument

DELETE FROM TBL_APP_BUSINESS

delete from TBL_APPROVALPERSON

commit


select *
from TBL_APP_FOOD
select *
from tbl_approvaldocument
select *
from TBL_APPROVALPERSON

DELETE FROM tbl_approvaldocument
where pk_documentnum in(20220515015548415, 20220515020133521)
DELETE FROM TBL_APP_FOOD
where pk_documentnum in(20220515015548415, 20220515020133521)

delete from TBL_APPROVALPERSON

commit

select *
from TBL_APP_ABSENCE
select *
from tbl_approvaldocument
select *
from TBL_APPROVALPERSON

DELETE FROM tbl_approvaldocument

DELETE FROM TBL_APP_ABSENCE

delete from TBL_APPROVALPERSON

commit

select *
from TBL_APP_PROJECT

select *
from tbl_approvaldocument

select *
from TBL_APPROVALPERSON

DELETE FROM tbl_approvaldocument

DELETE FROM TBL_APP_PROJECT

delete from TBL_APPROVALPERSON


-- 내 전자결재 문서 조회하기 
select rownum as rno, PK_DOCUMENTNUM, apl_no, FK_EMPNUM , to_char(WRITEDAY, 'yyyy-mm-dd') as WRITEDAY, STATUS, apl_name
from tbl_approvaldocument A join TBL_APPROVAL B
on A.FK_APL_NO = B.apl_no
where fk_empNum = '20200902-01'

select *
from TBL_APPROVAL

UPDATE TBL_APPROVAL SET APL_CATEGORYNO = 5 WHERE apl_no = 7

commit;

select *
from tbl_app_category

rollback;
--전자결재 문서 상세조회하기


-- 비품상세정보
select rownum as rno, A.pk_documentnum as pk_documentnum, A.fk_empnum as fk_empnum, A.status as status, 
d.productname as productname, d.productlink as productlink,d.productcnt as productcnt,d.productcost as productcost,
d.productmoney as productmoney,d.productinfo as productinfo
from tbl_approvaldocument A 
join TBL_APPROVAL B
on A.FK_APL_NO = B.apl_no
join tbl_app_equip D
on A.PK_DOCUMENTNUM = D.PK_DOCUMENTNUM
where A.PK_DOCUMENTNUM = '20220511154713274'


-- 승인자 참조자
select C.fK_empnum, app_status, F.pk_spotnum, E.name, F.spotnamekor, C.appyn, DEPTNAMEKOR
from tbl_approvaldocument A 
join TBL_APPROVAL B
on A.FK_APL_NO = B.apl_no
join tbl_approvalperson C
on A.PK_DOCUMENTNUM = C.fK_DOCUMENTNUM
join tbl_employee E
on C.fk_empnum = E.pk_empnum
join TBL_SPOT F
on E.fk_spotnum = F.pk_spotnum
join TBL_DEPARTMENT G
on G.PK_DEPTNUM = E.FK_DEPTNUM
where A.PK_DOCUMENTNUM = '20220512173514892'
order by DEPTNAMEKOR, fk_spotnum desc

-- 출장비 상세정보
select rownum as rno, A.pk_documentnum, A.fk_empnum, A.status, 
BUSINESSREGION, BUSINESSSTARTDATE, BUSINESSENDDATE, BUSINESSPURPOSE, BUSINESSMONEY, FILENAME, ORGFILENAME, FILESIZE
from tbl_approvaldocument A 
join TBL_APPROVAL B
on A.FK_APL_NO = B.apl_no
join TBL_APP_BUSINESS D
on A.PK_DOCUMENTNUM = D.PK_DOCUMENTNUM
where A.PK_DOCUMENTNUM = '20220511154713274'

-- 식비 상세정보
select rownum as rno, A.pk_documentnum, A.fk_empnum, A.status, 
FOODEXPENSESDATE, FOODEXPENSESCOST, FOODEXPENSESPERSONCNT, FOODEXPENSESETC, FILENAME, ORGFILENAME, FILESIZE
from tbl_approvaldocument A 
join TBL_APPROVAL B
on A.FK_APL_NO = B.apl_no
join TBL_APP_FOOD D
on A.PK_DOCUMENTNUM = D.PK_DOCUMENTNUM
where A.PK_DOCUMENTNUM = '20220511154713274'

-- 휴가 상세정보
select rownum as rno, A.pk_documentnum, A.fk_empnum, A.status, 
PK_VSTATUS, VTYPE, VSTARTDATE, VENDDATE, VINFO, VETC
from tbl_approvaldocument A 
join TBL_APPROVAL B
on A.FK_APL_NO = B.apl_no
join TBL_VACATIONLIST D
on A.PK_DOCUMENTNUM = D.PK_DOCUMENTNUM
join TBL_VACATION E 
on D.FK_VSTATUS = E.PK_VSTATUS
where A.PK_DOCUMENTNUM = '20220511154713274'

-- 휴직 상세정보
select rownum as rno, A.pk_documentnum, A.fk_empnum, A.status, 
ABSENCESTARTDATE, ABSENCEENDDATE, ABSENCEINFO, ABSENCEETC
from tbl_approvaldocument A 
join TBL_APPROVAL B
on A.FK_APL_NO = B.apl_no
join TBL_APP_ABSENCE D
on A.PK_DOCUMENTNUM = D.PK_DOCUMENTNUM
where A.PK_DOCUMENTNUM = '20220511154713274'


-- 새프로젝트신청 상세정보
select rownum as rno, A.pk_documentnum, A.fk_empnum, A.status, 
PROJECTNAME, PROJECTSTARTDATE, PROJECTENDDATE, PROJECTPERSONCNT, PROJECTPERSONLIST, FILENAME, ORGFILENAME, FILESIZE
from tbl_approvaldocument A 
join TBL_APPROVAL B
on A.FK_APL_NO = B.apl_no
join TBL_APP_PROJECT D
on A.PK_DOCUMENTNUM = D.PK_DOCUMENTNUM
where A.PK_DOCUMENTNUM = '20220511154713274'

--  내 결제대기문서 조회
select rownum as rno ,c.pk_documentnum ,to_char(C.writeday, 'yyyy-mm-dd') as writeday, d.apl_name, c.fk_empnum, a.name, e.deptnamekor, spotnamekor, status
from TBL_APPROVALPERSON B
join TBL_APPROVALDOCUMENT C
on B.fK_DOCUMENTNUM = C.PK_DOCUMENTNUM
join TBL_APPROVAL D
on C.FK_APL_NO = D.apl_no
join tbl_employee A
on C.fk_empnum = A.pk_empnum
join tbl_department E
on A.fk_deptnum = E.PK_DEPTNUM
join tbl_spot F
on F.PK_SPOTNUM = A.fK_SPOTNUM
where B.fk_empnum = '20160225-03' and B.app_status = '1' and APPYN = '0' 


select *
from TBL_APPROVALPERSON

select *
from TBL_APP_FOOD

-- 결재승인하기 
update TBL_APPROVALPERSON set writeday = sysdate , appyn='0', opinion='결제승인완료'
where fk_documentnum = '20220512150611790' 
and fk_empnum = '20160225-03' 

rollback
commit
-- 결재 승인자 남은 인원 조회하기 
select count(*)
from TBL_APPROVALPERSON
where fk_documentnum = '20220512150611790' 
and app_status = '1' 
and appyn='0'

-- 남은결재자가 없는 경우 문서상태변경
update TBL_APPROVALDOCUMENT set status = '2'
where fk_documentnum = '20220512150611790' 
 

select rownum as rno, A.pk_documentnum, A.fk_empnum, A.status, 
		foodexpensesdate, foodexpensescost, foodexpensespersoncnt, foodexpensesetc, filename, orgfilename, filesize
		from tbl_approvaldocument A 
		join TBL_APPROVAL B
		on A.FK_APL_NO = B.apl_no
		join TBL_APP_FOOD D
		on A.PK_DOCUMENTNUM = D.PK_DOCUMENTNUM
		where A.PK_DOCUMENTNUM = '20220512150611790'










-- 나의 결재 정보조회
select rownum as rno, pk_documentnum, apl_no, fk_empnum , to_char(WRITEDAY, 'yyyy-mm-dd') as writeday
, status, apl_name, DEPTNAMEKOR
from tbl_approvaldocument A join TBL_APPROVAL B
on A.FK_APL_NO = B.apl_no
join tbl_employee C
on A.fk_empnum = C.pk_empnum
join tbl_department D
on C.fk_deptnum = D.PK_DEPTNUM
where fk_empNum = '20200902-01' 
and status = '0'


-- 내 결제정보 토탈 페이지
select count(*)
from tbl_approvaldocument A join TBL_APPROVAL B
on A.FK_APL_NO = B.apl_no
join tbl_employee C
on A.fk_empnum = C.pk_empnum
join tbl_department D
on C.fk_deptnum = D.PK_DEPTNUM
where fk_empNum = '20200902-01'

--- 내결재정보 페이징처리
select rno, pk_documentnum, apl_no, fk_empnum, writeday, status, apl_name, DEPTNAMEKOR
from 
(
select rownum as rno, pk_documentnum, apl_no, fk_empnum , to_char(WRITEDAY, 'yyyy-mm-dd') as writeday
, status, apl_name, DEPTNAMEKOR
from tbl_approvaldocument A join TBL_APPROVAL B
on A.FK_APL_NO = B.apl_no
join tbl_employee C
on A.fk_empnum = C.pk_empnum
join tbl_department D
on C.fk_deptnum = D.PK_DEPTNUM
where fk_empNum = '20200902-01'
) 
where rno between 1 and 5


select A.fk_empnum, fk_spotnum
from TBL_APPROVALPERSON A
join tbl_employee B
on A.fk_empnum = B.pk_empnum
where fk_documentnum = '20220512015430750'
and app_status = '1'
and appyn = '0'

select rownum as rno, C.pk_documentnum ,to_char(C.writeday, 'yyyy-mm-dd') as writeday, D.apl_name, C.fk_empnum, A.name, E.deptnamekor, spotnamekor, apl_no
		from TBL_APPROVALPERSON B
		join TBL_APPROVALDOCUMENT C
		on B.fK_DOCUMENTNUM = C.PK_DOCUMENTNUM
		join TBL_APPROVAL D
		on C.FK_APL_NO = D.apl_no
		join tbl_employee A
		on C.fk_empnum = A.pk_empnum
		join tbl_department E
		on A.fk_deptnum = E.PK_DEPTNUM
		join tbl_spot F
		on F.PK_SPOTNUM = A.fK_SPOTNUM
		where B.fk_empnum = '20170222-01' and APPYN in('1','2')


select *
from TBL_APPROVALPERSON



select * FROM TBL_APPROVALPERSON
WHERE fk_documentnum = '20220512173434223'





select rownum as rno, C.pk_documentnum ,to_char(C.writeday, 'yyyy-mm-dd') as writeday, D.apl_name, C.fk_empnum, A.name, E.deptnamekor, spotnamekor, apl_no
		from TBL_APPROVALPERSON B
		join TBL_APPROVALDOCUMENT C
		on B.fK_DOCUMENTNUM = C.PK_DOCUMENTNUM
		join TBL_APPROVAL D
		on C.FK_APL_NO = D.apl_no
		join tbl_employee A
		on C.fk_empnum = A.pk_empnum
		join tbl_department E
		on A.fk_deptnum = E.PK_DEPTNUM
		join tbl_spot F
		on F.PK_SPOTNUM = A.fK_SPOTNUM
		where B.fk_empnum = '20150502-04' and B.app_status = '1' and APPYN = '0'

select filename, orgfilename, filesize
from TBL_APP_FOOD 



select rno, pk_documentnum, apl_no, fk_empnum, writeday, status, apl_name, deptnamekor
from
(	
    select rownum as rno, pk_documentnum, apl_no, fk_empnum, writeday, status, apl_name, deptnamekor
    from 
    (
        select C.pk_documentnum ,to_char(C.writeday, 'yyyy-mm-dd') as writeday, D.apl_name, status, C.fk_empnum, A.name, E.deptnamekor, spotnamekor, apl_no
        from TBL_APPROVALPERSON B
        join TBL_APPROVALDOCUMENT C
        on B.fK_DOCUMENTNUM = C.PK_DOCUMENTNUM
        join TBL_APPROVAL D
        on C.FK_APL_NO = D.apl_no
        join tbl_employee A
        on C.fk_empnum = A.pk_empnum
        join tbl_department E
        on A.fk_deptnum = E.PK_DEPTNUM
        join tbl_spot F
        on F.PK_SPOTNUM = A.fK_SPOTNUM
        where B.fk_empnum = '20170222-01' and B.app_status = '1' and APPYN = '0'
        order by writeday desc
    )
)	 
where rno between 1 and 5	


select count(*)
from TBL_APPROVALPERSON B
join TBL_APPROVALDOCUMENT C
on B.fK_DOCUMENTNUM = C.PK_DOCUMENTNUM
join TBL_APPROVAL D
on C.FK_APL_NO = D.apl_no
join tbl_employee A
on C.fk_empnum = A.pk_empnum
join tbl_department E
on A.fk_deptnum = E.PK_DEPTNUM
join tbl_spot F
on F.PK_SPOTNUM = A.fK_SPOTNUM
where B.fk_empnum = '20170222-01' and B.app_status = '1' and APPYN = '0'


-- 참조자 승인자 검색 --
select pk_empnum, deptnamekor ,name, fk_spotnum, fk_deptnum
from tbl_employee a
join tbl_spot b
on b.pk_spotnum = a.fk_spotnum
join tbl_department c
on c.pk_deptnum = a.fk_deptnum
where pk_empnum != '20170222-01' 
and name like '%김%'
order by fk_spotnum desc



select *
from tbl_approvaldocument
order by writeday

select *
from TBL_APP_EQUIP;

select *
from TBL_APPROVALPERSON
where 
order by fk_documentnum, app_status desc


select *
from TBL_APP_EQUIP A
join TBL_APPROVALPERSON B
on A.pk_documentNum = B.fk_documentNum



select *
from tbl_spot


select deptnamekor, name, spotnamekor
from TBL_EMPLOYEE A
join TBL_DEPARTMENT B
on A.fk_deptnum = B.pk_deptnum
join tbl_spot C
on A.fk_spotnum = C.pk_spotnum
order by fk_spotnum





select rownum as rno, C.pk_documentnum ,to_char(C.writeday, 'yyyy-mm-dd') as writeday, D.apl_name, C.fk_empnum, A.name, E.deptnamekor, spotnamekor, apl_no
				, status
from TBL_APPROVALDOCUMENT C
join TBL_APPROVAL D
on C.FK_APL_NO = D.apl_no
join tbl_employee A
on C.fk_empnum = A.pk_empnum
join tbl_department E
on A.fk_deptnum = E.PK_DEPTNUM
join tbl_spot F
on F.PK_SPOTNUM = A.fK_SPOTNUM
order by writeday desc


-------------------

select pk_spotnum
from TBL_EMPLOYEE A
join TBL_DEPARTMENT B
on A.fk_deptnum = B.pk_deptnum
join tbl_spot C
on A.fk_spotnum = C.pk_spotnum
where pk_empnum = '20170222-01'

select deptnamekor, name, spotnamekor, pk_spotnum
from TBL_EMPLOYEE A
join TBL_DEPARTMENT B
on A.fk_deptnum = B.pk_deptnum
join tbl_spot C
on A.fk_spotnum = C.pk_spotnum
where pk_empnum = '20150502-04'

select rno, pk_documentnum, apl_no, fk_empnum, writeday, status, apl_name, deptnamekor
from
(	
    select rownum as rno, pk_documentnum, apl_no, fk_empnum, writeday, status, apl_name, deptnamekor
    from 
    (
        select C.pk_documentnum ,to_char(C.writeday, 'yyyy-mm-dd') as writeday, D.apl_name, C.fk_empnum, A.name, E.deptnamekor, spotnamekor, apl_no, status
        from TBL_APPROVALPERSON B
        join TBL_APPROVALDOCUMENT C
        on B.fK_DOCUMENTNUM = C.PK_DOCUMENTNUM
        join TBL_APPROVAL D
        on C.FK_APL_NO = D.apl_no
        join tbl_employee A
        on C.fk_empnum = A.pk_empnum
        join tbl_department E
        on A.fk_deptnum = E.PK_DEPTNUM
        join tbl_spot F
        on F.PK_SPOTNUM = A.fK_SPOTNUM
        where B.fk_empnum = '20150502-04' and B.app_status = '1' and APPYN = '0' and status = '0'
        order by writeday desc
    )
)	 
where rno between 1 and 20	


select pk_spotnum
from TBL_EMPLOYEE A
join TBL_DEPARTMENT B
on A.fk_deptnum = B.pk_deptnum
join tbl_spot C
on A.fk_spotnum = C.pk_spotnum
where pk_empnum = '20170222-01'

select fk_documentnum ,min(fk_spotnum) as minSpotnum
from tbl_approvalPerson A
join tbl_approvalDocument B
on A.fk_documentnum = B.pk_documentnum
join tbl_employee C
on A.fk_empnum = C.pk_empnum
join tbl_spot D
on C.fk_spotnum = D.pk_spotnum
join 
(
    select pk_spotnum
    from TBL_EMPLOYEE A
    join TBL_DEPARTMENT B
   on A.fk_deptnum = B.pk_deptnum
    join tbl_spot C
    on A.fk_spotnum = C.pk_spotnum
    where pk_empnum = '20150502-04'
) E
on D.pk_spotnum = E.pk_spotnum
where app_status = '1' and  APPYN = '0' and E.pk_spotnum = D.pk_spotnum
group by fk_documentnum

select fk_documentnum, minSpotnum
from 
(
    select fk_documentnum ,min(fk_spotnum) as minSpotnum
    from tbl_approvalPerson A
    join tbl_approvalDocument B
    on A.fk_documentnum = B.pk_documentnum
    join tbl_employee C
    on A.fk_empnum = C.pk_empnum
    join tbl_spot D
    on C.fk_spotnum = D.pk_spotnum
    where app_status = '1' and  APPYN = '0'
    group by fk_documentnum
) M
join 
(
    select fk_documentnum ,min(fk_spotnum) as minSpotnum
    from tbl_approvalPerson A
    join tbl_approvalDocument B
    on A.fk_documentnum = B.pk_documentnum
    join tbl_employee C
    on A.fk_empnum = C.pk_empnum
    join tbl_spot D
    on C.fk_spotnum = D.pk_spotnum
    where app_status = '1' and  APPYN = '0'
    and pk_empnum = '20150502-04'
    group by fk_documentnum
) T
on T.fk_documentnum = M.fk_documentnum


select nvl(vacationdate, 0) as vacationdate
from tbl_employee
where pk_empnum = '20200902-01'

update tbl_employee set VACATIONDATE = '104' where fk_spotnum = '7'

select *
from tbl_spot

select C.pk_documentnum ,to_char(C.writeday, 'yyyy-mm-dd') as writeday, D.apl_name, C.fk_empnum, A.name, E.deptnamekor, spotnamekor, apl_no, status
				from TBL_APPROVALPERSON B
				join TBL_APPROVALDOCUMENT C
				on B.fK_DOCUMENTNUM = C.PK_DOCUMENTNUM
				join TBL_APPROVAL D
				on C.FK_APL_NO = D.apl_no
				join tbl_employee A
				on C.fk_empnum = A.pk_empnum
				join tbl_department E
				on A.fk_deptnum = E.PK_DEPTNUM
				join tbl_spot F
				on F.PK_SPOTNUM = A.fK_SPOTNUM
				where B.fk_empnum = '20170222-01' and B.app_status = '1' and APPYN = '0' and status = '0' 
				--and C.pk_documentnum in ()
				order by C.writeday desc


-- '20220519143550711', '20220520102918180', '20220519143019920', '20220519143516211', '20220519143458552', '20220519143301178'





select M.fk_documentnum, M.minSpotnum
from 
(
    select fk_documentnum ,min(fk_spotnum) as minSpotnum
    from tbl_approvalPerson A
    join tbl_approvalDocument B
    on A.fk_documentnum = B.pk_documentnum
    join tbl_employee C
    on A.fk_empnum = C.pk_empnum
    join tbl_spot D
    on C.fk_spotnum = D.pk_spotnum
    where app_status = '1' and  APPYN = '0'
    group by fk_documentnum
) M
join 
(
    select fk_documentnum ,min(fk_spotnum) as minSpotnum
    from tbl_approvalPerson AA
    join tbl_approvalDocument BB
    on AA.fk_documentnum = BB.pk_documentnum
    join tbl_employee CC
    on AA.fk_empnum = CC.pk_empnum
    join tbl_spot DD
    on CC.fk_spotnum = DD.pk_spotnum
    where app_status = '1' and  APPYN = '0'
    and pk_empnum = '20170222-01'
    group by fk_documentnum
) T
on T.fk_documentnum = M.fk_documentnum



select count(*)
from TBL_APPROVALPERSON B
join TBL_APPROVALDOCUMENT C
on B.fK_DOCUMENTNUM = C.PK_DOCUMENTNUM
join TBL_APPROVAL D
on C.FK_APL_NO = D.apl_no
join tbl_employee A
on C.fk_empnum = A.pk_empnum
join tbl_department E
on A.fk_deptnum = E.PK_DEPTNUM
join tbl_spot F
on F.PK_SPOTNUM = A.fK_SPOTNUM
where B.fk_empnum = '20170222-01' and B.app_status = '1' and APPYN = '0' and status = '0' 
order by C.writeday desc

-------------------------
delete from tbl_employee
where pk_empnum in ('001-01','2-001','001-02','1-33')


select CONSTRAINT_NAME, TABLE_NAME, R_CONSTRAINT_NAME
from user_constraints
where R_CONSTRAINT_NAME = 'TBL_EMPLOYEE_PK' 




alter table tbl_employee
add constraint primary key
foreign key (fk_empnum)
references  tbl_employee(pk_empnum)
on delete cascade

ALTER TABLE tbl_employee
ADD CONSTRAINT primary key
  FOREIGN KEY (fk_empnum)
  REFERENCES tbl_employee(pk_empnum)
  ON DELETE CASCADE;


select CONSTRAINT_NAME, TABLE_NAME, R_CONSTRAINT_NAME
from user_constraints
where R_CONSTRAINT_NAME = 'TBL_EMPLOYEE_PK' 

select *
from tbl_employee

delete from TBL_COMMUTE_STATUS
where fk_empnum in ('001-01','2-001','001-02','1-33')

commit;

select *
from TBL_APPROVALDOCUMENT

select vstartdate
from TBL_VACATIONLIST
where PK_DOCUMENTNUM = '20220519143458552'

select venddate
from TBL_VACATIONLIST
where PK_DOCUMENTNUM = '20220519143458552'

-- 날짜 차이 구하기
SELECT SUM(DECODE(TO_CHAR(TO_DATE('2006-12-20','YYYY-MM-DD')+LV-1,'DY'),'토',0,'일',0,1)) as vacationdate
FROM (
SELECT LEVEL LV
FROM DUAL
CONNECT BY LEVEL<=TO_DATE('2006-12-20','YYYY-MM-DD')-TO_DATE('2006-12-20','YYYY-MM-DD')+1
)

select vacationdate
from TBL_APPROVALDOCUMENT A
join TBL_EMPLOYEE B
on A.fk_empnum = B.pk_empnum
where pk_documentnum = '20220521232926193'

UPDATE TBL_EMPLOYEE SET vacationdate = 5 WHERE pk_empnum = 7
