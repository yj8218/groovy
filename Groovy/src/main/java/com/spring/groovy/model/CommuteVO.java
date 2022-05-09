package com.spring.groovy.model;

public class CommuteVO {
	private int pk_commutenum; /*통근 번호*/
	private String fk_empnum;  /*사원번호(아이디)*/
	private String startwork;  /*출근시각*/ 
	private String endwork;    /*퇴근시각*/
	
	private CommuteVO() {}
	
	public CommuteVO(int pk_commutenum, String fk_empnum, String startwork, String endwork) {
		super();
		this.pk_commutenum = pk_commutenum;
		this.fk_empnum = fk_empnum;
		this.startwork = startwork;
		this.endwork = endwork;
	}

	/////////////////////////////////////////

	public int getPk_commutenum() {
		return pk_commutenum;
	}

	public void setPk_commutenum(int pk_commutenum) {
		this.pk_commutenum = pk_commutenum;
	}

	public String getFk_empnum() {
		return fk_empnum;
	}

	public void setFk_empnum(String fk_empnum) {
		this.fk_empnum = fk_empnum;
	}

	public String getStartwork() {
		return startwork;
	}

	public void setStartwork(String startwork) {
		this.startwork = startwork;
	}

	public String getEndwork() {
		return endwork;
	}

	public void setEndwork(String endwork) {
		this.endwork = endwork;
	}
	
	
	
	

}
