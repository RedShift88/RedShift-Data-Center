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
<%
	DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
	Key equipmentKey = KeyFactory.createKey("Equipment", "default");
	Query equipmentQuery = new Query("Equipment", equipmentKey);
	List<Entity> equipmentList = datastore.prepare(equipmentQuery).asList(FetchOptions.Builder.withDefaults());
	for(Entity equipment : equipmentList){
		pageContext.setAttribute("equipment", equipment.getProperty("Description") + " - " + equipment.getProperty("Status"));
%>
		<p>${fn:escapeXml(equipment)}</p><br>
<%
	}
%>
	</body>
</html>