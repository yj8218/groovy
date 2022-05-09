package com.spring.groovy.model;

public class Calendar_small_category_VO {

	private String pk_smcatgono;     // 캘린더 소분류 번호
	private String fk_lgcatgono;  // 캘린더 대분류 번호
	private String smcatgoname;   // 캘린더 소분류 명
	private String fk_empnum;     // 캘린더 소분류 작성자 유저아이디
	
	public String getFk_lgcatgono() {
		return fk_lgcatgono;
	}
	
	public void setFk_lgcatgono(String fk_lgcatgono) {
		this.fk_lgcatgono = fk_lgcatgono;
	}
	
	public String getSmcatgoname() {
		return smcatgoname;
	}
	
	public void setSmcatgoname(String smcatgoname) {
		this.smcatgoname = smcatgoname;
	}

	public String getPk_smcatgono() {
		return pk_smcatgono;
	}

	public void setPk_smcatgono(String pk_smcatgono) {
		this.pk_smcatgono = pk_smcatgono;
	}

	public String getFk_empnum() {
		return fk_empnum;
	}

	public void setFk_empnum(String fk_empnum) {
		this.fk_empnum = fk_empnum;
	}
	
}
