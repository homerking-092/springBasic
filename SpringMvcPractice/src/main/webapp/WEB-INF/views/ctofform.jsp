<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form action="/ctof" method="post">
		<input type="number" name="cel" placeholder="섭씨 입력" required>
		<input type="submit" value="제출">
		
		<h3>섭씨 : ${cel } °C</h3>
		<h3>화씨 : ${fahren } °F</h3>
	</form> 
</body>
</html>