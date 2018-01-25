<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
	<head>
		<title>RedShift Data Center</title>
	</head>
	<body>
		<h1>Entity Form</h1>

		<p>Please enter the details of the Entity below</p>
		
		<form action="/createEntity" method="post">
			Name:<br>
			<input type="text" name="name"><br>
			Notes:<br>
			<textarea rows="5" cols="75" name="notes"></textarea><br>
			<input type="submit" value="Submit">
		</form>
	</body>
</html>