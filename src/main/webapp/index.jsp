<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="edu.rutgers.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html>
<<<<<<< HEAD
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
			Password <input type="password" name="pass">
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
=======
<html>
    <head>
        <meta charset="ISO-8859-1">
        <title>BuyMe</title>
    </head>
    <header>
        <h1 style="text-align:center" >BuyMe</h1>
    </header>
    <body>
        <div>
            <h2>Login</h2>
            <form method="post" action="login.jsp">
                <label for="log">Login</label>
                <input type="text" name="log" >
                <label for="pass">Password</label>
                <input type="password" name="pass">
                <input type="submit" value="Submit">
            </form>
        </div>
        <div>
            <h2>Register</h2>
            <form method="post" action="createlogin.jsp">
                <label for="log">Login</label>
                <input type="text" name="log" >
                <label for="pass">Password</label>
                <input type="password" name="pass">
                <label for="email">E-Mail</label>
                <input type="text" name="email">
                <input type="submit" value="Submit">
            </form>
        </div>
>>>>>>> a80f0a1c45cd9a83b29f02bd8dddb1ab847d7310
    </body>
</html>