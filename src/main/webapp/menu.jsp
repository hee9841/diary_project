<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.11.2/css/all.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700&display=swap">
<link href="./css/bootstrap.min.css" rel="stylesheet">
<style>
	.pink-lighter-hover {
	  color: #ec407a;
	  -webkit-transition: .4s;
	  transition: .4s; }
	  
	.pink-lighter-hover:hover {
	  -webkit-transition: .4s;
	  transition: .4s;
	  color: #f386aa; }
	  
</style>
<header>
	<%
		String userID = null;
		if(session.getAttribute("userID") != null){
			userID = (String)session.getAttribute("userID");
		}
	%>
	<nav class="navbar navbar-expand-sm navbar-light #f5f5f5 grey lighten-4">
		<div class="navbar-brand">
		<a class="font-weight-bold pink-lighter-hover" href="main.jsp">SimpleDiary</a>
		</div>
		<button class="navbar-toggler collapsed" type="button" 
			data-toggle="collapse" data-target="#navbarSupportedContent" 
			aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
		
		<div class="collapse navbar-collapse" id="navbarSupportedContent">
			<ul class="navbar-nav mr-auto">
				<li class="nav-item atcive">
					<a class="nav-link" href="main.jsp">Monthly</a>
				</li>
			</ul>
			<%
				if(userID == null){
					
				
			%>
				<form class="form-inline my-2 my-lg-0">
					<a href="login.jsp" class="nav-link waves-effect">
		                <i class="fas fa-sign-in-alt"></i>Log-In
		            </a>
    			</form>
			<%
				}else{
			%>
				<form class="form-inline my-2 my-lg-0">
	      			<a href="logoutAction.jsp" class="nav-link waves-effect">
		                <i class="fas fa-sign-out-alt"></i>Log-Out
		            </a>
	    		</form>
			<%
				}
			%>

		</div>
	</nav>
</header>