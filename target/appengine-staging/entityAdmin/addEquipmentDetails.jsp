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
		<h1>Equipment Details Form</h1>

		<p>Please enter the details of the equipment below</p>
		<form action="/addEquipmentDetails" method="post">
<%
		pageContext.setAttribute("equipmentKey", (String) request.getParameter("key"));
		pageContext.setAttribute("equipmentDescription", equipment.getProperty("Description"));
		pageContext.setAttribute("equipmentStatus", equipment.getProperty("Status"));
		Key typeKey = (Key) equipment.getProperty("Type");
		Entity equipmentType = datastore.get(typeKey);
		pageContext.setAttribute("equipmentType", equipmentType.getProperty("Description"));
%>
			<input type="hidden" name="equipmentKey" value="${fn:escapeXml(equipmentKey)}">
			<b>Description:</b> ${fn:escapeXml(equipmentDescription)}<br>
			<b>Status:</b> ${fn:escapeXml(equipmentStatus)}<br>
			<b>Type:</b> ${fn:escapeXml(equipmentType)}<br>
			<br>
<%
		Integer propertyNumber = 1;
		String parameterToCheck = "Property " + propertyNumber + " Description";
		while((Boolean) equipmentType.hasProperty(parameterToCheck)){
			String propertyType = (String) equipmentType.getProperty("Property " + propertyNumber + " Type");
			pageContext.setAttribute("propertyNumber", "propertyNumber"+propertyNumber);
			pageContext.setAttribute("propertyDescription", equipmentType.getProperty("Property " + propertyNumber + " Description"));
			String rawPropertyOptions = (String) equipmentType.getProperty("Property " + propertyNumber + " Options");
			String[] propertyOptions = rawPropertyOptions.split(",");
			pageContext.setAttribute("propertyTracking", equipmentType.getProperty("Property " + propertyNumber + " Tracking"));
			switch(propertyType){
				case "String":
%>
			${fn:escapeXml(propertyDescription)}:<br>
			<input type="text" name="${fn:escapeXml(propertyNumber)}"><br>
			Tracking: ${fn:escapeXml(propertyTracking)}<br><br>
<%
					break;
				case "Text":
%>
			${fn:escapeXml(propertyDescription)}:<br>
			<textarea name="${fn:escapeXml(propertyNumber)}" rows=5 cols=50 wrap="soft"></textarea><br>
			Tracking: ${fn:escapeXml(propertyTracking)}<br><br>
<%
					break;
				case "Drop Down":
%>
			${fn:escapeXml(propertyDescription)}:<br>
			<select name="${fn:escapeXml(propertyNumber)}">
<%
					for(String propertyOption : propertyOptions){
						pageContext.setAttribute("propertyOption", propertyOption);
%>
				<option value="${fn:escapeXml(propertyOption)}">${fn:escapeXml(propertyOption)}</option>
<%
				}
%>
			</select><br>
			Tracking: ${fn:escapeXml(propertyTracking)}<br><br>
<%
					break;
				case "Integer":
%>
			${fn:escapeXml(propertyDescription)}:<br>
			<input type="number" name="${fn:escapeXml(propertyNumber)}" min="0" step="1"><br>
			Tracking: ${fn:escapeXml(propertyTracking)}<br><br>
<%
					break;
				case "Double":
%>
			${fn:escapeXml(propertyDescription)}:<br>
			<input type="number" name="${fn:escapeXml(propertyNumber)}" min="0" step=".01"><br>
			Tracking: ${fn:escapeXml(propertyTracking)}<br><br>
<%
					break;
				case "Boolean":
%>
			${fn:escapeXml(propertyDescription)}:<br>
			<select name="${fn:escapeXml(propertyNumber)}">
				<option value="true">True</option>
				<option value="false">False</option>
			</select><br>
			Tracking: ${fn:escapeXml(propertyTracking)}<br><br>
<%
					break;
				case "Date":
%>
			${fn:escapeXml(propertyDescription)}:<br>
			<input type="date" name="${fn:escapeXml(propertyNumber)}"><br>
			Tracking: ${fn:escapeXml(propertyTracking)}<br><br>
<%
					break;
				default:
%>
			${fn:escapeXml(propertyDescription)}:<br>
			<input type="text" name="${fn:escapeXml(propertyNumber)}"><br>
			Tracking: ${fn:escapeXml(propertyTracking)}<br><br>
<%

			}
			propertyNumber += 1;
			parameterToCheck = "Property " + propertyNumber + " Description";
		}
%>
			<input type="submit" value="Submit">
		</form>
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