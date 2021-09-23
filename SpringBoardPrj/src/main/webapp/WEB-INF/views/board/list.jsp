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
	
	<!-- 모달 코드는 작성이 안되어 있는게 아니고
	작성은 해뒀지만 css의 display옵션을 none으로 평상시에 두고
	특정한 요건을 만족했을떄만 display를 허용하도록 설계되어 있습니다
	아래와 같이 모달 예시코드를 붙여넣어도
	일반 화면에서는 보이지 않습니다 -->
	<div class="modal" id="myModal" tabindex="-1">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">등록 확인</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <p>${bno }번째 글이 등록되었습니다</p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>
	
	<!-- 부트스트랩용 JS파일도 마저 임포트
	코드 진행 순서가 위에서 아래이므로
	script 태그 위에 먼저 js파일을 집어넣습니다 -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-/bQdsTh/da6pkI1MST/rWKFNjaCP5gBSY4sEBT38Q/9RBh9AH40zEOg7Hlq2THRZ" crossorigin="anonymous"></script>
	<script type="text/javascript">
		// 컨트롤러에서 success라는 이름으로 날린 자료가 들어오는지 확인
		// 그냥 list 페이지 접근시는 success를 날려주지 않아서 아무것도 들어오지 않고
		// remove 로직의 결과로 넘어왔을때만 데이터가 전달됨
		var result = "${success}";
		var bno = "${bno}";
		
		// 모달 사용을 위한 변수 선언
		// 모달 공식문서의 자바스크립트 관련 실행 코드를 복사합니다
		var myModal = new bootstrap.Modal(document.getElementById('myModal'), focus)		
		console.log(result);
		console.log(bno);
		if (result === "success") {
			alert(bno + "번 글이 삭제되었습니다");
		}else if(result === "register"){
			// 공식 문서 하단의 myModal.show()
			myModal.show();
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