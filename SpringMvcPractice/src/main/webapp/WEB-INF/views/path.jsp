<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<p>${page} 페이지 조회중입니다</p>
	
	<!-- jstl을 활용해서 page가 100 미만이면 하단에 h2태그를 이용해서
		 "초반부입니다", 100이상 200미만이면 "중반부입니다",
		 200 이상이면 "후반부입니다" 라는 문장을 추가로 출력 -->
		 <c:choose>
		 	<c:when test="${page < 100 }">
		 		★초반부입니다★
		 	</c:when>
		 	<c:when test="${page >= 100 && page < 200}">
		 		★중반부입니다★
		 	</c:when>
		 	<c:when test="${page >= 200 }">
		 		★후반부입니다★
		 	</c:when>
		 </c:choose>
	
</body>
</html>