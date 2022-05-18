<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<style type="text/css">

	div#chatMenuBar {
		border:solid 1px red;
		float: right;
		right: -100px;
	}

</style>

<script type="text/javascript">
	
	$(document).ready(function() {
		
		$("i#chatSearch").click(function() {
			alert("대화내용 검색");
		});
		
		$("i#chatMenu").click(function() {
			
		});
		
	}); // end of $(document).ready(function() {})

	
	function openChatMenuBar() {
		document.getElementById("chatMenuBar").style.display = "block";
	}
	
</script>    


<div style="border-bottom: solid 1px lightgray; height: 50px; padding: 10px;">
	<table style="width: 95%; margin: auto; vertical-align: center;">
		<tr>
			<td align="left"><i id="chatSearch" class="fas fa-search"></i></td>
			<td align="center" style="font-weight: bold;">
				${requestScope.name}
				<!-- 1:n 채팅인 경우 채팅 인원 표시 (인원수) -->
			</td>
			<td align="right"><i id="chatMenu" class="fas fa-bars" onclick="openChatMenuBar()"></i></td>
		</tr>
	</table>
</div>

<!-- 메뉴바 -->
<div id="chatMenuBar">
	<article action="" class="form-container">
		<h6>메뉴바에 들어갈 기능들</h6>
		<ul>
			<li>새채팅</li>
			<li>채팅 참여자 목록</li>
			<li>채팅 나가기<i class="fas fa-times"></i></li>
		</ul>
	</article>
</div>

<div style="width: 90%; margin: 10px auto;">
	<p>대화내용</p><br/>
</div>

<div id="inputChat" style="background-color: #faf9f9; border-top: solid 1px lightgray; height: 100px; padding: 35px 20px; position: fixed; bottom: 0; left: 0; width: 100%;">
	<input type="text" placeholder="줄바꿈  Shift + Enter / 입력 Enter 입니다."/>
	<button type="button">전송</button>
</div>