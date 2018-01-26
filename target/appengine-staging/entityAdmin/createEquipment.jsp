<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.google.appengine.api.users.User" %>
<%@ page import="com.google.appengine.api.users.UserService" %>
<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>
<%@ page import="com.google.appengine.api.datastore.DatastoreService" %>
<%@ page import="com.google.appengine.api.datastore.DatastoreServiceFactory" %>
<%@ page import="com.google.appengine.api.datastore.Entity" %>
<%@ page import="com.google.appengine.api.datastore.FetchOptions" %>
<%@ page import="com.google.appengine.api.datastore.Key" %>
<%@ page import="com.google.appengine.api.datastore.KeyFactory" %>
<%@ page import="com.google.appengine.api.datastore.Query" %>
<%@ page import="com.google.appengine.api.datastore.Query.Filter" %>
<%@ page import="com.google.appengine.api.datastore.Query.FilterPredicate" %>
<%@ page import="com.google.appengine.api.datastore.EntityNotFoundException" %>
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
		<h1>Equipment Form</h1>

		<p>Please enter the equipment below</p>
		
		<form action="/createEquipment" method="post">
			Description:<br>
			<input type="text" name="description"><br>
			Status:<br>
			<select name="status">
				<option value="Active">Active</option>
				<option value="Under Repair">Under Repair</option>
				<option value="Inactive">Inactive</option>
			</select><br>
			Type:<br>
			<select name="type">
<%
			Key entityKey = (Key) loggedUser.getProperty("Parent Entity");
			try{
				Entity entity = datastore.get(entityKey);
				Key equipmentTypeKey = KeyFactory.createKey("Equipment Type", (String) entity.getProperty("Name"));
				Query equipmentTypeQuery = new Query("Equipment Type", equipmentTypeKey);
				List<Entity> equipmentTypeList = datastore.prepare(equipmentTypeQuery).asList(FetchOptions.Builder.withDefaults());
				for(Entity equipmentType : equipmentTypeList){
					pageContext.setAttribute("equipmentType", equipmentType.getProperty("Description"));
					pageContext.setAttribute("equipmentTypeKey", KeyFactory.keyToString(equipmentType.getKey()));
%>
				<option value="${fn:escapeXml(equipmentTypeKey)}">${fn:escapeXml(equipmentType)}</option>
<%
				}
			}catch(EntityNotFoundException e){
				e.printStackTrace();
			}
		}
%>
			</select><br><br>
			<input type="submit" value="Submit">
		</form>
	</body>
<%
	}
%>
			
</html>