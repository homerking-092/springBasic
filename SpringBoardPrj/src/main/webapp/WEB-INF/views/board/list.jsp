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
	
	<a href="/board/register"><input type="button" value="글쓰기" style="float: right;"></a>
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
	
	<%-- 페이지네이션 버튼위치
	페이지네이션 버튼을 상황에 맞게 출력하기 위해
	c 태그 라이브러리의 조건식을 활용합니다 --%>
	<nav aria-label="Page navigation example">
  <ul class="pagination justify-content-center" >
  
  	<!-- prev 버튼 
  	btnMaker의 prev가 true일떄만 뒤로가기 버튼 출력-->
  	<c:if test="${btnMaker.prev }">
  		<li class="page-item">
      <a class="page-link" href="/board/list?pageNum=${btnMaker.startPage -1 }&searchType=${btnMaker.cri.searchType}&keyword=${btnMaker.cri.keyword}" aria-label="Previous">
        <span aria-hidden="true">&laquo;</span>
      </a>
    </li>
  	</c:if>
    
    
    <!-- 번호 버튼
    c태그의 foreach 기능을 쓰되, begin, end속성을 이용해서
    startPage부터 endPage까지의 숫자들이 버튼으로 나열
    begin, end에 따른 루프 바퀴에 따른 변수명은 var속성으로 지정-->
    <!-- 1. 버튼이 갯수에 맞는지 확인 -->
    <!-- 2. 각 바퀴수별로 다른 수치를 버튼에 새기기 위해 var 속성에 변수명 적고 출력 -->
    <c:forEach var="pageNum" begin="${btnMaker.startPage }" end="${btnMaker.endPage }">
    <!-- 3. 현재 조회중 페이지 강조는 class 속성 내에서 삼항연산자를 이용해도 된다 -->
    <li class="page-item ${btnMaker.cri.pageNum == pageNum ? 'active' : ''}">
    <a class="page-link" href="/board/list?pageNum=${pageNum }&searchType=${btnMaker.cri.searchType}&keyword=${btnMaker.cri.keyword}">${pageNum }</a>
    </li>
    </c:forEach>
    
    <!-- next 버튼 -->
    <c:if test="${btnMaker.next }">
    <li class="page-item">
      <a class="page-link" href="/board/list?pageNum=${btnMaker.endPage + 1 }&searchType=${btnMaker.cri.searchType}&keyword=${btnMaker.cri.keyword}" aria-label="Next">
        <span aria-hidden="true">&raquo;</span>
      </a>
    </li>
    </c:if>
  </ul>
</nav>
	<form action="/board/list" method="get" style = "text-align:center;">
	<select name="searchType">
		<option value="n" <c:out value="${btnMaker.cri.searchType == null ? 'selected' : '' }"/>>
			-
		</option>
		<option value="t" <c:out value="${btnMaker.cri.searchType eq 't' ? 'selected' : '' }"/>>
			제목
		</option>
		<option value="c" <c:out value="${btnMaker.cri.searchType eq 'c' ? 'selected' : '' }"/>>
			내용
		</option>
		<option value="w" <c:out value="${btnMaker.cri.searchType eq 'w' ? 'selected' : '' }"/>>
			글쓴이
		</option>
		<option value="tc" <c:out value="${btnMaker.cri.searchType eq 'tc' ? 'selected' : '' }"/>>
			제목 + 내용
		</option>
		<option value="cw" <c:out value="${btnMaker.cri.searchType eq 'cw' ? 'selected' : '' }"/>>
			내용 + 글쓴이
		</option>
		<option value="tw" <c:out value="${btnMaker.cri.searchType eq 'tw' ? 'selected' : '' }"/>>
			제목 + 글쓴이
		</option>
		<option value="tcw" <c:out value="${btnMaker.cri.searchType eq 'tcw' ? 'selected' : '' }"/>>
			제목 + 내용 + 글쓴이
		</option>
	</select>
		<input type="text" name="keyword"  placeholder="검색어 입력해라" value="${btnMaker.cri.keyword }">
		<input type="submit" value="검색">
	</form>
	${btnMaker }
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