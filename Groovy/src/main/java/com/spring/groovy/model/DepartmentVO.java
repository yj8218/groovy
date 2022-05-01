package com.spring.groovy.model;

public class DepartmentVO {
	private int pk_deptnum;     	/*부서번호*/  
	private String deptnameeng;		/*부서(영어)*/ 
	private String deptnamekor;		/*부서(한글)*/
	
	
	////////////////////////////////////////////////////////
	public DepartmentVO() {}
	
	public DepartmentVO(int pk_deptnum, String deptnameeng, String deptnamekor) {
		super();
		this.pk_deptnum = pk_deptnum;
		this.deptnameeng = deptnameeng;
		this.deptnamekor = deptnamekor;
	}
	
	
	///////////////////////////////////////////////////////////
	public int getPk_deptnum() {
		return pk_deptnum;
	}

	public void setPk_deptnum(int pk_deptnum) {
		this.pk_deptnum = pk_deptnum;
	}

	public String getDeptnameeng() {
		return deptnameeng;
	}

	public void setDeptnameeng(String deptnameeng) {
		this.deptnameeng = deptnameeng;
	}

	public String getDeptnamekor() {
		return deptnamekor;
	}

	public void setDeptnamekor(String deptnamekor) {
		this.deptnamekor = deptnamekor;
	}
	
	
	
}
