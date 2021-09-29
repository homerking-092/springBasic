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
			<td>${get.title }</td>
		</tr>
		<tr>
			<td>내용</td>
			<td><textarea rows="20" cols="40">${get.content }</textarea> </td>
		</tr>
		<tr>
			<td>글쓴이</td>
			<td>${get.writer }</td>
		</tr>
	</table>
	<a href="/board/list?pageNum=${param.pageNum }&searchType=${param.searchType}&keyword=${param.keyword}"><input type="button" value="목록으로"></a>
	<%--  pageNum, searchType, keyword등이 들어오는지 여부 디버깅
	EL의 ${param.파라미터명}을 이용해 확인가능
	get 파라미터에 SearchCriteria를 선언해서 처리해도 되지만
	pageNum, searchType, keyword가 DB와 연계된 작업을 하지 않으므로
	굳이 두 군데를 고치지 않고 get.jsp에서 바로 받아 쓸 수 있도록 아래와 같이 활용하는게 효율적 --%>
		<p>	
			페이지번호: ${param.pageNum }
			검색조건: ${param.searchType }
			키워드: ${param.keyword }
		</p>
	<%-- 수정페이지로 넘어가는 버튼 추가 --%>
	<form action="/board/boardmodify" method="post">
		<input type="hidden" name="bno" value="${get.bno }">
		<input type="hidden" name="pageNum" value="${param.pageNum }">
		<input type="hidden" name="searchType" value="${param.searchType }">
		<input type="hidden" name="keyword" value="${param.keyword }">
		<input type="submit" value="수정하기">
	</form>
	<%-- 글 삭제용 버튼
		 글 삭제가 되면, 리스트페이지로 넘아가는데, 삭제로 넘어오는 경우는
		 alert()창을 띄워서 "글이 삭제되었습니다"가 출력되도록 로직 작성
	 --%>
	<form action="/board/remove" method="post" id="deleteForm">
		<input type="hidden" name="bno" value="${get.bno }">
		<input type="button" value="삭제하기" onclick="confirm_delete();">
	</form>
	
	<script type="text/javascript">
		function confirm_delete() {
			var deleteForm = document.getElementById('deleteForm');
			if (confirm("정말 삭제하시겠습니까?")) {
				alert("삭제 확인")
				deleteForm.submit();
			}else{
				alert("삭제 취소")
			}
		}
	</script>
	 
</body>
</html>