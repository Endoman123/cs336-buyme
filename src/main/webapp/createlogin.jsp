<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="edu.rutgers.dao.*,edu.rutgers.model.User"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>BuyMe</title>
</head>
<body>
<%
    try {
        DAOFactory daoFactory = new DAOFactory();
        UserDAO userDao = daoFactory.getUserDAO();

        // Create a user
        User user = new User();

        // Use the fields from the request to set up this user
        user.setLogin(request.getParameter("log"));
        user.setEmail(request.getParameter("email"));
        user.setPassword(request.getParameter("pass"));
        user.setType(User.Type.END_USER);

        // Add the user to the database
        userDao.create(user);
        out.print("Successfully created the account. Welcome, " + user.getLogin() + "!");
    } catch (Exception ex) {
       ex.printStackTrace(new java.io.PrintWriter(out));
    }
%>
<form method="post" action="index.jsp">
<input type="submit" value="login">
</form>
</body>
</html>