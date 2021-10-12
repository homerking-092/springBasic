<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<h1>사용자 생성 로그인 폼</h1>
	<h2><c:out value="${error }"/></h2>
	<h2><c:out value="${logout }"/></h2>
	
	<form action="/login" method="post">
		ID :<input type="text" name="username" placeholder="아이디 입력해라"><br>
		PW :<input type="text" name="password" placeholder="비번 입력해라"><br>
		자동로그인: <input type="checkbox" name="remember-me"><br>
		<input type="submit" value="로그인">
		<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
	</form>
</body>
</html>