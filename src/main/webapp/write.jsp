<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="diary.Diary" %>
<%@ page import="diary.DiaryDAO" %>
<%request.setCharacterEncoding("utf-8"); %>
<jsp:useBean id="diary" class="diary.Diary" scope="page"/>
<jsp:setProperty name="diary" property="diaryTitle"/>
<jsp:setProperty name="diary" property="diaryContent"/>
<jsp:setProperty name="diary" property="diarySticker"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width-device-width", initial-scale="1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
<link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" />  
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>  
<script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>  
<title>Insert title here</title>
<style>
	html {
		height: 100%;
	}
	
	body {
	    width:100%;
	    height:100%;
	    margin: 0;
  
  		font-family: "Nanum Gothic", arial, helvetica, sans-serif;
  		background-repeat: no-repeat;
  		
	}
	
    .card {
    	
        margin: 0 auto; /* Added */
        float: absolute; /* Added */
        margin-bottom: 10px; /* Added */
        box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
	}
	
	.form-signin .form-control {
  		position: relative;
  		height: auto;
  		-webkit-box-sizing: border-box;
     	-moz-box-sizing: border-box;
        	 box-sizing: border-box;
  		padding: 10px;
  		font-size: 16px;
	}
	#diaryfrom{
		
	}
	.ui-datepicker-trigger{cursor: pointer;}
	.ui-datepicker-trigger{cursor: pointer;}
	
	.modal_wrap{
        display: none;
        position: absolute;
        width : 700px;
        margin: 20px;
        top:40%;
        left: 50%;
        margin: -300px 0 0 -350px;
        background:#eee;
        z-index: 2;
    }
    .modal_wrap_2{
        display: none;
        position: absolute;
        width : 700px;
        margin: 20px;
        top:40%;
        left: 50%;
        margin: -300px 0 0 -350px;
        background:#eee;
        z-index: 2;
    }
    .black_bg{
        display: none;
        position: absolute;
        content: "";
        width: 100%;
        height: 100%;
        background-color:rgba(0, 0,0, 0.5);
        top:0;
        left: 0;
        z-index: 1;
    }
    .black_bg_2{
        display: none;
        position: absolute;
        content: "";
        width: 100%;
        height: 100%;
        background-color:rgba(0, 0,0, 0.5);
        top:0;
        left: 0;
        z-index: 1;
    }
    .modal_close{
        width: 26px;
        height: 26px;
        position: absolute;
        top: -30px;
        right: 0;
    }
    .modal_close> a{
        display: block;
        width: 100%;
        height: 100%;
        background:url(https://img.icons8.com/metro/26/000000/close-window.png);
        text-indent: -9999px;
    }
    
    .modal_close_2{
        width: 26px;
        height: 26px;
        position: absolute;
        top: -30px;
        right: 0;
    }
    .modal_close_2> a{
        display: block;
        width: 100%;
        height: 100%;
        background:url(https://img.icons8.com/metro/26/000000/close-window.png);
        text-indent: -9999px;
    }
    #stickerImg {
    	width: 60px;
    	height: auto;
    }
    #imgDiv{
    	text-align: center;
    }

</style>
</head>

<div><jsp:include page="/menu.jsp" flush="false"></jsp:include></div>
<%
	// 현재 세션 상태를 체크한다
	String userID = null;
	if(session.getAttribute("userID") != null){
		userID = (String)session.getAttribute("userID");
	}
	
	if(userID == null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 하세요')");
		script.println("location.href='login.jsp'");
		script.println("</script>");
	}
	
	
	//다이어리 수정을 위해 날짜 받음
	String diaryDate = request.getParameter("dDate");
	diary = new DiaryDAO().getDiary(userID, diaryDate);
	
	String dsticker = request.getParameter("diarySticker");
	if(dsticker != null){
		diary.setDiarySticker(dsticker);
	}
	String dairyT = request.getParameter("diaryTitle");
	String dairyC = request.getParameter("diaryContent");

%>
<!-- 모달창 시작 -->
<div class="black_bg">
<div class="modal_wrap" style= "border-radius:20px;">
    <div>
    	<div>
    		<div class="modal_close"><a href="#">close</a></div>
    		<br>
    		<h3 style="font:sans-serif; text-align: center; color:#222831">Sticker</h3>
    		<hr style="color:black">
    	</div>
	    <div>
	        <form action = "write.jsp?dDate=<%= diaryDate%>&diarySticker=<%= diary.getDiarySticker()%>&diaryTitle=<%= dairyT%>&diaryContent=<%= dairyC%>">
	        	<%for(int i=1; i < 50; i = i+7){ %>
	        		&nbsp;&nbsp;
	        		<div id="imgDiv">
	        			<input type="radio" name="diarySticker" value= "img/sticker/kawaii_kitty_lineal_color-<%=i%>.png">
	        			<img id="stickerImg" src="img/sticker/kawaii_kitty_lineal_color-<%=i%>.png">&nbsp;
	        			
	        			<input type="radio" name="diarySticker" value= "img/sticker/kawaii_kitty_lineal_color-<%=i+1%>.png">
	           			<img id="stickerImg" src="img/sticker/kawaii_kitty_lineal_color-<%=i+1%>.png">&nbsp;
	           			
	           			<input type="radio" name="diarySticker" value= "img/sticker/kawaii_kitty_lineal_color-<%=i+2%>.png">
	        			<img id="stickerImg" src="img/sticker/kawaii_kitty_lineal_color-<%=i+2%>.png">&nbsp;
	        			
	        			<input type="radio" name="diarySticker" value= "img/sticker/kawaii_kitty_lineal_color-<%=i+3%>.png">
	        			<img id="stickerImg" src="img/sticker/kawaii_kitty_lineal_color-<%=i+3%>.png">&nbsp;
	        			
	        			<input type="radio" name="diarySticker" value= "img/sticker/kawaii_kitty_lineal_color-<%=i+4%>.png">
	        			<img id="stickerImg" src="img/sticker/kawaii_kitty_lineal_color-<%=i+4%>.png">&nbsp;
	        			
	        			<input type="radio" name="diarySticker" value= "img/sticker/kawaii_kitty_lineal_color-<%=i+5%>.png">
	        			<img id="stickerImg" src="img/sticker/kawaii_kitty_lineal_color-<%=i+5%>.png">&nbsp;
	        			
	        			<input type="radio" name="diarySticker" value= "img/sticker/kawaii_kitty_lineal_color-<%=i+6%>.png">
	        			<img id="stickerImg" src="img/sticker/kawaii_kitty_lineal_color-<%=i+6%>.png">&nbsp;
	        		</div>
	        		<br>
	        		
	        	<%} 
	        		
	        	
	        	%>
	        	<div id="imgDiv"><input type="radio" name="diarySticker" value="" checked="checked"><p>선택안함</p></div>
	        	<input type="hidden" name="dDate" value="<%= diaryDate%>">
	        	<input type="hidden" name="diaryTitle" value="<%= dairyT%>">
	        	<input type="hidden" name="diaryContent" value="<%= dairyC%>">
	        	
	        	<div style= "text-align: right; margin: 20px;"><button id="btn-Yes" class="btn btn-danger my-2 my-sm-0" type="submit">선택</button></div>
	        	
	        	<br>
	        	<br>
	        </form>
	    </div>
    </div>
    
</div>
</div>

<div class="black_bg_2"></div>
<div class="modal_wrap_2" style= "border-radius:20px;">
    <div>
    	<div>
    	<div class="modal_close_2"><a href="#">close</a></div>
    	<br>
    		<h3 style="font:sans-serif; text-align: center; color:#222831">Sticker</h3>
    		<hr style="color:black">
    	</div>
	    <div>
	        <form action = "write.jsp?dDate=<%= diaryDate%>&diarySticker=<%= diary.getDiarySticker()%>&diaryTitle=<%= dairyT%>&diaryContent=<%= dairyC%>">
	        	<%for(int i=1; i < 50; i = i+7){ %>
	        		&nbsp;&nbsp;
	        		<div id="imgDiv">
	        			<input type="radio" name="diarySticker" value= "img/sticker/backtoschool-linealcolor-<%=i%>.png">
	        			<img id="stickerImg" src="img/sticker/backtoschool-linealcolor-<%=i%>.png">&nbsp;
	        			
	        			<input type="radio" name="diarySticker" value= "img/sticker/backtoschool-linealcolor-<%=i+1%>.png">
	           			<img id="stickerImg" src="img/sticker/backtoschool-linealcolor-<%=i+1%>.png">&nbsp;
	           			
	           			<input type="radio" name="diarySticker" value= "img/sticker/backtoschool-linealcolor-<%=i+2%>.png">
	        			<img id="stickerImg" src="img/sticker/backtoschool-linealcolor-<%=i+2%>.png">&nbsp;
	        			
	        			<input type="radio" name="diarySticker" value= "img/sticker/backtoschool-linealcolor-<%=i+3%>.png">
	        			<img id="stickerImg" src="img/sticker/backtoschool-linealcolor-<%=i+3%>.png">&nbsp;
	        			
	        			<input type="radio" name="diarySticker" value= "img/sticker/backtoschool-linealcolor-<%=i+4%>.png">
	        			<img id="stickerImg" src="img/sticker/backtoschool-linealcolor-<%=i+4%>.png">&nbsp;
	        			
	        			<input type="radio" name="diarySticker" value= "img/sticker/backtoschool-linealcolor-<%=i+5%>.png">
	        			<img id="stickerImg" src="img/sticker/backtoschool-linealcolor-<%=i+5%>.png">&nbsp;
	        			
	        			<input type="radio" name="diarySticker" value= "img/sticker/backtoschool-linealcolor-<%=i+6%>.png">
	        			<img id="stickerImg" src="img/sticker/backtoschool-linealcolor-<%=i+6%>.png">&nbsp;
	        		</div>
	        		<br>
	        		
	        	<%} 
	        		
	        	
	        	%>
	        	<div id="imgDiv"><input type="radio" name="diarySticker" value="" checked="checked"><p>선택안함</p></div>
	        	<input type="hidden" name="dDate" value="<%= diaryDate%>">
	        	<input type="hidden" name="diaryTitle" value="<%= dairyT%>">
	        	<input type="hidden" name="diaryContent" value="<%= dairyC%>">
	        	
	        	<div style= "text-align: right; margin: 20px;"><button id="btn-Yes" class="btn btn-danger my-2 my-sm-0" type="submit">선택</button></div>
	        	
	        	<br>
	        	<br>
	        </form>
	    </div>
    </div>
    
</div>
<!-- 모달창 끝 -->

<body cellpadding="0" cellspacing="0" marginleft="0" margintop="0" width="100%" height="100%" align="center">


<br>
<!-- 다이어리 작성 -->
<div class="card align-middle" style="width:50rem; border-radius:20px;">
	<div class="card-title" style="margin-top:30px;">
		<h2 class="card-title text-center" style="color:#113366;">Diary</h2>
	</div>
	<div class="card-body">
    		<form method="post" action="writeAction.jsp">
			<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd" id="diaryfrom">
				<tbody>
					<tr>
						<td><input type="text" class="form-control" placeholder="제목" name="diaryTitle" maxlength="10"></td>
					</tr>
					<tr style="background-color: #f2f2f2">

						<td style= "text-align: right;">

							<%

								if(request.getParameter("diarySticker").equals("null")){%>
								<p></p>
							<%}else{ %>
								<img id="stickerImg" src="<%=dsticker%>">&nbsp;
							<%} %>
						
						<button type="button" class="btn btn-info" id="modal_btn">
						  Kitty Sticker
						</button>
						<button type="button" class="btn btn-info" id="modal_btn_2">
						  School sticker
						</button>
						</td>
					</tr>
					<tr style="background-color: #f2f2f2">
						<td style="text-align: right;">
							<script>
								$(function() {

								    $( "#testDatepicker" ).datepicker({
								    	showOn : "both",
								    	buttonImage : './img/iconCal.png',
								    	nextText: '다음달',
								    	prevText: '이전달',
								    	showButtonPanel: true,
								    	currentText: '오늘 날짜',
								    	closeText: '닫기', 
								    	dateFormat: "yy-mm-dd"								    	
								    	
								    });
								    
								    $.datepicker._gotoToday = function(id) {
								        $(id).datepicker('setDate', new Date()).datepicker('hide').blur();
								    };
								    
								    diaryDate = $( "#testDatepicker" ).datepicker("getDate");
								});
								
							</script>
							날짜 : <input type="text" id="testDatepicker" value = <%= diaryDate%> name="diaryDate">
						</td>
					</tr>
					
					<tr style="background-color: #f2f2f2">
						<td><textarea class="form-control" placeholder="내용" name="diaryContent" maxlength="2048" style="height: 350px;"></textarea></td>
					</tr>
				</tbody>
			</table>
			<!-- 글쓰기 버튼 생성 -->
			
			<input type="hidden" name ="diarySticker" value=<%=dsticker %>>
			<button id="btn-Yes" class="btn btn-lg btn-primary btn-block" type="submit">저장</button>
		</form>
	</div>
</div>

<!-- 모달 창 띄우는 스크립트 -->
<script>
    window.onload = function() {
 
    function onClick() {
        document.querySelector('.modal_wrap').style.display ='block';
        document.querySelector('.black_bg').style.display ='block';
    }
    function onClick2() {
        document.querySelector('.modal_wrap_2').style.display ='block';
        document.querySelector('.black_bg_2').style.display ='block';
    } 
    function offClick() {
        document.querySelector('.modal_wrap').style.display ='none';
        document.querySelector('.black_bg').style.display ='none';
    }
    function offClick2() {
        document.querySelector('.modal_wrap_2').style.display ='none';
        document.querySelector('.black_bg_2').style.display ='none';
    }
 
    document.getElementById('modal_btn_2').addEventListener('click', onClick2);
    document.querySelector('.modal_close_2').addEventListener('click', offClick2);
    
    document.getElementById('modal_btn').addEventListener('click', onClick);
    document.querySelector('.modal_close').addEventListener('click', offClick);
    
    
 
};
</script>
<!-- footer -->
<div><jsp:include page="/footer.jsp" flush="false"></jsp:include></div>
</body>
</html>