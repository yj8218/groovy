package com.spring.groovy.model;

public class SpotVO {
	private int pk_spotnum;    		/*직위번호*/
	private String spotnameeng;		/*직위(영어)*/
	private String spotnamekor;		/*직위(한글)*/
	
	public SpotVO() {}

	public SpotVO(int pk_spotnum, String spotnameeng, String spotnamekor) {
		super();
		this.pk_spotnum = pk_spotnum;
		this.spotnameeng = spotnameeng;
		this.spotnamekor = spotnamekor;
	}

	public int getPk_spotnum() {
		return pk_spotnum;
	}

	public void setPk_spotnum(int pk_spotnum) {
		this.pk_spotnum = pk_spotnum;
	}

	public String getSpotnameeng() {
		return spotnameeng;
	}

	public void setSpotnameeng(String spotnameeng) {
		this.spotnameeng = spotnameeng;
	}

	public String getSpotnamekor() {
		return spotnamekor;
	}

	public void setSpotnamekor(String spotnamekor) {
		this.spotnamekor = spotnamekor;
	};
	
	
}
