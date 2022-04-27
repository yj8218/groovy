<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<script type="text/javascript">
	alert("${requestScope.message}");//MemberRegisterAction에서 메세지 가져와서 출력
	location.href="${requestScope.loc}";//페이지 이동
</script>

