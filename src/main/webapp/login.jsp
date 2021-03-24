<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="edu.rutgers.dao.*,edu.rutgers.model.*" %>
<%@ page import="java.io.*,java.util.*,java.sql.*" %>
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
        // Get a User DAO for the query
        DAOFactory daoFactory = new DAOFactory();
        UserDAO userDao = daoFactory.getUserDAO();

        // Get input name and password
        String login = request.getParameter("log");
        String password = request.getParameter("pass");

        // Attempt to log in
        User user = userDao.find(login, password);

        if (user == null) {
            String redirectURL = "index.jsp";
            response.sendRedirect(redirectURL);
        } else {
            out.print("Successfully logged in as " + user.getLogin());
        }
    
//        // check if user is a Customer Representative
//        query = "SELECT login FROM customer_rep WHERE login='" + login + "'";
//        result = stmt.executeQuery(query//
//        if (result.next())
//            response.sendRedirect("customer_rep_login.jsp"//
//        //check if user is a Admin
//        query = "SELECT login FROM admin WHERE login='" + login + "'";
//        result = stmt.executeQuery(query//
//        if (result.next())
//            response.sendRedirect("admin_login.jsp");

    } catch (DAOException ex){
        ex.printStackTrace(new java.io.PrintWriter(out));
    } 
%>
</body>
</html>