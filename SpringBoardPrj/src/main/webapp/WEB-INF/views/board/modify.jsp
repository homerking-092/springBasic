<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	${vo }<br>
	<p>	
		페이지번호: ${param.pageNum }
		검색조건: ${param.searchType }
		키워드: ${param.keyword }
	</p>
	<h1>${vo.bno }번 글 수정 페이지</h1>
	<!-- 수정을 하면서 결과페이지에 페이지번호, 검색조건, 키워드를 넘겨야함
	수정로직은 post이기 때문에 어쩔수 없이 컨트롤러를 경유해서 데이터를 전달합니다
	controller내부의 modify메서드에 위의 3가지 정보를 모두 처리할 수 있는
	SearchCriteria를 추가로 선언해서 받아줍니다 -->
	<form action="/board/modify" method="post">
	<input type="hidden" name="bno" value="${vo.bno }">
	<input type="hidden" name="pageNum" value="${param.pageNum }">
	<input type="hidden" name="searchType" value="${param.searchType }">
	<input type="hidden" name="keyword" value="${param.keyword }">
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