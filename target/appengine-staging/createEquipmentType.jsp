<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
	<head>
		<title>RedShift Data Center</title>
		<script type="text/JavaScript" src="/javascript/addEquipmentProperty.js"></script>
	</head>
	<body>
		<h1>Equipment Type Form</h1>

		<p>Please enter the details of the equipment type below</p>
		
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
				<option value="Phone Number">Phone Number</option>
				<option value="Email Address">Email Address</option>
				<option value="Postal Address">Postal Address</option>
			</select><br><br>
			<button type="button" onclick="addPropertyItem(2);" id="addPropertyButton" >Add property</button><br><br>
			<input id="submitButton" type="submit" value="Submit">
		</form>
	</body>
</html>