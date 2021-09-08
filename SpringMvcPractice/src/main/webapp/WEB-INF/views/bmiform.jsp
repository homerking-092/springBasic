<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form action="/bmi" method="post">
		<input type="text" name="height" placeholder="키" required><br>
		<input type="text" name="weight" placeholder="체중" required>
		
		<input type="submit" value="제출">
	</form>
</body>
</html>