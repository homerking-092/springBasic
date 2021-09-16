<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>게시물 입력창</h1>
	<form action="/board/register" method="post">
		<input type="text" name="title" placeholder="제목"><br>
		<textarea rows="10" cols="30" name="content" placeholder="내용"></textarea> <br>
		<input type="text" name="writer" placeholder="글쓴이"> 
		<input type="submit" value="확인">
	</form>
</body>
</html>