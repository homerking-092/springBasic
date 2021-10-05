<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<style>
#modDiv {
	width: 300px;
	height: 100px;
	background-color: green;
	position: absolute;
	top: 50%;
	left: 50%;
	margin-top: -50px;
	margin-left: -150px;
	padding: 10px;
	z-index: 1000;
}
</style>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<h2>Ajax테스트</h2>

	<div>
		<div>
			REPLYER <input type="text" name="replyer" id="newReplyWriter">
		</div>
		<div>
			REPLY TEXT <input type="text" name="reply" id="newReply">
		</div>
		<button id="replyAddBtn">ADD REPLY</button>
	</div>

	<ul id="replies">

	</ul>

	<!-- 모달 요소는 안 보이기 때문에 어디 넣어도 되지만 보통 html요소들 끼리 놨을떄
	제일 아래쪽에 작성하는 경우가 많음 -->
	<div id="modDiv" style="display: none;">
		<div class="modal-title"></div>
		<div>
			<input type="text" id="reply">
		</div>
		<div>
			<button type="button" id="replyModBtn">수정</button>
			<button type="button" id="replyDelBtn">삭제</button>
			<button type="button" id="closeBtn">닫기</button>
		</div>
	</div>



	<!-- jquery -->
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

	<!-- 코드는 위에서 아래로 실행되므로 ajax 스크립트 태그는 맨 아래에 -->
	<script type="text/javascript">
		var bno = 400;

		//////////////////////////////////////////////////////////
		// 비동기 코드
		
		// 글쓰기 로직
		$("#replyAddBtn").on("click", function () {
			// 각 input태그에 들어있던 글쓴이, 본문의 value값을 변수에 저장
			var replyer = $("#newReplyWriter").val();
			var reply = $("#newReply").val();
			console.log("클릭됨");
			
			$.ajax({
				type : 'post',
				url : '/replies/',
				headers : {
					"Content-Type" : "application/json",
					"X-HTTP-Method-Override" : "POST"
				},
				dataType : 'text',
				data : JSON.stringify({
					bno : bno,
					replyer : replyer,
					reply : reply
				}),
				success : function (result) {
					if (result == 'SUCCESS') {
						alert("등록 되었습니다");
						
						// 댓글 쓰고 나서 다시 새롭게 생신된 목록을 넣어주도록 전체 댓글 목록 다시 조회
						getAllList();
					}
				}
			});
		});
		
		// 글삭제 로직
		$("#replyDelBtn").on("click", function () {
			// 삭제에 필요한 댓글번호 모달 타이틀 부분에서 얻기
			var rno = $(".modal-title").html();
			var reply = $("#reply").val();
			
			$.ajax({
				type : 'delete',
				url : 'replies/' + rno,
				
				// 삭제로직은 rno만 전달함
				// 호출타입 delete, url정보 이외엔 처리할게 없음
				header : {
					"Content-Type" : "application/json",
					"X-HTTP-Method-Override" : "DELETE"
				},
				dataType : 'text',
				success : function (result) {
					console.log("result: " + result);
					if (result === 'SUCCESS') {		// 문자열은 === 로 비교
						alert("삭제 되었습니다");
						$("#modDiv").hide("slow");
						getAllList();
					}
				}
			});
			
		});
		
		// 글수정 로직(rno, reply 필요)
		$("#replyModBtn").on("click", function () {
			// rno(수정에 필요한 댓글번호 모달 타이틀 부분에서 얻기)
			var rno = $(".modal-title").html();
			// 수정에 필요한 본문내역을 #reply의 value 값으로 얻기
			var reply = $("#reply").val();
			
			$.ajax({
				type : 'put',		// patch 대신 put으로 대체가능
				url : '/replies/' + rno,
				headers : {
					"Content-Type" : "application/json",
					"X-HTTP-Method-Override" : "PUT"		// type이 put이면 patch를 put으로 변경
				},
				dataType : 'text',
				data : JSON.stringify({reply : reply}),
				success : function (result) {
					if (result === 'SUCCESS') {
						alert(rno + "번 댓글이 수정되었습니다");
						// 댓글 수정 후 모달창 닫고 새 댓글목록 갱신
						$("#modDiv").hide("slow");
						getAllList();
					}
				}
			});
		});
		
		
		
		
		// 이벤트 위임
		// 내가 현재 이벤트를 걸려는 집단(button)을 포함하면서 범위가 제일 좁은
		// #replies로 시작조건을 찾습니다
		// .on("click", "목적지 태그까지 요소들", function(){실행문})
		// 과 같이 위임시는 파라미터가 3개 들어갑니다
		$("#replies").on("click", ".replyLi button", function() {
			// this는 최하위태그인 button, button의 부모면 결국 .replyLi
			var replyLi = $(this).parent();
			
			// .attr("속성명")을 하면 해당 속성을 값을 얻습니다
			var rno = replyLi.attr("data-rno");
			var reply = replyLi.text();	// li태그 글씨만 얻기
			
			// 클릭한 버튼에 해당하는 <댓글번호 + 본문>이 얻어지나 디버깅
			console.log(rno + ":" + reply);
			
			// 모달 열리도록 추가
			$(".modal-title").html(rno);	// 모달 상단에 댓글번호 넣기
			$("#reply").val(reply);			// 모달 수정찰에 댓글본문 넣기
			$("#modDiv").show("slow");		// 창에 애니메이션 효과 넣기
			
			
		});
		
		
		
		
		///////////////////////////////////////////////////////////////////
		
		function getAllList() {
		$.getJSON("/replies/all/" + bno, function name(data) {		// 조회기능
			// data 변수가 바로 얻어온 json데이터의 집합
			console.log(data.length);
			
			// str 변수 내부에 문자 형태로 html 코드를 작성
			var str = "";
			
//			str = "<h1>test</h1><br>dnflgud rhfsjgdma";
//			str = "<li><a href= 'https://naver.com'>네이버</a></li>";
			
			$(data).each(
				function () {
				// $(data).each()는 향상된 for문처럼 내부데이터를 하나하나 반복합니다
				// 내부 this는 댓글 하나하나입니다
				
				str += "<li data-rno = '" + this.rno + "' class = 'replyLi'>"
					+ this.rno + ":" + this.reply
					+ "<button>수정/삭제</button></li>";
				
				
					console.log("댓글 번호:" + this.rno + "/ 댓글 내용: " + this.reply);
					console.log("---------------");
					
				});
			
			
			// #replies인 ul태그 내부에 str을 끼워넣음
			// ul 내부에 <li>123</li>를 추가하는 구문
			$("#replies").html(str);
		});
		
		}
		getAllList();
		
	</script>

</body>
</html>