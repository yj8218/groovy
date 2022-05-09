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