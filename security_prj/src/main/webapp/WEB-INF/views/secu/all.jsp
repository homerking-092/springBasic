<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<h1>all 주소</h1>
	
	<sec:authorize access="isAnonymous()">
	<!-- 로그인 안한(익명) 사용자인 경우 -->
	<a href="/customLogin"><button> 로그인</button></a>
	</sec:authorize>
	
	<sec:authorize access="isAuthenticated()">
	<!-- 로그인 한(인증된) 사용자인 경우 -->
	<!-- 로그인한 유저는 xx님 환영합니다 라는 인사말 추가 -->
	<p> <sec:authentication property="principal.member.userName"/>님 환영합니다 </p>
	
	<!-- c태그 if를 이용해 운영자25만 "너무 반갑습니다"
	아래와 같이 var 속성을 지정하면 property의 정보를 var 변수명에 저장합니다 -->
	<sec:authentication property="principal" var="secuInfo"/>
	<!--  ${secuInfo.member.userName }<br>-->
	<c:if test="${secuInfo.member.userName eq '운영자25'}">
		<p>너무 반갑습니다</p>
	</c:if>

	<a href="/customLogout"><button> 로그아웃 페이지 이동</button></a>
	</sec:authorize>
</body>
</html>