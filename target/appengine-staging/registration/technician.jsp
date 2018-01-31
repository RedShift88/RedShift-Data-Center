<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.google.appengine.api.users.User" %>
<%@ page import="com.google.appengine.api.users.UserService" %>
<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
	<head>
		<title>RedShift Data Center</title>
	</head>
<%
	UserService userService = UserServiceFactory.getUserService();
	User user = userService.getCurrentUser();
	if(user != null){
		pageContext.setAttribute("userKey", (String) request.getParameter("key"));
%>
	<body>
		<h1>Service Technician Registration</h1>

		<p>Please click the register button below to register your current account</p>
		<form action="/registerTechnician" method="post">
			<input type="hidden" name="userKey" value="${fn:escapeXml(userKey)}">
			<input type="submit" value="Register">
		</form>
	</body>
<%
	} else {
%>
	<body>
		<br>
		<br>
		<a href="<%= userService.createLoginURL(request.getRequestURI()+"?"+request.getQueryString()) %>" id="loginLink">SIGN IN</a>
	</body>
<%
	}
%>
</html>