<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Chat App - Create Profile</title>
</head>
<body>
	<h1>Login / Create Profile</h1>
	<form action="createOrLogin.jsp" method="post">
		Name: <input type="text" name="name" required><br> DOB: <input
			type="date" name="dob" required><br> <input
			type="submit" value="Submit">
	</form>
</body>
</html>
