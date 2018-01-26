<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.google.appengine.api.users.User" %>
<%@ page import="com.google.appengine.api.users.UserService" %>
<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>
<%@ page import="com.google.appengine.api.datastore.DatastoreService" %>
<%@ page import="com.google.appengine.api.datastore.DatastoreServiceFactory" %>
<%@ page import="com.google.appengine.api.datastore.Entity" %>
<%@ page import="com.google.appengine.api.datastore.Key" %>
<%@ page import="com.google.appengine.api.datastore.KeyFactory" %>
<%@ page import="com.google.appengine.api.datastore.Query" %>
<%@ page import="com.google.appengine.api.datastore.Query.Filter" %>
<%@ page import="com.google.appengine.api.datastore.Query.FilterPredicate" %>
<html>
	<head>
		<title>RedShift Data Center</title>
		<script type="text/JavaScript" src="/javascript/addEquipmentProperty.js"></script>
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
		<h1>Equipment Type Form</h1>
		<p>Please enter the details of the equipment type below</p>
		<p>Alternatively, you can use a pre-defined template: <a href="/entityAdmin/createEquipmentTypeVehicleTemplate.jsp">Vehicle Template</a></p>
		<form action="/createEquipmentType" method="post" id="equipmentTypeForm">
			Equipment Description:<br>
			<input type="text" name="description"><br><br>
			Property #1 Description:<br>
			<input type="text" name="propertyDescription1"><br><br>
			Property #1 Type:<br>
			<select name="propertyType1">
				<option value="String">Short Text</option>
				<option value="Text">Long Text</option>
				<option value="Drop Down">Drop Down</option>
				<option value="Integer">Integer</option>
				<option value="Double">Decimal</option>
				<option value="Boolean">True/False</option>
				<option value="Date">Date</option>
				<option value="DateTime">Date & Time</option>
				<option value="Duration">Duration</option>
				<option value="Phone Number">Phone Number</option>
				<option value="Email Address">Email Address</option>
				<option value="Postal Address">Postal Address</option>
			</select><br><br>
			Property #1 Options:<br>
			<input type="text" name="propertyOptions1"><br><br>
			Property #1 Trackable:<br>
			<select name="propertyTracking1">
				<option value="true">True</option>
				<option value="false">False</option>
			</select><br><br>
			<button type="button" onclick="addPropertyItem(2);" id="addPropertyButton" >Add property</button><br><br>
			<input id="submitButton" type="submit" value="Submit">
		</form>
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