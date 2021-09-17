<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	${vo }
	<h1>${vo.bno }번 글 수정 페이지</h1>
	<form action="/board/modify" method="post">
	<input type="hidden" name="bno" value="${vo.bno }">
	<table border="1">
		<tr>
			<td>제목</td>
			<td> <input type="text" value="${vo.title }" name="title"> </td>
		</tr>
		<tr>
			<td>내용</td>
			<td><textarea name="content" rows="20" cols="40">${vo.content }</textarea> </td>
		</tr>
		<tr>
			<td>글쓴이</td>
			<td> <input name="writer" value="${vo.writer }" readonly> </td>
		</tr>
	</table>
	<input type="submit" value="수정완료">
	<input type="reset" value="초기화">
	</form>
	<a href="/board/list"><input type="button" value="목록으로"></a>
</body>
</html>