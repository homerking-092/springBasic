<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<!-- jQuery -->
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<!-- iamport.payment.js -->
<script type="text/javascript"	src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<div>
	<!-- 1 -->
	<div class="item">
		<div>
		
		</div>
	</div>
	<!-- end 1 -->
</div>








<script type="text/javascript">
	function iamport() {
		IMP.init('imp75367033');
		IMP.request_pay({
			pg : 'html5_inicis',
			pay_method: 'card',
			mechant_uid : ""
		})
	}
</script>

</body>
</html>