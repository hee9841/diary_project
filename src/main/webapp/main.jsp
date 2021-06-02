<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width-device-width", initial-scale="1">
<!-- 루트 폴더에 부트스트랩을 참조하는 링크 -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous">
<link rel="stylesheet" href="./css/style.min.css">
<link rel="stylesheet" href="./css/modules.css">
<title>Insert title here</title>
</head>
<body>
	
	<%
		String userID = null;
		if(session.getAttribute("userID") != null){
			userID = (String)session.getAttribute("userID");
		}
	%>
	<div><jsp:include page="/menu.jsp" flush="false"></jsp:include></div>
	
	<!-- 메인 부분 -->
	<section class="MOD_BLOG1">
	  <div data-layout="_r">
	    <article data-layout="ec12 fo10 fo-n2">
	      <div class="MOD_BLOG1_Body">
	        <p class="MOD_BLOG1_Intro" data-theme="_ts2">
	        	<div><jsp:include page="/callender.jsp" flush="false"></jsp:include></div>
	        </p>
	        
	      </div>
	    </article>
	    <aside data-layout="ec4" class="MOD_BLOG1_Aside">
	      <div class="MOD_BLOG1_Box MOD_BLOG1_Recent">
	      	<!-- 다이어리 보여줌 -->
	      	<div><jsp:include page="/view.jsp" flush="false"></jsp:include></div>
	      </div>
	    </aside>
	  </div>
	</section>
	<!-- 메인 끝 -->
<script src="./js/index.js"></script>
<!-- footer -->
<div><jsp:include page="/footer.jsp" flush="false"></jsp:include></div>
</body>
</html>