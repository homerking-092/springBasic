<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<p>전체: ${vo }</p>
	<p>이름: ${vo.name }</p> <%-- vo name의 getter를 호출 --%>
	<p>나이: ${vo.age }</p>
	<p>레벨: ${vo.level }</p>
</body>
</html>