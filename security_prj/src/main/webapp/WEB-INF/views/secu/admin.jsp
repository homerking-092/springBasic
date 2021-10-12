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

	<h1>admin 주소</h1>
	<h2>다양한 페이지 정보</h2>
	
	<!-- principal 내부에는 인증과 관련된 정보가 담겨있습니다 -->
	<p>principal : <sec:authentication property="principal"/> </p> 
	
	<!-- 스프링 시큐리티의 User를 상속해 만든 CustomUser에서
	내부 멤버변수로 MemberVO member를 선언해놨었고,
	getter를 만들어놨기 떄문에 principal.member를 표현식에 적으면
	.getMember() 게터를 호출하는 효과가 있습니다 -->
	<p>MemberVO : <sec:authentication property="principal.member"/> </p>
	<p>사용자의 이름 : <sec:authentication property="principal.member.userName"/> </p>
	<p>사용자의 아이디 : <sec:authentication property="principal.member.userid"/> </p>
	<p>사용자 권한목록 : <sec:authentication property="principal.member.authList"/> </p>
	<hr>
	<a href="/customLogout" ><button>로그아웃 페이지 이동</button></a>
</body>
</html>