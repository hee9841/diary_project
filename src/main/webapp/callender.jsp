<%@ page import="diary.Diary" %>
<%@ page import="diary.DiaryDAO" %>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   
<%
String userID = null;
if(session.getAttribute("userID") != null){
	userID = (String)session.getAttribute("userID");
	
}



int action = 0; //up(1) down(0) current(2)
int currYear = 0;
int currMonth = 0;
int currentDay = 1;
String boxSize = "80";

Calendar c = Calendar.getInstance();
Calendar cal = Calendar.getInstance();

if(request.getParameter("action") == null) {
    
     currMonth = c.get(Calendar.MONTH);
     currYear = c.get(Calendar.YEAR);
     currentDay = c.get(Calendar.DAY_OF_MONTH);
     cal.set(currYear,currMonth,1);
    
} else {
    
     if(request.getParameter("action") != null){
         
          currMonth = Integer.parseInt(request.getParameter("month"));
          currYear = Integer.parseInt(request.getParameter("year"));
          currentDay = Integer.parseInt(request.getParameter("curD"));
         
          if(Integer.parseInt(request.getParameter("action")) == 1) {

               cal.set(currYear, currMonth, 1);
               cal.add(Calendar.MONTH, 1); //다음달
               currMonth = cal.get(Calendar.MONTH);
               currYear = cal.get(Calendar.YEAR);
               currentDay = c.get(Calendar.DAY_OF_MONTH);
              
          } else if(Integer.parseInt(request.getParameter("action"))== 0) {              

               cal.set(currYear, currMonth, 1);
               cal.add(Calendar.MONTH, -1); //이전달
               currMonth = cal.get(Calendar.MONTH);
               currYear = cal.get(Calendar.YEAR);
               currentDay = c.get(Calendar.DAY_OF_MONTH);
          }else{
        	  cal.set(currYear, currMonth, 1);
        	  cal.add(Calendar.MONTH, -1);
              currMonth = cal.get(Calendar.MONTH);
              currYear = cal.get(Calendar.YEAR);
              currentDay = c.get(Calendar.DAY_OF_MONTH);
          }
         
     }
}

%>

<%!
     public boolean isDate(int y, int m, int d) {
    
          m -= 1;
          Calendar c = Calendar.getInstance();
          c.setLenient(false);
         
          try {
              
               c.set(y, m, d);
               Date dt = c.getTime();
              
          } catch(IllegalArgumentException e) {
               return false;
          }
          return true;
     }
%>

<%!
     public String getTitle(Calendar cal){
         
          SimpleDateFormat sdf = new SimpleDateFormat("yyyy년 MM월");
          return sdf.format(cal.getTime());    
     }

%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>JSP 달력(Calendar)</title>
<style>
    
    #calendarTable, #calendarTable th, #calendarTable td   {
        border-collapse: collapse;
        color: 	#222831;
                    
    } 
    
    #clendarHead div {
       float: left;
                    
    } 
    
    #calendarTable {
        border:2px solid #a6a9b6;
        width:690px;
    }
    
    #calendarTable th, #calendarTable td {
        /**/
        border:1px solid #a6a9b6;        
        border-collapse: collapse;
        padding: 5px;        
    }
    
    #calendarTable th {        
        background-color: #f1f1f1;
        color: 	#1E3269;
        
    }    
    #calendarTable td {        
        /**/
        text-align : left;            
    }
    
    #calendarTable td.empty {
        background-color: #f1f1f1;
    }
    
    #calendarTable td.toDayColor {
        background-color: #6C7EAA;
    }
    
    #stickerImg {
    	width: 30px;
    	height: auto;
    }
    	

</style>
</head>
<body bgcolor='white'>

<div width = "690px" id="clendarHead">
		<div width = "30%" align='right' valign='middle'>
			<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
			<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
			<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
			<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
			
			<a href="main.jsp?month=<%=currMonth%>&year=<%=currYear%>&curD=<%=currentDay%>&action=0">
            	<i class="fas fa-angle-left"></i>
        	</a>
        	
		</div>
		<div width = "40%" align='center' valign='middle'>
			<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
			<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
			<b><%= getTitle(cal)%></b>
		</div>
		<div width = "30%" align='left' valign='middle'>
			<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
			<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
			<a href="main.jsp?month=<%=currMonth%>&year=<%=currYear%>&curD=<%=currentDay%>&action=1">
            		<i class="fas fa-angle-right"></i>
        	</a>

	</div>
</div>

<div>
<table width="100%">
  <tr>         
  <td width="100%" >
    <table id="calendarTable">
       <tr>
              <th>일</th>
              <th>월</th>
              <th>화</th>
              <th>수</th>
              <th>목</th>
              <th>금</th>
              <th>토</th>                      
       </tr>
<%


//'Calendar loop

     int currDay;
     String todayColor;
     int count = 1;
     int dispDay = 1;


     for (int w = 1; w < 7; w++)
     {
%>
       <tr>
<%
          for (int d = 1; d < 8; d++)
          {
               if (!(count >= cal.get(Calendar.DAY_OF_WEEK))) //  
               {

%>
          <td class="empty">&nbsp;</td>
<%
                    count += 1;
               }
               else
               {

                    if (isDate (currYear, currMonth + 1, dispDay) ) // use the isDate method
                    {
                         //오늘
                         if (dispDay == c.get(Calendar.DAY_OF_MONTH) &&
                            c.get(Calendar.MONTH) == cal.get(Calendar.MONTH) 
                                && c.get(Calendar.YEAR) == cal.get(Calendar.YEAR) )
                         {
                             todayColor = "#ffe5b9";
                         }
                         else
                         {
                             todayColor = "";
                         }
                         
                         //달력에 다이어리 제목 표시 위한 날짜
                         String sYear = Integer.toString(currYear);
                         String sMonth = Integer.toString(currMonth + 1);
                         String sDay = Integer.toString(dispDay);
                        		 
                         String dDate = sYear +"-"+ sMonth +"-" + sDay;
                         Diary diary = new DiaryDAO().getDiary(userID, dDate);
                         
                         //로그인 했을 때만 달력 클릭 할 수 있음
                         if(userID != null){ //달력 클릭시 선택 날짜 넘겨줌
%>                        	  
							<td class="clickTable" bgcolor ="<%=todayColor%>" width="<%=boxSize%>" align="left" height="<%=boxSize%>" valign="top"
					          style = "cursor:pointer;" 
					          onClick = " location.href='main.jsp?month=<%=cal.get(Calendar.MONTH)+1%>&year=<%=cal.get(Calendar.YEAR)%>&curD=<%=dispDay%>&action=2' ">
					          	<%=dispDay%><br>
					          	<% if(diary.getDiaryTitle() != null){%>
					          		<p style="font: 5px sans-serif; text-align: center; "><%= diary.getDiaryTitle()%></p>
					          		<%if(diary.getDiarySticker() != null){ 
					          			if(diary.getDiarySticker().equals("null")){
					          				
					          			}else{
					
					          		%>
					          				<p><img id="stickerImg" src="<%=diary.getDiarySticker()%>"></p>
					          		<%} %>

					          		<%}else{ %>
					          			<p></p>
					          		<%} %>
					          							          		
					          	<%}else{ %>
					          		<br><p style="font: 20px">&nbsp;</p>
					          	<%} %>
					         </td><%
                         }else{
%>                        	 
                        	 <td bgcolor ="<%=todayColor%>" width="<%=boxSize%>" align="left" height="<%=boxSize%>" valign="top">
					          	<%=dispDay%><br>
					         </td>
                         <%}
          		
                         count += 1;
                         dispDay += 1;
                    }
                    else
                    {
%>
          <td class="empty" width="<%=boxSize%>" height="<%=boxSize%>">&nbsp;</td>
<%
                    }
               }
       }
%>
       </tr>
<%
}
%>
     </table>
     </td>
     </tr>
  </table>
 </div>

</body>
</html>
