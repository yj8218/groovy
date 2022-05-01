package com.spring.groovy.model;

public class ApprovalVO {

	private String apl_no;
	private String apl_name;
	private String apl_img;
	private String apl_categoryno;
	private String apl_categoryname;
	
	
	// 기본생성자
	public ApprovalVO() {};
	
	public ApprovalVO(String apl_no, String apl_name, String apl_img, String apl_categoryno, String apl_categoryname) {
		this.apl_no = apl_no;
		this.apl_name = apl_name;
		this.apl_img = apl_img;
		this.apl_categoryno = apl_categoryno;
		this.apl_categoryname = apl_categoryname;
	}

	
	public String getApl_no() {
		return apl_no;
	}

	public void setApl_no(String apl_no) {
		this.apl_no = apl_no;
	}

	public String getApl_name() {
		return apl_name;
	}

	public void setApl_name(String apl_name) {
		this.apl_name = apl_name;
	}

	public String getApl_img() {
		return apl_img;
	}

	public void setApl_img(String apl_img) {
		this.apl_img = apl_img;
	}

	public String getApl_categoryno() {
		return apl_categoryno;
	}

	public void setApl_categoryno(String apl_categoryno) {
		this.apl_categoryno = apl_categoryno;
	}

	public String getApl_categoryname() {
		return apl_categoryname;
	}

	public void setApl_categoryname(String apl_categoryname) {
		this.apl_categoryname = apl_categoryname;
	}
	
	
	
	
	
	
}
