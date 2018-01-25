<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.google.appengine.api.datastore.DatastoreService" %>
<%@ page import="com.google.appengine.api.datastore.DatastoreServiceFactory" %>
<%@ page import="com.google.appengine.api.datastore.Entity" %>
<%@ page import="com.google.appengine.api.datastore.FetchOptions" %>
<%@ page import="com.google.appengine.api.datastore.Key" %>
<%@ page import="com.google.appengine.api.datastore.KeyFactory" %>
<%@ page import="com.google.appengine.api.datastore.Query" %>
<%@ page import="java.util.List" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
	<head>
		<title>RedShift Data Center</title>
	</head>
<%
	DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
	UserService userService = UserServiceFactory.getUserService();
	User user = userService.getCurrentUser();
	if(user != null){
		Key entityUserKey = KeyFactory.createKey("Entity User", "default");
		Filter userIDFilter = new FilterPredicate("User", Query.FilterOperator.EQUAL, user.getUserId());
		Query userQuery = new Query("Entity User", entityUserKey).setFilter(userIDFilter);
		Entity loggedUser = datastore.prepare(userQuery).asSingleEntity();
		if (loggedUser != null) {
%>
	<body>
<%
			Key equipmentKey = KeyFactory.createKey("Equipment", (String) loggedUser.getProperty("Entity Name"));
			Query equipmentQuery = new Query("Equipment", equipmentKey);
			List<Entity> equipmentList = datastore.prepare(equipmentQuery).asList(FetchOptions.Builder.withDefaults());
			for(Entity equipment : equipmentList){
				pageContext.setAttribute("equipmentLink", "/viewEquipmentDetails.jsp?key="+KeyFactory.keyToString(equipment.getKey()));
				pageContext.setAttribute("equipment", equipment.getProperty("Description") + " - " + equipment.getProperty("Status"));
%>
		<p><a href="${fn:escapeXml(equipmentLink)}">${fn:escapeXml(equipment)}</a></p>
<%
			}
%>
	</body>
<%
		}
	} else {
%>
	<body>
		<br>
		<br>
		<a href="<%= userService.createLoginURL(request.getRequestURI()) %>" id="loginLink">SIGN IN</a>
	</body>
<%
	}
%>
</html>