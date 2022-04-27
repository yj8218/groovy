package com.spring.groovy.common;

import javax.servlet.http.HttpServletRequest;

public class MyUtil {
	public static String getCurrentURL(HttpServletRequest request) {
		String currentURL = request.getRequestURI().toString();//데이터 제외하고 나온다
		//http://localhost:9090/MyMVC/member/memberOneDetail.up
		String queryString = request.getQueryString(); //? 다음 데이터값나옴 post방식이면 null값이다
		//userid=seokj
		
		if(queryString != null) {//get방식
			currentURL+= "?" + queryString;
			//http://localhost:9090/MyMVC/member/memberOneDetail.up?userid=seokj
		}
		String ctxPath = request.getContextPath();
		int beginIndex = currentURL.indexOf(ctxPath)+ctxPath.length(); ////http://localhost:9090/MyMVC/ 제거위해 위치값
		currentURL = currentURL.substring(beginIndex); 
		///member/memberOneDetail.up?userid=seokj
		
		return currentURL;
	}
	
	

}
