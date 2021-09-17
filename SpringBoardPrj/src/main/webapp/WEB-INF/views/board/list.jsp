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
	<a href="/board/register"><input type="button" value="글쓰기"></a>
	<table
		class="table table-secondary table-striped table-sm table-striped table-hover">
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
	<form action="/board/list" method="get" style = "text-align:center;">
		<input type="text" name="keyword"  placeholder="검색어 입력해라" value="${keyword }">
		<input type="submit" value="검색">
	</form>

	<script type="text/javascript">
		// 컨트롤러에서 success라는 이름으로 날린 자료가 들어오는지 확인
		// 그냥 list 페이지 접근시는 success를 날려주지 않아서 아무것도 들어오지 않고
		// remove 로직의 결과로 넘어왔을때만 데이터가 전달됨
		var result = "${success}";
		var bno = "${bno}";
		console.log(result);
		console.log(bno);
		if (result === "success") {
			alert(bno + "번 글이 삭제되었습니다");
		}
// 		var keyword = "${keyword}";
// 		if (keyword === "") {
// 			alert("검색어를 입력해주세요");
// 		}else{
// 			alert("찾으시는 내용이 없습니다");
// 			location.href = "/board/list";
// 		}
	</script>
</body>
</html>