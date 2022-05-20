package com.spring.groovy.model;

import org.springframework.web.multipart.MultipartFile;

public class CommentVO {

	private String pk_cmt_seq;          // 댓글번호
	private String fk_empnum;    // 사용자ID(사원번호)
	private String cmt_name;         // 성명
	private String cmt_content;      // 댓글내용
	private String cmt_regDate;      // 작성일자
	private String fk_board_seq;    // 원게시물 글번호
	private String cmt_status;       // 글삭제여부
		
	////////////////////////////////////////////////////////
	
	// 먼저, 댓글쓰기에 파일첨부까지 한 것을 위해서 오라크에서 tbl_comment 테이블에 fileName, orgFilename, fileSize 컬럼을 추가해주어야 한다. 
	private MultipartFile cmt_attach;
	/* form 태그에서 type="file" 인 파일을 받아서 저장되는 필드이다. 
	      진짜파일 ==> WAS(톰캣) 디스크에 저장됨.
             조심할것은 MultipartFile attach 는 오라클 데이터베이스 tbl_board 테이블의 컬럼이 아니다.   
	   /Board/src/main/webapp/WEB-INF/views/tiles1/board/add.jsp 파일에서 input type="file" 인 name 의 이름(attach)과  
	     동일해야만 파일첨부가 가능해진다.!!!!
    */
	private String cmt_fileName;    // WAS(톰캣)에 저장될 파일명(2022042911123035243254235235234.png) 
	private String cmt_orgFilename; // 진짜 파일명(강아지.png)  // 사용자가 파일을 업로드 하거나 파일을 다운로드 할때 사용되어지는 파일명
	private String cmt_fileSize;    // 파일크기 
	
	////////////////////////////////////////////////////////
	
	public CommentVO() {}
	

	public CommentVO(String pk_cmt_seq, String fk_empnum, String cmt_name, String cmt_content, String cmt_regDate,
			String fk_board_seq, String cmt_status) {
		this.pk_cmt_seq = pk_cmt_seq;
		this.fk_empnum = fk_empnum;
		this.cmt_name = cmt_name;
		this.cmt_content = cmt_content;
		this.cmt_regDate = cmt_regDate;
		this.fk_board_seq = fk_board_seq;
		this.cmt_status = cmt_status;
		
	}


	public String getPk_cmt_seq() {
		return pk_cmt_seq;
	}

	public void setPk_cmt_seq(String pk_cmt_seq) {
		this.pk_cmt_seq = pk_cmt_seq;
	}

	public String getFk_empnum() {
		return fk_empnum;
	}

	public void setFk_empnum(String fk_empnum) {
		this.fk_empnum = fk_empnum;
	}

	public String getCmt_name() {
		return cmt_name;
	}

	public void setCmt_name(String cmt_name) {
		this.cmt_name = cmt_name;
	}

	public String getCmt_content() {
		return cmt_content;
	}

	public void setCmt_content(String cmt_content) {
		this.cmt_content = cmt_content;
	}

	public String getCmt_regDate() {
		return cmt_regDate;
	}

	public void setCmt_regDate(String cmt_regDate) {
		this.cmt_regDate = cmt_regDate;
	}

	public String getFk_board_seq() {
		return fk_board_seq;
	}

	public void setFk_board_seq(String fk_board_seq) {
		this.fk_board_seq = fk_board_seq;
	}

	public String getCmt_status() {
		return cmt_status;
	}

	public void setCmt_status(String cmt_status) {
		this.cmt_status = cmt_status;
	}

	public MultipartFile getCmt_attach() {
		return cmt_attach;
	}

	public void setCmt_attach(MultipartFile cmt_attach) {
		this.cmt_attach = cmt_attach;
	}

	public String getCmt_fileName() {
		return cmt_fileName;
	}

	public void setCmt_fileName(String cmt_fileName) {
		this.cmt_fileName = cmt_fileName;
	}

	public String getCmt_orgFilename() {
		return cmt_orgFilename;
	}

	public void setCmt_orgFilename(String cmt_orgFilename) {
		this.cmt_orgFilename = cmt_orgFilename;
	}

	public String getCmt_fileSize() {
		return cmt_fileSize;
	}

	public void setCmt_fileSize(String cmt_fileSize) {
		this.cmt_fileSize = cmt_fileSize;
	}
	
	
}
