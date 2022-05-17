package com.spring.groovy.model;

public class ApprovalVO {

	// 순번
	private String rno;
	
	// 결재종류
	private String apl_no;
	private String apl_name;
	private String apl_img;
	private String apl_categoryno;
	private String apl_categoryname;
	
	// 결재문서 
	private String pk_documentnum;
	private String fk_empnum;
	private String writeday;
	private String status;
	
	// 비품결재상세정보
	private EquipmentVO equipmentvo;
	
	private String deptnamekor;
	
	// 기본생성자
	public ApprovalVO() {};
	
	public ApprovalVO(String apl_no, String apl_name, String apl_img, String apl_categoryno, String apl_categoryname) {
		this.apl_no = apl_no;
		this.apl_name = apl_name;
		this.apl_img = apl_img;
		this.apl_categoryno = apl_categoryno;
		this.apl_categoryname = apl_categoryname;
	}

	
	public ApprovalVO(String rno, String apl_no, String apl_name, String apl_img, String apl_categoryno, String apl_categoryname,
			String pk_documentnum, String fk_empnum, String writeday, String status, String deptnamekor) {
		this.rno = rno;
		this.apl_no = apl_no;
		this.apl_name = apl_name;
		this.apl_img = apl_img;
		this.apl_categoryno = apl_categoryno;
		this.apl_categoryname = apl_categoryname;
		this.pk_documentnum = pk_documentnum;
		this.fk_empnum = fk_empnum;
		this.writeday = writeday;
		this.status = status;
		this.setDeptnamekor(deptnamekor);
	}
	
	
	public ApprovalVO(String rno, String apl_no, String apl_name, String apl_img, String apl_categoryno,
			String apl_categoryname, String pk_documentnum, String fk_empnum, String writeday, String status,
			EquipmentVO equipmentvo) {
		super();
		this.rno = rno;
		this.apl_no = apl_no;
		this.apl_name = apl_name;
		this.apl_img = apl_img;
		this.apl_categoryno = apl_categoryno;
		this.apl_categoryname = apl_categoryname;
		this.pk_documentnum = pk_documentnum;
		this.fk_empnum = fk_empnum;
		this.writeday = writeday;
		this.status = status;
		this.setEquipmentvo(equipmentvo);
		
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

	public String getWriteday() {
		return writeday;
	}

	public void setWriteday(String writeday) {
		this.writeday = writeday;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getRno() {
		return rno;
	}

	public void setRno(String rno) {
		this.rno = rno;
	}

	public EquipmentVO getEquipmentvo() {
		return equipmentvo;
	}

	public void setEquipmentvo(EquipmentVO equipmentvo) {
		this.equipmentvo = equipmentvo;
	}

	public String getDeptnamekor() {
		return deptnamekor;
	}

	public void setDeptnamekor(String deptnamekor) {
		this.deptnamekor = deptnamekor;
	}

	
	
	
	
	
	
	
}
