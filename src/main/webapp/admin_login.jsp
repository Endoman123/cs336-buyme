<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="edu.rutgers.main.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>BuyMe</title>
</head>
<body>
Admin Page
<br>
Successfully logged in as <%=session.getAttribute("login")%>
<form method="post" action="logout.jsp">
<input type="submit" value="logout">
</form>
</body>
</html>