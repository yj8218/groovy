package com.spring.groovy.model;

public class Calendar_schedule_VO {

	private String pk_scheduleno;    // 일정관리 번호
	private String startdate;     // 시작일자
	private String enddate;       // 종료일자
	private String subject;       // 제목
	private String color;         // 색상
	private String place;         // 장소
	private String joinuser;      // 공유자	
	private String content;       // 내용	
	private String fk_smcatgono;  // 캘린더 소분류 번호
	private String fk_lgcatgono;  // 캘린더 대분류 번호
	private String fk_empnum;     // 캘린더 일정 작성자 유저아이디


	public String getStartdate() {
		return startdate;
	}

	public void setStartdate(String startdate) {
		this.startdate = startdate;
	}

	public String getEnddate() {
		return enddate;
	}

	public void setEnddate(String enddate) {
		this.enddate = enddate;
	}

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public String getColor() {
		return color;
	}

	public void setColor(String color) {
		this.color = color;
	}

	public String getPlace() {
		return place;
	}

	public void setPlace(String place) {
		this.place = place;
	}

	public String getJoinuser() {
		return joinuser;
	}

	public void setJoinuser(String joinuser) {
		this.joinuser = joinuser;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getFk_smcatgono() {
		return fk_smcatgono;
	}

	public void setFk_smcatgono(String fk_smcatgono) {
		this.fk_smcatgono = fk_smcatgono;
	}

	public String getFk_lgcatgono() {
		return fk_lgcatgono;
	}

	public void setFk_lgcatgono(String fk_lgcatgono) {
		this.fk_lgcatgono = fk_lgcatgono;
	}

	public String getPk_scheduleno() {
		return pk_scheduleno;
	}

	public void setPk_scheduleno(String pk_scheduleno) {
		this.pk_scheduleno = pk_scheduleno;
	}

	public String getFk_empnum() {
		return fk_empnum;
	}

	public void setFk_empnum(String fk_empnum) {
		this.fk_empnum = fk_empnum;
	}
	
	
}
