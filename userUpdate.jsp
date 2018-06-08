<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.userDTO"%>
<%@ page import="user.userDAO"%>
<%@ page import="util.SHA256"%>
<%@ page import="java.io.PrintWriter"%>



<%
	request.setCharacterEncoding("UTF-8");
	String uid = null;
	if(session.getAttribute("uid") != null) {
		uid = (String) session.getAttribute("uid");
	}

	if(uid == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 해주세요.');");
		script.println("location.href = 'index.jsp'");
		script.println("</script>");
		script.close();	
	}
	
	String upw = null;
	String uemail = null;
	String uphone=null;
	String uname=null;

	if(request.getParameter("uid") != null) {
		uid = (String) request.getParameter("uid");
	}

	if(request.getParameter("upw") != null) {
		upw = (String) request.getParameter("upw");
	}

	if(request.getParameter("uemail") != null) {
		uemail = (String) request.getParameter("uemail");
	}
	
	if(request.getParameter("uphone") != null) {
		uphone = (String) request.getParameter("uphone");
	}
	
	if(request.getParameter("uname") != null) {
		uname = (String) request.getParameter("uname");
	}

	if( upw == null || uemail == null||uphone== null||uname== null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('입력이 안 된 사항이 있습니다.');");
		script.println("history.back();"); //뒤로가기
		script.println("</script>");
		script.close();
	}else{
	
	userDAO userdao = new userDAO();
	
	int result = userdao.update(new userDTO(uid, upw, uemail,uname,uphone, SHA256.getSHA256(uemail), false));
	if (result == -1) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('실패하였습니다.');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		} else {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('회원 정보 수정이 완료되었습니다.');");
			script.println("history.back();");
			script.println("</script>");
			script.close();
		}
	}
	%>



