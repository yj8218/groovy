package com.spring.groovy.model;

import org.springframework.web.multipart.MultipartFile;

public class NewProjectVO {

	private String pk_documentnum;   
	private String fk_empnum;   
	private String projectName;   
	private String projectStartDate;   
	private String projectEndDate;   
	private String projectPersonCnt;   
	private String projectPersonList;   
	
	private MultipartFile attach;
	/*
	   form 태그에서 type="file" 인 파일을 받아서 저장되는 필드이다. 
	       진짜파일 ==> WAS(톰캣) 디스크에 저장됨.
	       조심할것은 MultipartFile attach 는 오라클 데이터베이스 tbl_board 테이블의 컬럼이 아니다.   
	   /Board/src/main/webapp/WEB-INF/views/tiles1/board/add.jsp 파일에서 input type="file" 인 name 의 이름(attach)과 
	      동일해야만 파일첨부가 가능해진다.!!!!
	*/
	private String fileName;    // WAS(톰캣)에 저장될 파일명(2020120809271535243254235235234.png) 
	

	private String orgFilename; // 진짜 파일명(강아지.png)  // 사용자가 파일을 업로드 하거나 파일을 다운로드 할때 사용되어지는 파일명
	private String fileSize;    // 파일크기  
	
	public NewProjectVO() {} // 기본생성자

	public NewProjectVO(String pk_documentnum, String fk_empnum, String projectName, String projectStartDate,
			String projectEndDate, String projectPersonCnt, String projectPersonList) {
		this.pk_documentnum = pk_documentnum;
		this.fk_empnum = fk_empnum;
		this.projectName = projectName;
		this.projectStartDate = projectStartDate;
		this.projectEndDate = projectEndDate;
		this.projectPersonCnt = projectPersonCnt;
		this.projectPersonList = projectPersonList;
	}

	public String getPk_documentnum() {
		return pk_documentnum;
	}

	public void setPk_documentnum(String pk_documentnum) {
		this.pk_documentnum = pk_documentnum;
	}

	public String getFk_empnum() {
		return fk_empnum;
	}

	public void setFk_empnum(String fk_empnum) {
		this.fk_empnum = fk_empnum;
	}

	public String getProjectName() {
		return projectName;
	}

	public void setProjectName(String projectName) {
		this.projectName = projectName;
	}

	public String getProjectStartDate() {
		return projectStartDate;
	}

	public void setProjectStartDate(String projectStartDate) {
		this.projectStartDate = projectStartDate;
	}

	public String getProjectEndDate() {
		return projectEndDate;
	}

	public void setProjectEndDate(String projectEndDate) {
		this.projectEndDate = projectEndDate;
	}

	public String getProjectPersonCnt() {
		return projectPersonCnt;
	}

	public void setProjectPersonCnt(String projectPersonCnt) {
		this.projectPersonCnt = projectPersonCnt;
	}

	public String getProjectPersonList() {
		return projectPersonList;
	}

	public void setProjectPersonList(String projectPersonList) {
		this.projectPersonList = projectPersonList;
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
	
	
	
	
	
	
}
