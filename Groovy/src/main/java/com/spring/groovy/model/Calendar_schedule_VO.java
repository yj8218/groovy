package com.spring.groovy.model;

import org.springframework.web.multipart.MultipartFile;

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

	private MultipartFile attach;
	/* form 태그에서 type="file" 인 파일을 받아서 저장되는 필드이다. 
	진짜파일 ==> WAS(톰캣) 디스크에 저장됨.
	조심할것은 MultipartFile attach 는 오라클 데이터베이스 tbl_board 테이블의 컬럼이 아니다.   
	/Board/src/main/webapp/WEB-INF/views/tiles1/board/add.jsp 파일에서 input type="file" 인 name 의 이름(attach)과 
	동일해야만 파일첨부가 가능해진다.!!!!
	*/
	private String fileName;    // WAS(톰캣)에 저장될 파일명(2020120809271535243254235235234.png) 
	private String orgFilename; // 진짜 파일명(강아지.png)  // 사용자가 파일을 업로드 하거나 파일을 다운로드 할때 사용되어지는 파일명
	private String fileSize;    // 파일크기 
	

	private String vote;
	private String placeName;
	private String addressName;
	private String placePhone;
	private String roadAddressName;
	private String placeUrl;
	
	
	public Calendar_schedule_VO() {}
	
	public Calendar_schedule_VO(String pk_scheduleno, String startdate, String enddate, String subject, String color,
			String place, String joinuser, String content, String fk_smcatgono, String fk_lgcatgono, String fk_empnum) {
		super();
		this.pk_scheduleno = pk_scheduleno;
		this.startdate = startdate;
		this.enddate = enddate;
		this.subject = subject;
		this.color = color;
		this.place = place;
		this.joinuser = joinuser;
		this.content = content;
		this.fk_smcatgono = fk_smcatgono;
		this.fk_lgcatgono = fk_lgcatgono;
		this.fk_empnum = fk_empnum;
	}

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

	public MultipartFile getAttach() {
		return attach;
	}

	public void setAttach(MultipartFile attach) {
		this.attach = attach;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public String getOrgFilename() {
		return orgFilename;
	}

	public void setOrgFilename(String orgFilename) {
		this.orgFilename = orgFilename;
	}

	public String getFileSize() {
		return fileSize;
	}

	public void setFileSize(String fileSize) {
		this.fileSize = fileSize;
	}

	public String getVote() {
		return vote;
	}

	public void setVote(String vote) {
		this.vote = vote;
	}

	public String getPlaceName() {
		return placeName;
	}

	public void setPlaceName(String placeName) {
		this.placeName = placeName;
	}

	public String getAddressName() {
		return addressName;
	}

	public void setAddressName(String addressName) {
		this.addressName = addressName;
	}

	public String getPlacePhone() {
		return placePhone;
	}

	public void setPlacePhone(String placePhone) {
		this.placePhone = placePhone;
	}

	public String getRoadAddressName() {
		return roadAddressName;
	}

	public void setRoadAddressName(String roadAddressName) {
		this.roadAddressName = roadAddressName;
	}

	public String getPlaceUrl() {
		return placeUrl;
	}

	public void setPlaceUrl(String placeUrl) {
		this.placeUrl = placeUrl;
	}

	
	
	
	
	
}
