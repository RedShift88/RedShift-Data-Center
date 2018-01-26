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
		<form action="/createEquipmentType" method="post" id="equipmentTypeForm">
			Equipment Description: Vehicle<br>
			<input type="hidden" name="description" value="Vehicle">
			Property #1 Description: Engine Oil<br>
			<input type="hidden" name="propertyDescription1" value="Engine Oil">
			Property #1 Type: Short Text<br>
			<input type="hidden" name="propertyType1" value="String">
			Property #1 Options: N/A<br>
			<input type="hidden" name="propertyOptions1" value="">
			Property #1 Trackable: False<br>
			<input type="hidden" name="propertyTracking1" value="false">
			Property #2 Description: Engine Oil Capacity<br>
			<input type="hidden" name="propertyDescription2" value="Engine Oil Capacity">
			Property #2 Type: Short Text<br>
			<input type="hidden" name="propertyType2" value="String">
			Property #2 Options: N/A<br>
			<input type="hidden" name="propertyOptions2" value="">
			Property #2 Trackable: False<br>
			<input type="hidden" name="propertyTracking2" value="false">
			Property #3 Description: Engine Oil Change Frequency<br>
			<input type="hidden" name="propertyDescription3" value="Engine Oil Change Frequency">
			Property #3 Type: Duration<br>
			<input type="hidden" name="propertyType3" value="Duration">
			Property #3 Options: N/A<br>
			<input type="hidden" name="propertyOptions3" value="Days,Weeks,Months,Years">
			Property #3 Trackable: False<br>
			<input type="hidden" name="propertyTracking3" value="false">
			Property #4 Description: Engine Oil Change Date<br>
			<input type="hidden" name="propertyDescription4" value="Engine Oil Change Date">
			Property #4 Type: Date<br>
			<input type="hidden" name="propertyType4" value="Date">
			Property #4 Options: N/A<br>
			<input type="hidden" name="propertyOptions4" value="">
			Property #4 Trackable: True<br>
			<input type="hidden" name="propertyTracking4" value="true">
			Property #5 Description: Transmission Oil<br>
			<input type="hidden" name="propertyDescription5" value="Transmission Oil">
			Property #5 Type: Short Text<br>
			<input type="hidden" name="propertyType5" value="String">
			Property #5 Options: N/A<br>
			<input type="hidden" name="propertyOptions5" value="">
			Property #5 Trackable: False<br>
			<input type="hidden" name="propertyTracking5" value="false">
			Property #6 Description: Transmission Oil Capacity<br>
			<input type="hidden" name="propertyDescription6" value="Transmission Oil Capacity">
			Property #6 Type: Short Text<br>
			<input type="hidden" name="propertyType6" value="String">
			Property #6 Options: N/A<br>
			<input type="hidden" name="propertyOptions6" value="">
			Property #6 Trackable: False<br>
			<input type="hidden" name="propertyTracking6" value="false">
			Property #7 Description: Transmission Oil Change Frequency<br>
			<input type="hidden" name="propertyDescription7" value="Transmission Oil Change Frequency">
			Property #7 Type: Duration<br>
			<input type="hidden" name="propertyType7" value="Duration">
			Property #7 Options: N/A<br>
			<input type="hidden" name="propertyOptions7" value="Days,Weeks,Months,Years">
			Property #7 Trackable: False<br>
			<input type="hidden" name="propertyTracking7" value="false">
			Property #8 Description: Transmission Oil Change Date<br>
			<input type="hidden" name="propertyDescription8" value="Transmission Oil Change Date">
			Property #8 Type: Date<br>
			<input type="hidden" name="propertyType8" value="Date">
			Property #8 Options: N/A<br>
			<input type="hidden" name="propertyOptions8" value="">
			Property #8 Trackable: True<br>
			<input type="hidden" name="propertyTracking8" value="true">
			Property #9 Description: Radiator Fluid<br>
			<input type="hidden" name="propertyDescription9" value="Radiator Fluid">
			Property #9 Type: Short Text<br>
			<input type="hidden" name="propertyType9" value="String">
			Property #9 Options: N/A<br>
			<input type="hidden" name="propertyOptions9" value="">
			Property #9 Trackable: False<br>
			<input type="hidden" name="propertyTracking9" value="false">
			Property #10 Description: Radiator Fluid Capacity<br>
			<input type="hidden" name="propertyDescription10" value="Radiator Fluid Capacity">
			Property #10 Type: Short Text<br>
			<input type="hidden" name="propertyType10" value="String">
			Property #10 Options: N/A<br>
			<input type="hidden" name="propertyOptions10" value="">
			Property #10 Trackable: False<br>
			<input type="hidden" name="propertyTracking10" value="false">
			Property #11 Description: Radiator Fluid Change Frequency<br>
			<input type="hidden" name="propertyDescription11" value="Radiator Fluid Change Frequency">
			Property #11 Type: Duration<br>
			<input type="hidden" name="propertyType11" value="Duration">
			Property #11 Options: N/A<br>
			<input type="hidden" name="propertyOptions11" value="Days,Weeks,Months,Years">
			Property #11 Trackable: False<br>
			<input type="hidden" name="propertyTracking11" value="false">
			Property #12 Description: Radiator Fluid Change Date<br>
			<input type="hidden" name="propertyDescription12" value="Radiator Fluid Change Date">
			Property #12 Type: Date<br>
			<input type="hidden" name="propertyType12" value="Date">
			Property #12 Options: N/A<br>
			<input type="hidden" name="propertyOptions12" value="">
			Property #12 Trackable: True<br>
			<input type="hidden" name="propertyTracking12" value="true">
			Property #13 Description: Differential Fluid<br>
			<input type="hidden" name="propertyDescription13" value="Differential Fluid">
			Property #13 Type: Short Text<br>
			<input type="hidden" name="propertyType13" value="String">
			Property #13 Options: N/A<br>
			<input type="hidden" name="propertyOptions13" value="">
			Property #13 Trackable: False<br>
			<input type="hidden" name="propertyTracking13" value="false">
			Property #14 Description: Differential Fluid Capacity<br>
			<input type="hidden" name="propertyDescription14" value="Differential Fluid Capacity">
			Property #14 Type: Short Text<br>
			<input type="hidden" name="propertyType14" value="String">
			Property #14 Options: N/A<br>
			<input type="hidden" name="propertyOptions14" value="">
			Property #14 Trackable: False<br>
			<input type="hidden" name="propertyTracking14" value="false">
			Property #15 Description: Differential Fluid Change Frequency<br>
			<input type="hidden" name="propertyDescription15" value="Differential Fluid Change Frequency">
			Property #15 Type: Duration<br>
			<input type="hidden" name="propertyType15" value="Duration">
			Property #15 Options: N/A<br>
			<input type="hidden" name="propertyOptions15" value="Days,Weeks,Months,Years">
			Property #15 Trackable: False<br>
			<input type="hidden" name="propertyTracking15" value="false">
			Property #16 Description: Differential Fluid Change Date<br>
			<input type="hidden" name="propertyDescription16" value="Differential Fluid Change Date">
			Property #16 Type: Date<br>
			<input type="hidden" name="propertyType16" value="Date">
			Property #16 Options: N/A<br>
			<input type="hidden" name="propertyOptions16" value="">
			Property #16 Trackable: True<br>
			<input type="hidden" name="propertyTracking16" value="true">
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