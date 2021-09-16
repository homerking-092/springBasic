<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>게시물 상세 조회</h1>
	<table border="1">
		<tr>
			<td>번호</td>
			<td>${get.bno }</td>
		</tr>
		<tr>
			<td>제목</td>
			<td>${get.content }</td>
		</tr>
		<tr>
			<td>내용</td>
			<td><textarea rows="20" cols="40">${get.bno }</textarea> </td>
		</tr>
		<tr>
			<td>글쓴이</td>
			<td>${get.writer }</td>
		</tr>
	</table>
</body>
</html>