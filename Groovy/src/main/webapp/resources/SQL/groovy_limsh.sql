select pk_empnum, name, phone, email, emppicturename, emppicturefilename
from tbl_employee
where resignationstatus = 0
and not name like '%'||'관리'||'%';

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