<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
	<head>
		<title>RedShift Data Center</title>
	</head>
	<body>
		<h1>Service Tech Form</h1>

		<p>Please enter the details of the Service Tech below</p>
		
		<form action="/createServiceTech" method="post">
			Name:<br>
			<input type="text" name="name"><br>
			Notes:<br>
			<textarea rows="5" cols="75" name="notes"></textarea><br>
			Email:<br>
			<input type="email" name="email"><br>
			This email address will be used for verification. Please ensure that it is a valid Google account.<br>
			<input type="submit" value="Submit">
		</form>
	</body>
</html>