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
	<a href="/board/list"><input type="button" value="목록으로"></a>
	<%-- 수정페이지로 넘어가는 버튼 추가 --%>
	<form action="/board/boardmodify" method="post">
		<input type="hidden" name="bno" value="${get.bno }">
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