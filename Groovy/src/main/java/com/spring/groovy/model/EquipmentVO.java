package com.spring.groovy.model;

public class EquipmentVO {

	// 비품결재상세정보
	private String pk_documentnum;   
	private String fk_empnum;
	private String productName;
	private String productLink;
	private String productCnt;
	private String productCost;
	private String productMoney;
	private String productInfo;
	
	// 기본생성자
	public EquipmentVO() {};
	
	public EquipmentVO(String pk_documentnum, String fk_empnum, String productName, String productLink,
			String productCnt, String productCost, String productMoney, String productInfo) {
		super();
		this.pk_documentnum = pk_documentnum;
		this.fk_empnum = fk_empnum;
		this.productName = productName;
		this.productLink = productLink;
		this.productCnt = productCnt;
		this.productCost = productCost;
		this.productMoney = productMoney;
		this.productInfo = productInfo;
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


	public String getProductName() {
		return productName;
	}


	public void setProductName(String productName) {
		this.productName = productName;
	}


	public String getProductLink() {
		return productLink;
	}


	public void setProductLink(String productLink) {
		this.productLink = productLink;
	}


	public String getProductCnt() {
		return productCnt;
	}


	public void setProductCnt(String productCnt) {
		this.productCnt = productCnt;
	}


	public String getProductCost() {
		return productCost;
	}


	public void setProductCost(String productCost) {
		this.productCost = productCost;
	}


	public String getProductMoney() {
		return productMoney;
	}


	public void setProductMoney(String productMoney) {
		this.productMoney = productMoney;
	}


	public String getProductInfo() {
		return productInfo;
	}


	public void setProductInfo(String productInfo) {
		this.productInfo = productInfo;
	}

	
	
	
	
	
	
}
