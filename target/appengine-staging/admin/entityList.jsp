<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.google.appengine.api.datastore.DatastoreService" %>
<%@ page import="com.google.appengine.api.datastore.DatastoreServiceFactory" %>
<%@ page import="com.google.appengine.api.datastore.Entity" %>
<%@ page import="com.google.appengine.api.datastore.FetchOptions" %>
<%@ page import="com.google.appengine.api.datastore.Key" %>
<%@ page import="com.google.appengine.api.datastore.KeyFactory" %>
<%@ page import="com.google.appengine.api.datastore.Query" %>
<%@ page import="com.google.appengine.api.datastore.Text" %>
<%@ page import="java.util.List" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
	<head>
		<title>RedShift Data Center</title>
	</head>
	<body>
<%
	DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
	Key entityKey = KeyFactory.createKey("Entity", "default");
	Query entityQuery = new Query("Entity", entityKey);
	List<Entity> entityList = datastore.prepare(entityQuery).asList(FetchOptions.Builder.withDefaults());
	for(Entity entity : entityList){
		pageContext.setAttribute("entityName", entity.getProperty("Name"));
		Text entityTextNotes = (Text) entity.getProperty("Notes");
		pageContext.setAttribute("entityNotes", entityTextNotes.getValue());
%>
		<h3>Name: ${fn:escapeXml(entityName)}</h3>
		<p>Notes: ${fn:escapeXml(entityNotes)}</p>
		<br>
<%
	}
%>
	</body>
</html>