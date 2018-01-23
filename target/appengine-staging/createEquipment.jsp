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
	<body>
		<h1>Equipment Form</h1>

		<p>Please enter the details of the equipment below</p>
		
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
	DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
	Key equipmentTypeKey = KeyFactory.createKey("Equipment Type", "default");
	Query equipmentTypeQuery = new Query("Equipment Type", equipmentTypeKey);
	List<Entity> equipmentTypeList = datastore.prepare(equipmentTypeQuery).asList(FetchOptions.Builder.withDefaults());
	for(Entity equipmentType : equipmentTypeList){
		pageContext.setAttribute("equipmentType", equipmentType.getProperty("Description"));
%>
				<option value="${fn:escapeXml(equipmentType)}">${fn:escapeXml(equipmentType)}</option>
<%
	}
%>
			</select><br>
			<input type="submit" value="Submit">
		</form>
	</body>
</html>