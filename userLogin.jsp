<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@ page import="java.io.PrintWriter"%>
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


<% // 로그인상태에서 로그인메뉴 안보이게 하기
	String uid = null;

	if(session.getAttribute("uid") != null) {
		uid = (String) session.getAttribute("uid");
	}

	if(uid != null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인이 된 상태입니다.');");
		script.println("location.href = 'index.jsp'");
		script.println("</script>");
		script.close();	
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

	<section class ="container mt-5" style="max-width:560px;">
		<form method="post" action="./userLoginAction.jsp">
			<div class="form-group">
				<label>아이디</label>
				<input type="text" name="uid" class="form-control">
			</div>
			<div class="form-group">
				<label>비밀번호</label>
				<input type="password" name="upw" class="form-control">
			</div>
				<div class="row">
					<div class="col-9 text-left">
						</div>
					<div class="col-3 text-right">
							<button type="submit" class="btn btn-outline-secondary">LOGIN</button>
						</div>
				</div>
		</form>		
	</section>
	
	
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