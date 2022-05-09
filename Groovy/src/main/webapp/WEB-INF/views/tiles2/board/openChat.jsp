<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<div>
	<div style="border-bottom: solid 1px lightgray; height: 80px;">
		상단 고정(대화내용 검색, 이름, 메뉴바)<br>
		${requestScope.name}
	</div>
	<div>
		대화내용
	</div>
	<div style="background-color: #faf9f9; border-top: solid 1px lightgray; height: 100px; padding: 35px 20px; margin-top: 445px;">
		<input type="text" placeholder="줄바꿈  Shift + Enter / 입력 Enter 입니다."/>
		<button type="button">전송</button>
	</div>
</div>