<%@ taglib prefix="c" 
           uri="http://java.sun.com/jsp/jstl/core" %>
           <%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<div align="center">
<form:form commandName="questionBean" action="frmsubmit">
<c:forEach items="${questionBean.questions}" var="q" varStatus="it">
<c:if test="${q.question.questionType == 'MCQ'}">
<br/>
<div>${q.question.questionDesc}</div>
<br/>
<form:radiobutton  path="questions[${it.index}].answer.ansDesc" value="${q.question.option_1}"/>
<form:radiobutton path="questions[${it.index}].answer.ansDesc" value="${q.question.option_2}"/>
</c:if>
<c:if test="${q.question.questionType == 'TXT'}">
<br/>
<div>${q.question.questionDesc}</div>
<br/> 
<form:textarea path="questions[${it.index}].answer.ansDesc" row="22" col="50"/>
</c:if>

</c:forEach>
<input type="submit">click it</input>  
</form:form>
</div>
</body>
</html>