<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="diary.Diary" %>
<%@ page import="diary.DiaryDAO" %>
<%request.setCharacterEncoding("utf-8"); %>
<jsp:useBean id="diary" class="diary.Diary" scope="page"/>
<jsp:setProperty name="diary" property="diaryTitle"/>
<jsp:setProperty name="diary" property="diaryContent"/>
<jsp:setProperty name="diary" property="diaryDate"/>
<jsp:setProperty name="diary" property="diarySticker"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	// 현재 세션 상태를 체크한다
	String userID = null;
	if(session.getAttribute("userID") != null){
		userID = (String)session.getAttribute("userID");
	}
	// 로그인을 한 사람만 글을 쓸 수 있도록 코드를 수정한다
	if(userID == null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 하세요')");
		script.println("location.href='login.jsp'");
		script.println("</script>");
	}else{
		// 입력이 안 된 부분이 있는지 체크한다
		if(diary.getDiaryTitle() == null ||diary.getDiaryContent() == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('입력이 안 된 사항이 있습니다')");
			script.println("history.back()");
			script.println("</script>");
		}else{
			// 정상적으로 입력이 되었다면 글쓰기 로직을 수행한
			DiaryDAO diaryDAO = new DiaryDAO();

			int result = diaryDAO.update(userID, diary.getDiaryDate(), diary.getDiaryTitle(), diary.getDiaryContent(), diary.getDiarySticker());
			if(diary.getDiaryDate() == null){
				System.out.println("date : null");
			}

			// 데이터베이스 오류인 경우
			if(result == -1){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('다이어리 수정 실패')");
				script.println("location.href='main.jsp'");
				script.println("</script>");
			// 일기가 정상적으로 실행되면 알림창을 띄우고 게시판 메인으로 이동한다
			}else {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('다이어리 수정 완료')");
				script.println("location.href='main.jsp'");
				script.println("</script>");
			}
		}
	}
	


%>
</body>
</html>