<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="user.userDAO"%>
<%@ page import="exdata.exdataDAO"%>
<%@ page import="exdata.exdataDTO"%>
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
	String tcid = "";
	String bw="";
	String bwtc="";
	int pageNumber=0;
	
	if(request.getParameter("tcid") != null) {
		tcid = request.getParameter("tcid");
	}

	if(request.getParameter("bw") != null) {
		bw = request.getParameter("bw");
	}
	
	if(request.getParameter("bwtc") != null) {
		bwtc = request.getParameter("bwtc");
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
		<form method="get" action="./dataSearch.jsp" class="form-inline mt-3">
			<label>TC-ID&nbsp;&nbsp;</label>
			<input type="text" name="tcid" class = "form-control mx-1 mx-2" placeholder="TC-ID를 입력하세요.">

			<label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;BW&nbsp;&nbsp;</label>
			<input type="text" name="bw" class = "form-control mx-1 mx-2" placeholder="BW를 입력하세요.">

			<label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;BW-TC&nbsp;&nbsp;</label>
			<input type="text" name="bwtc" class = "form-control mx-1 mx-2" placeholder="BW-TC를 입력하세요.">
			<button type="submit" class="btn btn-secondary mw-1 mt-1"><h5>검색</h5></button>
		</form>
		
	
		<div class="container">
		<a>&nbsp;</a>
		<table class="table table-bordered table-hover" style="text-align: center; border:1px solid #dddddd">
		<thead>
		
			<tr>
				<th style="background-color: #ffffff; color: #000000;"><h5>TC_ID</h5></th>
				<th style="background-color: #ffffff; color: #000000;"><h5>environment</h5></th>
				<th style="background-color: #ffffff; color: #000000;"><h5>BW_TC</h5></th>
				<th style="background-color: #ffffff; color: #000000; width: 300px;"><h5>BW</h5></th>
			</tr>
		</thead>
		<tbody>
		<%
			ArrayList<exdataDTO> boardList = new ArrayList<exdataDTO>();
			boardList=new exdataDAO().getList(tcid,bw,bwtc,pageNumber);
			if(boardList!=null)
			for(int i = 0; i < boardList.size(); i++) {
				if(i == 15) break;
				exdataDTO board = boardList.get(i);
		%>
		<tr>
			<td><%=board.getTable_name()%></td>
			<td><%=board.getEnvironment()%></td>
			<td><%= board.getChannel() %></td>
			<td><%= board.getCh_bw() %></td>
		</tr>
		<%
			}
		%>
		</tbody>
		</table>
	</div>
		
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
		<a class="page-link" href="./dataSearch.jsp?tcid=<%=URLEncoder.encode(tcid, "UTF-8")%>&bw=<%=URLEncoder.encode(bw, "UTF-8")%>&bwtc=<%=URLEncoder.encode(bwtc, "UTF-8")%>&pageNumber=<%=pageNumber - 1%>">이전</a>
<%
	}
%>
		</li>
		<li class="page-item">

		<a class="page-link" href="./dataSearch.jsp?tcid=<%=URLEncoder.encode(tcid, "UTF-8")%>&bw=<%=URLEncoder.encode(bw, "UTF-8")%>&bwtc=<%=URLEncoder.encode(bwtc, "UTF-8")%>&pageNumber=<%=pageNumber + 1%>">다음</a>


      </li>
	</ul>
	
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