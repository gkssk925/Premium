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

	
	
	
	<div class="container">
		<table class="table table-bordered table-hover" style="text-align: center; border:1px solid #dddddd">
		<thead>
			<tr>
				<th colspan="4"><h4>About extracted documents..</h4></th>
			</tr>
			<tr>
				<td style="background-color: #ffffff; color: #000000; width: 100px;"><h5>문서제목</h5></td>
				<td colspan="3"><h5>Transmitter Characteristics</h5></td>
			</tr>
			<tr>
				<td style="background-color: #ffffff; color: #000000; width: 80px;"><h5>상세설명</h5></td>
				<td><h5>문서들은 전송 특성, 수신 특성 및 3G LTE (Long Term Evolution)의 일부로서의 성능 요구 사항을<br>포함하는 사용자 장비 (UE)의 적합성 시험에 대한 측정 절차를 규정합니다.<br>
				추출하는 데이터는 Initial condition의 일부 정보로 사용자 장비(UE)가 테스트 될 필요가있는 테스트 구성들의<br> 세트 및 정확한 측정 상태에 도달하기 위해 UE와 함께 취하는 단계입니다.
				Initial condition 구성은 환경 조건,<br> 시험 주파수 및 문서에 규정된 E-UTRA 동작 대역에 기반한 채널 대역폭으로 구성되며,<br> 이러한 모든 구성은 각 채널 대역폭에 대해 적용 가능한 테스트 매개 변수로 테스트 되어야합니다.<br>
				Initial condition 구성에 포함되는 것은 UE로부터 시험해야 할 항목을 산출하는데 사용됩니다.</h5></td>
			</tr>
		</thead>
		<tbody>
		
		
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