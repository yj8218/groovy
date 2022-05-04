package com.spring.groovy.model;

import org.springframework.web.multipart.MultipartFile;

public class EmployeeVO {

	private String pk_empnum;         // 사원번호
	private String pwd;               // 비밀번호 (SHA-256 암호화 대상)  데이터베이스의 회원아이디가 저장되어지는데 암호를 그회사 개발자가 보면 안되기 때문에 암호화를 시킨다. 암호화는 두가지 종류가 있는데, SHA-256은 한번 암호화를 거치면 절대로 풀수가 없다. 복호화(암호를 해독, 푸는거)할 수 없다.
	private String name;              // 사원명
	private String address;           // 주소
	private String detailaddress;     // 상세주소
	private String extraaddress;      // 참고항목 주소
	private String postcode;          // 우편번호
	private String phone;             // 연락처 (AES-256 암호화/복호화 대상) 
	private String email;             // 이메일 (AES-256 암호화/복호화 대상) 'hanmailrg@gmial.com' 이라고 쳐도 'sdjfoewjfsdjkfljwopefjdkslfjlsdjfe'길게 뭐라 쳤는지 모르게 나온다. 그래서 암호화대상은 아주 길게 잡아줘야 한다.
	private String birthday;          // 생년월일        
	private String gender;            // 성별   
	private String registerday;       // 가입일자     
	private String startday;          // 입사일자
	private int resignationstatus;    // 퇴사상태(0,1)
	private String resignationday;    // 퇴사일자  
	private int fk_vstatus;           // 휴가상태
	private int fk_deptnum;           // 부서번호
	private int fk_spotnum;           // 직위번호
	private String emppicturename;    // 직원사진
	private int salary;               // 월급
	
	private String emppicturefilename;// 직원사진 파일명
	
	private MultipartFile attach;
	/* form 태그에서 type="file" 인 파일을 받아서 저장되는 필드이다. 
	      진짜파일 ==> WAS(톰캣) 디스크에 저장됨.
	           조심할것은 MultipartFile attach 는 오라클 데이터베이스 tbl_board 테이블의 컬럼이 아니다.   
	    /Board/src/main/webapp/WEB-INF/views/tiles1/board/add.jsp 파일에서 input type="file" 인 name 의 이름(attach)과 
	      동일해야만 파일첨부가 가능해진다.!!!!
	 */
	
	//Source - Generate Constructor using Fields
	
	private String deptnamekor; // 부서명
	private String spotnamekor; // 직급명
	
	public EmployeeVO() {}
	
	public EmployeeVO(String pk_empnum, String pwd, String name, String address, String detailaddress,
			String extraaddress, String postcode, String phone, String email, String birthday, String gender,
			String registerday, String startday, int resignationstatus, String resignationday, int fk_vstatus,
			int fk_deptnum, int fk_spotnum, String emppicturename, int salary, String deptnamekor) {
		
		this.pk_empnum = pk_empnum;
		this.pwd = pwd;
		this.name = name;
		this.address = address;
		this.detailaddress = detailaddress;
		this.extraaddress = extraaddress;
		this.postcode = postcode;
		this.phone = phone;
		this.email = email;
		this.birthday = birthday;
		this.gender = gender;
		this.registerday = registerday;
		this.startday = startday;
		this.resignationstatus = resignationstatus;
		this.resignationday = resignationday;
		this.fk_vstatus = fk_vstatus;
		this.fk_deptnum = fk_deptnum;
		this.fk_spotnum = fk_spotnum;
		this.emppicturename = emppicturename;
		this.salary = salary;
		this.deptnamekor = deptnamekor;
	}

	public String getPk_empnum() {
		return pk_empnum;
	}
	public void setPk_empnum(String pk_empnum) {
		this.pk_empnum = pk_empnum;
	}
	
	public String getPwd() {
		return pwd;
	}
	public void setPwd(String pwd) {
		this.pwd = pwd;
	}
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	
	public String getDetailaddress() {
		return detailaddress;
	}
	public void setDetailaddress(String detailaddress) {
		this.detailaddress = detailaddress;
	}
	
	public String getExtraaddress() {
		return extraaddress;
	}
	public void setExtraaddress(String extraaddress) {
		this.extraaddress = extraaddress;
	}
	
	public String getPostcode() {
		return postcode;
	}
	public void setPostcode(String postcode) {
		this.postcode = postcode;
	}
	
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	
	public String getBirthday() {
		return birthday;
	}
	public void setBirthday(String birthday) {
		this.birthday = birthday;
	}
	
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	
	public String getRegisterday() {
		return registerday;
	}
	public void setRegisterday(String registerday) {
		this.registerday = registerday;
	}
	
	public String getStartday() {
		return startday;
	}
	public void setStartday(String startday) {
		this.startday = startday;
	}
	
	public int getResignationstatus() {
		return resignationstatus;
	}
	public void setResignationstatus(int resignationstatus) {
		this.resignationstatus = resignationstatus;
	}
	
	public String getResignationday() {
		return resignationday;
	}
	public void setResignationday(String resignationday) {
		this.resignationday = resignationday;
	}
	
	public int getFk_vstatus() {
		return fk_vstatus;
	}
	public void setFk_vstatus(int fk_vstatus) {
		this.fk_vstatus = fk_vstatus;
	}
	
	public int getFk_deptnum() {
		return fk_deptnum;
	}
	public void setFk_deptnum(int fk_deptnum) {
		this.fk_deptnum = fk_deptnum;
	}
	
	public int getFk_spotnum() {
		return fk_spotnum;
	}
	public void setFk_spotnum(int fk_spotnum) {
		this.fk_spotnum = fk_spotnum;
	}
	
	public String getEmppicturename() {
		return emppicturename;
	}
	public void setEmppicturename(String emppicturename) {
		this.emppicturename = emppicturename;
	}
	
	public int getSalary() {
		return salary;
	}
	public void setSalary(int salary) {
		this.salary = salary;
	}

	public String getEmppicturefilename() {
		return emppicturefilename;
	}

	public void setEmppicturefilename(String emppicturefilename) {
		this.emppicturefilename = emppicturefilename;
	}

	public MultipartFile getAttach() {
		return attach;
	}

	public void setAttach(MultipartFile attach) {
		this.attach = attach;
	}

	public String getdeptnamekor() {
		return deptnamekor;
	}

	public void setdeptnamekor(String deptnamekor) {
		this.deptnamekor = deptnamekor;
	}

	public String getSpotnamekor() {
		return spotnamekor;
	}

	public void setSpotnamekor(String spotnamekor) {
		this.spotnamekor = spotnamekor;
	}
	
	
	
	
}


