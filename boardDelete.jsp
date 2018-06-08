<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="user.userDAO"%>
<%@ page import="qna.qnaDAO"%>
<%@ page import="java.io.PrintWriter"%>

<%

	String uid = null;

	if(session.getAttribute("uid") != null) {
		uid = (String) session.getAttribute("uid");
	}

	if(uid == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 해주세요.');");
		script.println("location.href = 'userLogin.jsp'");
		script.println("</script>");
		script.close();
		return;
	}

	request.setCharacterEncoding("UTF-8");
	String qnaID = null;
	if(request.getParameter("qnaID") != null) {
		qnaID = (String) request.getParameter("qnaID");
	}

	qnaDAO QnaDAO = new qnaDAO();

	if(uid.equals(QnaDAO.getUserID(qnaID))) {
		if(QnaDAO.getAvail(qnaID)!=0){
			int result = new qnaDAO().delete(qnaID);
			if (result == 1) {
				session.setAttribute("uid", uid);
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('삭제가 완료되었습니다.');");
				script.println("location.href='qna.jsp'");
				script.println("</script>");
				script.close();

			} else {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('데이터베이스 오류가 발생했습니다.');");
				script.println("history.back();");
				script.println("</script>");
				script.close();
			}	
		}else{
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('이미 답변이 등록된 게시글은 삭제할 수 없습니다.');");
			script.println("history.back();");
			script.println("</script>");
			script.close();
		}
		
	} else {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('본인이 쓴 글만 삭제 가능합니다.');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
	}

%>
