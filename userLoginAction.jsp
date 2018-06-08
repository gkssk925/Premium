<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.userDTO"%>
<%@ page import="user.userDAO"%>
<%@ page import="util.SHA256"%>
<%@ page import="java.io.PrintWriter"%>



<%
	request.setCharacterEncoding("UTF-8");
	String uid = null;
	String upw = null;
	
	if(request.getParameter("uid") != null) {
		uid = (String) request.getParameter("uid");
	}

	if(request.getParameter("upw") != null) {
		upw = (String) request.getParameter("upw");
	}

	if(uid == null || upw == null ) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('입력이 안 된 사항이 있습니다.');");
		script.println("history.back();"); //뒤로가기
		script.println("</script>");
		script.close();
	}else{
	
	userDAO userdao = new userDAO();
	int result = userdao.login(uid,upw);
	 
	if (result == 1) {
		session.setAttribute("uid", uid);
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("location.href = 'index.jsp';");
		script.println("</script>");
		script.close();
		} else if(result==0){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('비밀번호를 다시 입력하세요.');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		}else if(result==-1){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('존재하지 않는 아이디입니다.');");
			script.println("history.back();");
			script.println("</script>");
			script.close();
		}else if(result==-2){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('데이터베이스 오류가 발생했습니다.');");
			script.println("history.back();");
			script.println("</script>");
			script.close();
		}
	}
	%>


