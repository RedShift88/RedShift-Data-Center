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
		<h1>Equipment Type List</h1>

<%
			Key entityKey = (Key) loggedUser.getProperty("Parent Entity");
			try{
				Entity entity = datastore.get(entityKey);
				Key equipmentTypeKey = KeyFactory.createKey("Equipment Type", (String) entity.getProperty("Name"));
				Query equipmentTypeQuery = new Query("Equipment Type", equipmentTypeKey);
				List<Entity> equipmentTypeList = datastore.prepare(equipmentTypeQuery).asList(FetchOptions.Builder.withDefaults());
				Integer propertyNumber;
				String parameterToCheck;
				for(Entity equipmentType : equipmentTypeList){
					pageContext.setAttribute("equipmentType", equipmentType.getProperty("Description"));
%>
		<h3>Type Name: ${fn:escapeXml(equipmentType)}</h3>
<%
					propertyNumber = 1;
					parameterToCheck = "Property " + propertyNumber + " Description";
					while(equipmentType.hasProperty(parameterToCheck)){
						pageContext.setAttribute("propertyDescription", equipmentType.getProperty("Property " + propertyNumber + " Description"));
						pageContext.setAttribute("propertyType", equipmentType.getProperty("Property " + propertyNumber + " Type"));
						pageContext.setAttribute("propertyOptions", equipmentType.getProperty("Property " + propertyNumber + " Options"));
						if((Boolean) equipmentType.getProperty("Property " + propertyNumber + " Tracking")){
%>
		<details style="color: darkcyan;">
			<summary>${fn:escapeXml(propertyDescription)}</summary>
			<p style="padding-left: 15px;">Type: ${fn:escapeXml(propertyType)}<br>
			Options: ${fn:escapeXml(propertyOptions)}</p>
		</details><br>
<%
						}else{
%>
		<details>
			<summary>${fn:escapeXml(propertyDescription)}</summary>
			<p style="padding-left: 15px;">Type: ${fn:escapeXml(propertyType)}<br>
			Options: ${fn:escapeXml(propertyOptions)}</p>
		</details><br>
<%
						}
						propertyNumber += 1;
						parameterToCheck = "Property " + propertyNumber + " Description";
					}
				}
			}catch(EntityNotFoundException e){
				e.printStackTrace();
			}
		}
%>
	</body>
<%
	}
%>
			
</html>