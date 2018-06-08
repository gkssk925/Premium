<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="user.userDAO"%>
<%@ page import="board.boardDAO"%>
<%@ page import="board.boardDTO"%>
<%@ page import="java.util.ArrayList"%>
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

	<section class ="container">
		<form method="get" action="./index.jsp" class="form-inline mt-3">
			<select name="searchType" class="form-control mx-1 mt-2">
				<option value="전체">전체</option>
				<option value="작성자"<% if(searchType.equals("작성자")) out.println("selected"); %>>작성자</option>
				<option value="내용" <% if(searchType.equals("내용")) out.println("selected"); %>>내용</option>
			</select>
			<input type="text" name="search" class = "form-control mx-1 mx-2" placeholder="내용을 입력하세요.">
			<button type="submit" class="btn btn-primary mw-1 mt-2">검색</button>
			<a class="btn btn-outline-secondary mx-1 mt-2" data-toggle="modal" href="#registerModal" >게시글 등록</a>
		</form>	
		
		<%
			ArrayList<boardDTO> boardList = new ArrayList<boardDTO>();
			boardList=new boardDAO().getList(searchType,search,pageNumber);
			if(boardList!=null)
			for(int i = 0; i < boardList.size(); i++) {
				if(i == 5) break;
				boardDTO board = boardList.get(i);
		%>
		
		
		<!-- 카드1 -->
		<div class="card bg-light mt-3">
			<div class="card-header bg-light">
				<div class="row">
					<div class="col-8 text-left"><h5 class="card-title"><%=board.getBoardTitle() %>&nbsp;</h5></div>
					<div class="col-4 text-right"><small><%=board.getBoardWriter() %></small></div>
				</div>
			</div>
			<div class="card-body">
				<p class="card-text">
					<%=board.getBoardContent() %>&nbsp;
				</p>
				<div class="row">
					<div class="col-9 text-left"></div>
					<div class="col-2 text-right">
						<p class="card-text">
						</p></div>
					<div class="col-1 text-right">
						<a onclick="return confirm('삭제하시겠습니까?')" href="./deleteAction.jsp?boardId=<%=board.getBoardId()%>">삭제</a>
					</div>
				</div>
			</div>
		</div>
		
		<%
				}
		%>
		
	</section>
	<ul class="pagination justify-content-center mt-3">
     	<li class="page-item">
<%
	if(pageNumber <= 0) {
%>     
        <a class="page-link disabled">이전</a>
<%
	} else {
%>
		<a class="page-link" href="./index.jsp?searchType=<%=URLEncoder.encode(searchType, "UTF-8")%>&search=<%=URLEncoder.encode(search, "UTF-8")%>&pageNumber=<%=pageNumber - 1%>">이전</a>
<%
	}
%>
		</li>
		<li class="page-item">

		<a class="page-link" href="./index.jsp?searchType=<%=URLEncoder.encode(searchType, "UTF-8")%>&search=<%=URLEncoder.encode(search, "UTF-8")%>&pageNumber=<%=pageNumber + 1%>">다음</a>


      </li>
	</ul>
	<!-- 등록하기 버튼 구현 -->
	<div class="modal fade" id="registerModal" tabindex="-1" role="dialog" aria-labelledby="modal" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="modal">게시글 등록</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<form action="./RegisterAction.jsp" method="post">
						<div class="form-row">
							<div class="form-group col-sm-12">
								<label>제목  </label>
								<input type="text" name="boardTitle" class="form-control" maxlength="40">
								<!--
								<label>작성자  </label>
								<input type="text" name="boardWriter" class="form-control" maxlength="40">  -->
							</div>
						</div>
						
						<div class="form-group">
								<label>내용  </label>
								<textarea name="boardContent" class="form-control" maxlength="2048" style="height:180px;"></textarea>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
							<button type="submit" class="btn btn-primary" >등록</button>
						</div>
					</form>
				</div>
			</div>
		</div>
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