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
    <header>
        <h1 style="text-align:center">BuyMe</h1>
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
    </body>
</html>