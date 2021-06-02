<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="diary.Diary" %>
<%@ page import="diary.DiaryDAO" %>
<%request.setCharacterEncoding("utf-8"); %>
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
	String diaryDate = request.getParameter("diaryDate");
	// 로그인을 한 사람만 글을 쓸 수 있도록 코드를 수정한다
	if(userID == null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 하세요')");
		script.println("location.href='login.jsp'");
		script.println("</script>");
	}else{
		if(diaryDate != null){//넘겨받은 날짜가 null이 아니면
			// 글 삭제
			DiaryDAO diaryDAO = new DiaryDAO();
			int result = diaryDAO.delete(userID, diaryDate);

			// 데이터베이스 오류인 경우
			if(result == -1){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('데이터 베이스 오류')");
				script.println("location.href='main.jsp'");
				script.println("</script>");
			// 일기가 정상적으로 실행되면 알림창을 띄우고 게시판 메인으로 이동한다
			}else {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('삭제 완료')");
				script.println("location.href='main.jsp'");
				script.println("</script>");
			}
		}else{
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('선택된 날짜가 없습니다.')");
			script.println("location.href='main.jsp'");
			script.println("</script>");
		}
	
			
	}
	


%>
</body>
</html>