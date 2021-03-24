<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="edu.rutgers.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html>
	<html>
		<head>
			<meta charset="ISO-8859-1">
			<title>BuyMe</title>
		</head>
	<h1 style="text-align:center" > 
		BuyMe
	</h1>
	
	<body>
	Login
	<br>
		<form method="post" action="login.jsp">
			Login<input type="text" name="log" >
			<br>
			Password <input type="text" name="pass">
			<br>
			 <input type="submit" value="Submit">
		</form>
		<br>
	Register
		<br>
		<form method="post" action="createlogin.jsp">
            Login<input type="text" name="log" >
            <br>
            Password <input type="text" name="pass">
            <br>
            Email <input type="text" name="email">
             <input type="submit" value="Create Login">
        </form>
    </body>
</html>