<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Calendar"%>
<%@ page import="diary.Diary" %>
<%@ page import="diary.DiaryDAO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width-device-width", initial-scale="1">
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.11.2/css/all.css">
<link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" />  
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>  
<script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script> 
<title>Insert title here</title>
</head>
<body>
	<%
		Date nowTime = new Date();
		SimpleDateFormat yf = new SimpleDateFormat("yyyy");
		SimpleDateFormat mf = new SimpleDateFormat("MM");
		SimpleDateFormat df = new SimpleDateFormat("dd");
		
		Calendar c = Calendar.getInstance();
		
		//초기값은 설정
		String curY = yf.format(nowTime);
		String curM = mf.format(nowTime);
		String curD = df.format(nowTime);
		
		//넘어온 값이 있으면(달력 날짜 클릭 시 클린된 값 넘겨받기)
		if(request.getParameter("year") != null && request.getParameter("month") != null && request.getParameter("curD") != null ){
			curY = request.getParameter("year");
			curM = request.getParameter("month");
			curD = request.getParameter("curD");
		}
		
		//세션값 확인
		String userID = null;
		if(session.getAttribute("userID") != null){
			userID = (String)session.getAttribute("userID");
		}
		
		//user ID null 확인
		String dDate = curY + '-' + curM + '-' + curD;
		//날짜와 user에 맞는 다이어리 객체 받아오기
		Diary diary = new DiaryDAO().getDiary(userID, dDate);
		

		
	%>
	<div class="row">
		<div class = "col-9">
			<h3>
				Diary
			</h3>			
		</div>
		<%
			// 로그인 하고 선택한 날짜의 다이어리가 있을 경우
			if(userID != null && diary.getDiaryTitle() != null){
		%>		
		<div class = "col-3">
		
		</div>
	</div>

	<hr>
	<div>
		<aside>
			<div>
				<ul>
					<div class="row">
						<div class = "col-9">
							<h4>
								<%= diary.getDiaryTitle()%>
							</h4>			
						</div>
						
						<div class = "col-3">
							<h4><a href="update.jsp?dDate=<%= dDate%>&diarySticker=<%= diary.getDiarySticker()%>&diaryTitle=<%= diary.getDiaryTitle()%>&diaryContent=<%= diary.getDiaryContent()%>" 
							style="color: #aee6e6">
							<i class="far fa-edit"></i>
							</a></h4>
						</div>
					</div>
						<p style="font: 5px sans-serif; text-align: left;"><%= dDate%></p>
						<hr>
						<p style="font: sans-serif"><%= diary.getDiaryContent()%></p>
					<div>
						<form method="post" action="deleteAction.jsp">
							<a onclick="return confirm('정말로 삭제하시겠습니까?')" href="deleteAction.jsp?diaryDate=<%= dDate%>"
								style="color: #222831">
								<p style="text-align: right;"><i class="fas fa-trash-alt"></i></p>
							</a>
						</form>
					</div>
				</ul>
			</div>
			</aside>
					
					<%	
						}else{
					%>
						
			<div class = "col-3">
				<h3><a href="write.jsp?dDate=<%= dDate%>&diarySticker=<%= diary.getDiarySticker()%>&diaryTitle=<%= diary.getDiaryTitle()%>&diaryContent=<%= diary.getDiaryContent()%>"
				style="color: #c9cbff"><i class="fas fa-plus-circle"></i></a></h3>
			</div>
		</div>
		
		<hr>
		<p style="font: 5px sans-serif; text-align: left;"><%= dDate%></p>
		<hr>
		<div>
			<aside>
				<div>
					<ul>						
						<div>
							<h4 style="font:sans-serif; color:#aaaaaa">
								&nbsp;
							</h4>			
						</div>
						<h2>
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						</h2>
					</ul>
				</div>
				
			</aside>
		
					<%		
						}
					%>
					
				
		
	</div>
	
</body>
</html>