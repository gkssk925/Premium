<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="board.boardDTO"%>
<%@ page import="board.boardDAO"%>
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

	String boardTitle= null;
	String boardWriter= null;
	String boardContent= null;
	


	if(request.getParameter("boardTitle") != null) {
		boardTitle = (String) request.getParameter("boardTitle");
	}

	/*
	if(request.getParameter("boardWriter") != null) {
		boardWriter = (String) request.getParameter("boardWriter");
	}*/
	
	boardWriter=uid;
	
	if(request.getParameter("boardContent") != null) {
		boardContent = (String) request.getParameter("boardContent");
	}

	if(boardTitle == null || boardWriter == null || boardContent == null||boardTitle.equals("")||boardContent.equals("")) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('입력이 안 된 사항이 있습니다.');");
		script.println("history.back();"); //뒤로가기
		script.println("</script>");
		script.close();
	}else{
	
	boardDAO BoardDAO = new boardDAO();
	
	int result = BoardDAO.write(new boardDTO(0, boardTitle, boardWriter, boardContent));
	if (result == -1) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('게시글 등록 실패');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		} else { //게시글 등록 성공
		session.setAttribute("uid", uid);
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("location.href = 'index.jsp';");
		script.println("</script>");
		script.close();
		}
	}
	%>


