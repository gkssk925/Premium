<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="user.userDAO"%>
<%@ page import="board.boardDAO"%>
<%@ page import="board.boardDTO"%>

<%@ page import="qna.qnaDTO"%>
<%@ page import="qna.qnaDAO"%>
<%@ page import="java.net.URLEncoder"%>


<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta name = "viewport" content="width=device-width,initial-scale=1,shrink-to-fit=no">
	<title>추출웹사이트</title>
	<!-- 부트스트랩 css 추가하기 -->
	<link rel="stylesheet" href="./css/bootstrap.min.css">
	<!-- 커스텀 css 추가하기 -->
	<link rel="stylesheet" href="./css/custom.css">
</head>
<body>
<%
	request.setCharacterEncoding("UTF-8");
	String searchType = "전체";
	String search="";
	int pageNumber=0;
	
	if(request.getParameter("searchType") != null) {
		searchType = request.getParameter("searchType");
	}

	if(request.getParameter("search") != null) {
		search = request.getParameter("search");
	}

	if(request.getParameter("pageNumber") != null) {
		try {
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
		} catch (Exception e) {
			System.out.println("검색 페이지 번호 오류");
		}
	}



// 로그인상태에서 로그인메뉴 안보이게 하기
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

	boolean emailChecked = new userDAO().getUserEmailChecked(uid);

	if(emailChecked == false) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("location.href = 'emailSendConfirm.jsp'");
		script.println("</script>");
		script.close();		
		return;
	}
	
	String qnaID=null;
	if(request.getParameter("qnaID")!=null){
		qnaID=(String)request.getParameter("qnaID");
	}
	
	if(qnaID==null||qnaID.equals("")){
		session.setAttribute("messageType", "오류");
		session.setAttribute("messageContent", "게시물을 선택해주세요.");
		response.sendRedirect("index.jsp");
		return;
	}
	
	qnaDAO QnaDAO = new qnaDAO();
	qnaDTO qna=QnaDAO.getBoard(qnaID);
	
	
%>	
	
	<nav class="navbar navbar-expand-lg navbar-light" style="background-color: #d7b6be; color: #ffffff"><!-- 배경 흰색 --> 
		<a class="navbar-brand" href="index.jsp" style="text-align: center; background-color: #d7b6be; color: #ffffff"><h3>PREMIUMPROJECT</h3></a>
		<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbar" style="text-align: center;background-color: #d7b6be; color: #ffffff">
		
			<span class="navbar-toggler-icon"></span>
		</button>	
		<div id="navbar" class ="collapse navbar-collapse">
			<ul class="navbar-nav mr-auto">
				<li class="nav-item active">
					<a class="nav-link" href="index.jsp" style="text-align: center;width:90px; background-color: #d7b6be; color: #ffffff"><h2>자유게시판</h2></a>
				</li>
				<li class="nav-item active">
					<a class="nav-link" href="dataSearch.jsp" style="text-align: center;width:90px; background-color: #d7b6be; color: #ffffff"><h2>상세검색</h2></a>
					</li>
				<li class="nav-item active">
					<a class="nav-link" href="qna.jsp" style="text-align: center;width:110px; background-color: #d7b6be; color: #ffffff"><h2>관리자QnA</h2></a>
					</li>
				<li class="nav-item active">
					<a class="nav-link" href="docInfo.jsp" style="text-align: center;width:110px; background-color: #d7b6be; color: #ffffff"><h2>추출문서정보</h2></a>
				</li>
				<li class="nav-item dropdown">
					<a class="nav-link dropdown-toggle" id="dropdown" data-toggle= "dropdown" style="text-align: center;width:90px; background-color: #d7b6be; color: #ffffff">
						<h2>회원관리</h2></a><div class="dropdown-menu" aria-labelledby="dropdown" style="text-align: center">
					
<%
	if(uid == null) {
%>
						<a class = "dropdown-item" href="userLogin.jsp"><h2>로그인</h2></a>
						<a class = "dropdown-item" href="userJoin.jsp"><h2>회원가입</h2></a>
<%
	} else {
%>
						<a class = "dropdown-item" href="update.jsp"><h2>회원정보수정</h2></a>
						<a class = "dropdown-item" href="userLogout.jsp"><h2>로그아웃</h2></a>
<%
	}
%>
					</div>
				</li>
			</ul>
			<form action="./index.jsp" method="get" class="form-inline mt-2 mt-lg-0">
				<input type="text" name="search" class="form-control mr-sm-2" type="search" placeholder="내용을 입력하세요." aria-label="Search">
				<button class="btn btn-outline-secondary my-2 my-sm-0" type="submit" ><h2>검색</h2></button>
			</form>
		</div>
	</nav> 


	<div class="container">
		<table class="table table-bordered table-hover" style="text-align: center; border:1px solid #dddddd">
		<thead>
			<tr>
				<th colspan="4"><h4>QnA</h4></th>
			</tr>
			<tr>
				<td style="background-color: #ffffff; color: #000000; width: 100px;"><h5>제목</h5></td>
				<td colspan="3"><h5><%=qna.getQnaTitle()%></h5></td>
			</tr>
			<tr>
				<td style="background-color: #ffffff; color: #000000; width: 100px;"><h5>작성자</h5></td>
				<td colspan="3"><h5><%=qna.getUid()%></h5></td>
			</tr>
			<tr>
				<td style="background-color: #ffffff; color: #000000; width: 100px;"><h5>작성날짜</h5></td>
				<td><h5><%=qna.getQnaDate()%></h5></td>
			</tr>
			<tr>
				<td style="vertical-align:middle; min-height:150px; background-color: #ffffff; color: #000000; width: 100px;"><h5>내용</h5></td>
				<td colspan="3" style="text-align:left;"><h5><%=qna.getQnaContent()%></h5></td>
			</tr>
		</thead>
		<tbody>
		
		<tr>
			<td colspan="5" style="text-align:right;">
				<a href="qna.jsp" class="btn btn-secondary pull-right"><h5>목록</h5></a>
				<a href="boardReply.jsp?qnaID=<%=qna.getQnaID()%>" class="btn btn-secondary "><h5>답변</h5></a>
				<%
					if(uid.equals(qna.getUid())){
				%>
					<a href="boardUpdate.jsp?qnaID=<%=qna.getQnaID()%>" class="btn btn-secondary "><h5>수정</h5></a>
					<a href="boardDelete.jsp?qnaID=<%=qna.getQnaID()%>" class="btn btn-secondary "><h5>삭제</h5></a>
				
				<%
					}
				%>
			</td>
		</tr>
		</tbody>
		</table>
	</div>






	<!-- footer -->
	<footer class=" mt-4 p-5 text-center" style="color: #FFFFFF; background-color: #b37584">
		 2018 PREMIUMPROJECT
	</footer>		
	
	<!-- 제이쿼리 자바스크립트 추가 -->
	<script src="./js/jquery.min.js"></script>
	<!-- 파퍼 자바스크립트 추가 -->
	<script src="./js/popper.js"></script>
	<!-- 부트스트랩 자바스크립트 추가 -->
	<script src="./js/bootstrap.min.js"></script>
</body>
</html>