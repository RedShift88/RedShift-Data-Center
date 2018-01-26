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
		pageContext.setAttribute("entityKey", (String) request.getParameter("key"));
%>
	<body>
		<h1>Admin Details Form</h1>

		<p>Please enter your details below</p>
		<form action="/createEntityAdmin" method="post">
			<input type="hidden" name="entityKey" value="${fn:escapeXml(entityKey)}">
			Name:<br>
			<input type="text" name="name"><br><br>
			<input type="submit" value="Submit">
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