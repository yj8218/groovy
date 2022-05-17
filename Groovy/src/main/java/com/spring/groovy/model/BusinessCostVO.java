package com.spring.groovy.model;

import org.springframework.web.multipart.MultipartFile;

public class BusinessCostVO {

	private String pk_documentnum;   
	private String fk_empnum;   
	private String businessRegion;   
	private String businessStartDate;   
	private String businessEndDate;   
	private String businessPurpose;   
	private String businessMoney;   
	
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
	
	public BusinessCostVO() {} // 기본생성자
	
	public BusinessCostVO(String pk_documentnum, String fk_empnum, String businessRegion, String businessStartDate,
			String businessEndDate, String businessPurpose, String businessMoney) {
		this.pk_documentnum = pk_documentnum;
		this.fk_empnum = fk_empnum;
		this.businessRegion = businessRegion;
		this.businessStartDate = businessStartDate;
		this.businessEndDate = businessEndDate;
		this.businessPurpose = businessPurpose;
		this.businessMoney = businessMoney;
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

	public String getBusinessRegion() {
		return businessRegion;
	}

	public void setBusinessRegion(String businessRegion) {
		this.businessRegion = businessRegion;
	}

	public String getBusinessStartDate() {
		return businessStartDate;
	}

	public void setBusinessStartDate(String businessStartDate) {
		this.businessStartDate = businessStartDate;
	}

	public String getBusinessEndDate() {
		return businessEndDate;
	}

	public void setBusinessEndDate(String businessEndDate) {
		this.businessEndDate = businessEndDate;
	}

	public String getBusinessPurpose() {
		return businessPurpose;
	}

	public void setBusinessPurpose(String businessPurpose) {
		this.businessPurpose = businessPurpose;
	}

	public String getBusinessMoney() {
		return businessMoney;
	}

	public void setBusinessMoney(String businessMoney) {
		this.businessMoney = businessMoney;
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
