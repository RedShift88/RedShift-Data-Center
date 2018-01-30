<!DOCTYPE html>
<%@ page import="com.google.appengine.api.users.UserService" %>
<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>
<html>
	<head>
		<title>RedShift Data Center</title>
	</head>
	<body>
		<h1>Equipment</h1>
		<div><a href="/equipmentList.jsp">Equipment List</a></div>
		<h1>Maintenance Event</h1>
		<div><a href="/errors/comingSoon.jsp">Maintenance Event Form</a></div>
		<h2>Sign Out</h2>
<%
	UserService userService = UserServiceFactory.getUserService();
%>
		<div><a href="<%= userService.createLogoutURL("/") %>">Sign Out</a></div>
	</body>
</html>
