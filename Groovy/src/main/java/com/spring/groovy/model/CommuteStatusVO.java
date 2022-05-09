package com.spring.groovy.model;

public class CommuteStatusVO {
	private int pk_commute_statusnum;
	private String fk_empnum;                
	private int total_workingday;         
	private String total_workingtime;     
	private int late;                    
	private int early_endcheck;           
	private int no_endcheck;              
	private int no_workday;
	
	public CommuteStatusVO() {}
	
	public CommuteStatusVO(int pk_commute_statusnum, String fk_empnum, int total_workingday, String total_workingtime,
			int late, int early_endcheck, int no_endcheck, int no_workday) {
		super();
		this.pk_commute_statusnum = pk_commute_statusnum;
		this.fk_empnum = fk_empnum;
		this.total_workingday = total_workingday;
		this.total_workingtime = total_workingtime;
		this.late = late;
		this.early_endcheck = early_endcheck;
		this.no_endcheck = no_endcheck;
		this.no_workday = no_workday;
	}
	
	///////////////////////////////////////////
	
	public int getPk_commute_statusnum() {
		return pk_commute_statusnum;
	}

	public void setPk_commute_statusnum(int pk_commute_statusnum) {
		this.pk_commute_statusnum = pk_commute_statusnum;
	}

	public String getFk_empnum() {
		return fk_empnum;
	}

	public void setFk_empnum(String fk_empnum) {
		this.fk_empnum = fk_empnum;
	}

	public int getTotal_workingday() {
		return total_workingday;
	}

	public void setTotal_workingday(int total_workingday) {
		this.total_workingday = total_workingday;
	}

	public String getTotal_workingtime() {
		return total_workingtime;
	}

	public void setTotal_workingtime(String total_workingtime) {
		this.total_workingtime = total_workingtime;
	}

	public int getLate() {
		return late;
	}

	public void setLate(int late) {
		this.late = late;
	}

	public int getEarly_endcheck() {
		return early_endcheck;
	}

	public void setEarly_endcheck(int early_endcheck) {
		this.early_endcheck = early_endcheck;
	}

	public int getNo_endcheck() {
		return no_endcheck;
	}

	public void setNo_endcheck(int no_endcheck) {
		this.no_endcheck = no_endcheck;
	}

	public int getNo_workday() {
		return no_workday;
	}

	public void setNo_workday(int no_workday) {
		this.no_workday = no_workday;
	}  
	
	
	

}
