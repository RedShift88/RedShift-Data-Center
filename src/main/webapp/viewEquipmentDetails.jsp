<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.google.appengine.api.datastore.DatastoreService" %>
<%@ page import="com.google.appengine.api.datastore.DatastoreServiceFactory" %>
<%@ page import="com.google.appengine.api.datastore.Entity" %>
<%@ page import="com.google.appengine.api.datastore.FetchOptions" %>
<%@ page import="com.google.appengine.api.datastore.Key" %>
<%@ page import="com.google.appengine.api.datastore.KeyFactory" %>
<%@ page import="com.google.appengine.api.datastore.Query" %>
<%@ page import="com.google.appengine.api.datastore.EntityNotFoundException" %>
<%@ page import="java.util.List" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%
	DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
	try {
		Key equipmentKey = KeyFactory.stringToKey((String) request.getParameter("key"));
		Entity equipment = datastore.get(equipmentKey);
%>
<html>
	<head>
		<title>RedShift Data Center</title>
	</head>
	<body>
		<h1>Equipment Details</h1>
<%
		pageContext.setAttribute("equipmentDescription", equipment.getProperty("Description"));
		pageContext.setAttribute("equipmentStatus", equipment.getProperty("Status"));
		Key typeKey = (Key) equipment.getProperty("Type");
		Entity equipmentType = datastore.get(typeKey);
		pageContext.setAttribute("equipmentType", equipmentType.getProperty("Description"));
%>
			<p><b>Description:</b> ${fn:escapeXml(equipmentDescription)}</p>
			<p><b>Status:</b> ${fn:escapeXml(equipmentStatus)}</p>
			<p><b>Type:</b> ${fn:escapeXml(equipmentType)}</p>
			<br>
<%
	Integer propertyNumber = 1;
	String parameterToCheck = "Property " + propertyNumber + " Description";
	while(equipmentType.hasProperty(parameterToCheck)){
		pageContext.setAttribute("propertyDescription", equipmentType.getProperty("Property " + propertyNumber + " Description"));
		if(equipment.hasProperty("Property " + propertyNumber)){
			pageContext.setAttribute("propertyResult", equipment.getProperty("Property " + propertyNumber));
		}else{
			pageContext.setAttribute("propertyResult", "Configuration Error");
		}
		if((Boolean) equipmentType.getProperty("Property " + propertyNumber + " Tracking")){
%>
			<p style="color: darkcyan;"><b>${fn:escapeXml(propertyDescription)}:</b> ${fn:escapeXml(propertyResult)}</p>
<%
		}else{
%>
			<p><b>${fn:escapeXml(propertyDescription)}:</b> ${fn:escapeXml(propertyResult)}</p>
<%
		}
		propertyNumber += 1;
		parameterToCheck = "Property " + propertyNumber + " Description";
	}
%>
	</body>
</html>
<%
	}catch(EntityNotFoundException e){
%>
<html>
	<head>
		<title>RedShift Data Center</title>
	</head>
	<body>
		<h1 style="text-align: center;">The report you selected cannot be displayed at this time, please try again.</h1>
	</body>
</html>
<%
	}
%>