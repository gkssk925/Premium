<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="qna.qnaDTO"%>
<%@ page import="qna.qnaDAO"%>
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
		script.println("location.href = 'userLogin.jsp'");
		script.println("</script>");
		script.close();	
	}

	String qnaTitle= null;
	String qnaContent= null;
	String qnaID=null;


	if(request.getParameter("qnaID") != null) {
		qnaID = (String) request.getParameter("qnaID");
	}
	
	if(request.getParameter("qnaTitle") != null) {
		qnaTitle = (String) request.getParameter("qnaTitle");
	}
	
	if(request.getParameter("qnaContent") != null) {
		qnaContent = (String) request.getParameter("qnaContent");
	}

	if(qnaID==null||qnaTitle == null || qnaContent == null||qnaTitle.equals("")||qnaContent.equals("")) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('모두 입력해주세요.');");
		script.println("history.back();"); //뒤로가기
		script.println("</script>");
		script.close();
	}else{
	
	qnaDAO QnaDAO = new qnaDAO();
	qnaDTO parent = QnaDAO.getBoard(qnaID);
	QnaDAO.replyUpdate(parent);
	int result = QnaDAO.reply(uid, qnaTitle, qnaContent,parent);
	
	
	if (result == -1) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('답변 등록 실패');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		} else { 
		session.setAttribute("uid", uid);
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("location.href = 'qna.jsp';");
		script.println("</script>");
		script.close();
		}
	}
	%>


