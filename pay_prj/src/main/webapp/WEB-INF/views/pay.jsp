<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<style type="text/css">
.itemCard{
	float: left;
	
}
</style>
<!-- jQuery -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<!-- iamport.payment.js -->
<script type="text/javascript"
	src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>유로파 여행 상품목록</h1>

	<div class="itemSection">
		<!-- 1 -->
		<div class="itemCard">
			<div class="itemTitle">
				<h2>런던 여행권</h2>
			</div>
			<div class="itemContent">
				<h3>쏘니보러 가자</h3>
			</div>
			<div class="itemPrice">
				<p data-price="100">100원</p>
			</div>
			<div class="itemButton">
				<button class="orderBtn">주문하기</button>
			</div>
		</div>
		<!-- 1 -->
		<div class="itemCard">
			<div class="itemTitle">
				<h2>멘체스터 여행권</h2>
			</div>
			<div class="itemContent">
				<h3>우리형보러 가자</h3>
			</div>
			<div class="itemPrice">
				<p data-price="200">200원</p>
			</div>
			<div class="itemButton">
				<button class="orderBtn">주문하기</button>
			</div>
		</div>
		<!-- 1 -->
		<div class="itemCard">
			<div class="itemTitle">
				<h2>파리 여행권</h2>
			</div>
			<div class="itemContent">
				<h3>음바페 보러가자</h3>
			</div>
			<div class="itemPrice">
				<p data-price="300">300원</p>
			</div>
			<div class="itemButton">
				<button class="orderBtn">주문하기</button>
			</div>
		</div>
	</div>
	<!-- 1 -->
	<div class="itemCard">
		<div class="itemTitle">
			<h2>도르트문트 여행권</h2>
		</div>
		<div class="itemContent">
			<h3>홀란드 보러가자</h3>
		</div>
		<div class="itemPrice">
			<p data-price="400">400원</p>
		</div>
		<div class="itemButton">
			<button class="orderBtn">주문하기</button>
		</div>
	</div>
	<!-- end div -->

	<script type="text/javascript">
		// 미리 받아와야할 정보를 변수를 전역변수처럼 쓰기위해 선언해두기
		var itemPrice = 0; // 가격
		var itemTitle = ""; // 물건이름
		var merchant_uid = ""; // 주문번호

		// 위임처리로 어떤 상품을 클릭했을때 그 상품에 대한 정보
		$(".itemSection").on(
				"click",
				".orderBtn",
				function() {
					itemPrice = $(this).parent().siblings(".itemPrice")
							.children().attr("data-price");
					itemTitle = $(this).parent().siblings(".itemTitle")
							.children().text();
					date = new Date(); // 현 시간
					merchant_uid = "order" + date.getTime(); // 현재시간을 유닉스시간으로 변경해 order에 붙임
					// 입력정보를 가져오고 나서 함수를 호출
					iamport();
				});

		// 결제모듈	/////////////////////////////////////////////////////////////////
		function iamport() {
			IMP.init('imp75367033'); // 가맹점번호(본인 아이디에 입력된 번호로)
			IMP.request_pay({
				pg : 'html5_inicis', // KG이니시스
				pat_method : 'card', // 결제수단
				merchant_uid : merchant_uid, // 상점에서 관리하는 주문 번호를 전달
				name : itemTitle, // 결제창 상품명
				amount : itemPrice, // 금액
				buyer_email : 'dudgns3603@naver.com', // 구매자 이메일
				buyer_tel : '010-1111-1234', // 구매자 번호
				buyer_addr : '서울특별시 광진구 중곡동', // 구매자 우편번호
			}, function(rsp) {
				console.log(rsp);
				if (rsp.success) { // 결제 성공시 ajax로 DB에 데이터를 전송해 입력
					$.ajax({
						type : 'post',
						url : '/order',
						headers : {
							"Content-Type" : "application/json",
							"X-HTTP-Method-Override" : "POST"
						},
						dateType : "text",
						data : JSON.stringify({
							itemname : itemTitle,
							amount : itemPrice,
							merchant_uid : merchant_uid
						}),
						success : function() {
							alert(itemTitle + " 결제완료@@!@!");
						}
					});
				} else { // 결제 실패시 처리할 내역
					var msg = '결제에 실패했습니다';
					msg += '에러내용 : ' + rsp.error_msg;
				}
				alert(msg); // 여기서는 alert창만 띄우고 끝나지만 리다이렉트 등의 방법이 있음					
			});
		}
		/* iamport(); // 실제로 실행 호출하기 */
	</script>
</body>
</html>