<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-KyZXEAg3QhqLMpG8r+8fhAXLRk2vvoC2f3B09zVXn8CA5QIVfZOJ3BCsw2P0p/We"
	crossorigin="anonymous">
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>전체 게시글 조회</h1>
	<table class="table table-secondary table-striped table-sm table-striped table-hover">
		<tr>
			<th>번호</th>
			<th>제목</th>
			<th>글쓴이</th>
			<th>날짜</th>
			<th>수정날짜</th>
		</tr>
	<c:forEach var="list" items="${list }">
		<tr>
			<td>${list.bno }</td>
			<td><a href="/board/get?bno=${list.bno }">${list.title }</a></td>
			<td>${list.writer }</td>
			<td>${list.regdate }</td>
			<td>${list.updatedate }</td>
		</tr>
	</c:forEach>
	</table>
</body>
</html>