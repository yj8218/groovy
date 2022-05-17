package com.spring.groovy.model;

public class ApproverVO {

	private String fk_empnum;
	private String app_status;
	private String pk_spotnum;
	private String name;
	private String spotnamekor;
	private String appyn;
	private String deptnamekor;
	private String opinion;
	
	
	public ApproverVO() {}; // 기본생성자

	public ApproverVO(String fk_empnum, String app_status, String pk_spotnum, String name, String spotnamekor, String appyn, String deptnamekor, String opinion) {
		this.fk_empnum = fk_empnum;
		this.app_status = app_status;
		this.pk_spotnum = pk_spotnum;
		this.name = name;
		this.spotnamekor = spotnamekor;
		this.appyn = appyn;
		this.deptnamekor = deptnamekor;
		this.opinion= opinion;
	}


	public String getFk_empnum() {
		return fk_empnum;
	}

	public void setFk_empnum(String fk_empnum) {
		this.fk_empnum = fk_empnum;
	}

	public String getApp_status() {
		return app_status;
	}

	public void setApp_status(String app_status) {
		this.app_status = app_status;
	}

	public String getPk_spotnum() {
		return pk_spotnum;
	}

	public void setPk_spotnum(String pk_spotnum) {
		this.pk_spotnum = pk_spotnum;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getSpotnamekor() {
		return spotnamekor;
	}

	public void setSpotnamekor(String spotnamekor) {
		this.spotnamekor = spotnamekor;
	}
	
	public String getAppyn() {
		return appyn;
	}

	public void setAppyn(String appyn) {
		this.appyn = appyn;
	}

	public String getDeptnamekor() {
		return deptnamekor;
	}

	public void setDeptnamekor(String deptnamekor) {
		this.deptnamekor = deptnamekor;
	}

	public String getOpinion() {
		return opinion;
	}

	public void setOpinion(String opinion) {
		this.opinion = opinion;
	}
	
	
	
}
