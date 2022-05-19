select pk_empnum, name, phone, email, emppicturename, emppicturefilename, s.spotnamekor
from tbl_employee E
join tbl_spot S
on E.fk_spotnum = S.pk_spotnum
where resignationstatus = 0
and not name like '%'||'관리'||'%'
order by fk_deptnum asc, fk_spotnum desc;

select name, phone, email, emppicturename, emppicturefilename, s.spotnamekor
from tbl_employee E
join tbl_spot S
on fk_spotnum = pk_spotnum
where resignationstatus = 0
and not pk_spotnum = 0
and lower(name) like '%'||lower('관')||'%'
order by name asc;

select name
from tbl_employee E
join tbl_department D
on fk_deptnum = pk_deptnum
where resignationstatus = 0
and not name like '%'||'관리'||'%'
order by fk_deptnum asc, fk_spotnum desc;

select pk_deptnum, deptnameeng, deptnamekor
from tbl_department
order by pk_deptnum asc;

select pk_empnum, name, phone, email, emppicturename, emppicturefilename, fk_spotnum
from tbl_employee
where fk_deptnum = 4
order by fk_spotnum desc;

drop table tbl_chatroom purge;
create table tbl_chatroom
(chatroomSeq    number        not null
,fk_empnum         varchar2(40)  not null
,constraint PK_tbl_chatroom primary key(chatroomSeq)
,constraint FK_tbl_chatroom foreign key(fk_empnum) references tbl_employee(pk_empnum)
);

drop sequence seq_chatroom;
create sequence seq_chatroom
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

select *
from tbl_chatroom;

select name, phone, email, emppicturename, emppicturefilename, s.spotnamekor, d.deptnamekor
from tbl_employee E
join tbl_spot S
on fk_spotnum = pk_spotnum
join tbl_department D
on e.fk_deptnum = d.pk_deptnum
where resignationstatus = 0
and not pk_spotnum = 0
and (lower(name) like '%'||lower('총')||'%' or lower(deptnamekor) like '%'||lower('총')||'%')
order by name asc;