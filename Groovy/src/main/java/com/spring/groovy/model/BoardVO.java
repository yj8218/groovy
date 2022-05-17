package com.spring.groovy.model;

import org.springframework.web.multipart.MultipartFile;

public class BoardVO {
	private String pk_board_seq;          // 글번호 
	private String fk_empnum;    // 사용자ID
	private String b_subject;         // 글제목
	private String b_content;      // 글내용 
	private String b_pw;           // 글암호
	private String b_readcount;    // 글조회수
	private String b_regdate;      // 글쓴시간
	private String b_status;       // 글삭제여부   1:사용가능한 글,  0:삭제된글 
	
	private String previousseq;      // 이전글번호
	private String previoussubject;  // 이전글제목
	private String nextseq;          // 다음글번호
	private String nextsubject;      // 다음글제목	
	
	// === #81. 댓글형 게시판을 위한 commentCount 필드 추가하기 
	//          먼저 tbl_board 테이블에 commentCount 라는 컬럼이 존재해야 한다.
	private String b_commentcount;     // 댓글수 
	
	
	// === #137. 답변글쓰기 게시판을 위한 필드 추가하기
	//     먼저, 오라클에서 tbl_comment 테이블과  tbl_board 테이블을 drop 한 이후에 
	//     tbl_board 테이블 및 tbl_comment 테이블을 재생성 한 이후에 아래처럼 해야 한다.
	private String groupno;
	/*
	      답변글쓰기에 있어서 그룹번호 
              원글(부모글)과 답변글은 동일한 groupno 를 가진다.
              답변글이 아닌 원글(부모글)인 경우 groupno 의 값은 groupno 컬럼의 최대값(max)+1 로 한다.
	 */
	
	private String fk_seq;
	/*
	    fk_seq 컬럼은 절대로 foreign key가 아니다.!!!!!!
        fk_seq 컬럼은 자신의 글(답변글)에 있어서 
                원글(부모글)이 누구인지에 대한 정보값이다.
                답변글쓰기에 있어서 답변글이라면 fk_seq 컬럼의 값은 
                원글(부모글)의 seq 컬럼의 값을 가지게 되며,
                답변글이 아닌 원글일 경우 0 을 가지도록 한다. 
	 */
	
	private String depthno;
	/*
	       답변글쓰기에 있어서 답변글 이라면
               원글(부모글)의 depthno + 1 을 가지게 되며,
               답변글이 아닌 원글일 경우 0 을 가지도록 한다. 
	*/
	
	/*
	   === #152. 파일을 첨부하도록 VO 수정하기
	             먼저, 오라클에서 tbl_board 테이블에 3개 컬럼(fileName, orgFilename, fileSize)을 추가한 다음에 아래의 작업을 한다. 
	*/
	private MultipartFile attach;
	/* form 태그에서 type="file" 인 파일을 받아서 저장되는 필드이다. 
	      진짜파일 ==> WAS(톰캣) 디스크에 저장됨.
             조심할것은 MultipartFile attach 는 오라클 데이터베이스 tbl_board 테이블의 컬럼이 아니다.   
	   /Board/src/main/webapp/WEB-INF/views/tiles1/board/add.jsp 파일에서 input type="file" 인 name 의 이름(attach)과  
	     동일해야만 파일첨부가 가능해진다.!!!!
 */
	private String b_filename;    // WAS(톰캣)에 저장될 파일명(2022042911123035243254235235234.png) 
	private String b_orgfilename; // 진짜 파일명(강아지.png)  // 사용자가 파일을 업로드 하거나 파일을 다운로드 할때 사용되어지는 파일명
	private String b_filesize;    // 파일크기 
	
	private String name; //이름
	
	public String getName() {
		return name;
	}


	public void setName(String name) {
		this.name = name;
	}


	public BoardVO() {}
	
	
	public BoardVO(String pk_board_seq, String fk_empnum, String b_subject, String b_content, String b_pw,
			String b_readcount, String b_regdate, String b_status) {
		this.pk_board_seq = pk_board_seq;
		this.fk_empnum = fk_empnum;
		this.b_subject = b_subject;
		this.b_content = b_content;
		this.b_pw = b_pw;
		this.b_readcount = b_readcount;
		this.b_regdate = b_regdate;
		this.b_status = b_status;
	}
	
	
	public String getPk_board_seq() {
		return pk_board_seq;
	}
	public void setPk_board_seq(String pk_board_seq) {
		this.pk_board_seq = pk_board_seq;
	}
	public String getFk_empnum() {
		return fk_empnum;
	}
	public void setFk_empnum(String fk_empnum) {
		this.fk_empnum = fk_empnum;
	}
	public String getB_subject() {
		return b_subject;
	}
	public void setB_subject(String b_subject) {
		this.b_subject = b_subject;
	}
	public String getB_content() {
		return b_content;
	}
	public void setB_content(String b_content) {
		this.b_content = b_content;
	}
	public String getB_pw() {
		return b_pw;
	}
	public void setB_pw(String b_pw) {
		this.b_pw = b_pw;
	}
	public String getB_readcount() {
		return b_readcount;
	}
	public void setB_readcount(String b_readcount) {
		this.b_readcount = b_readcount;
	}
	public String getB_regdate() {
		return b_regdate;
	}
	public void setB_regdate(String b_regdate) {
		this.b_regdate = b_regdate;
	}
	public String getB_status() {
		return b_status;
	}
	public void setB_status(String b_status) {
		this.b_status = b_status;
	}
	public String getPreviousseq() {
		return previousseq;
	}
	public void setPreviousseq(String previousseq) {
		this.previousseq = previousseq;
	}
	public String getPrevioussubject() {
		return previoussubject;
	}
	public void setPrevioussubject(String previoussubject) {
		this.previoussubject = previoussubject;
	}
	public String getNextseq() {
		return nextseq;
	}
	public void setNextseq(String nextseq) {
		this.nextseq = nextseq;
	}
	public String getNextsubject() {
		return nextsubject;
	}
	public void setNextsubject(String nextsubject) {
		this.nextsubject = nextsubject;
	}
	public String getB_commentcount() {
		return b_commentcount;
	}
	public void setB_commentcount(String b_commentcount) {
		this.b_commentcount = b_commentcount;
	}
	public String getGroupno() {
		return groupno;
	}
	public void setGroupno(String groupno) {
		this.groupno = groupno;
	}
	public String getFk_seq() {
		return fk_seq;
	}
	public void setFk_seq(String fk_seq) {
		this.fk_seq = fk_seq;
	}
	public String getDepthno() {
		return depthno;
	}
	public void setDepthno(String depthno) {
		this.depthno = depthno;
	}
	public MultipartFile getAttach() {
		return attach;
	}
	public void setAttach(MultipartFile attach) {
		this.attach = attach;
	}
	public String getB_filename() {
		return b_filename;
	}
	public void setB_filename(String b_filename) {
		this.b_filename = b_filename;
	}
	public String getB_orgfilename() {
		return b_orgfilename;
	}
	public void setB_orgfilename(String b_orgfilename) {
		this.b_orgfilename = b_orgfilename;
	}
	public String getB_filesize() {
		return b_filesize;
	}
	public void setB_filesize(String b_filesize) {
		this.b_filesize = b_filesize;
	}


	
	
	
	
}
