<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="java.io.PrintWriter"%>

<%
	session.invalidate(); // 사용자가 클라이어트의 세션정보 파기
%>

<script>
	location.href = 'index.jsp';
</script>
