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
            response.sendRedirect("index.jsp");
        } else { // Successfully logged in, let's get the user and type
            session.setAttribute("login", user.getLogin());

            switch(user.getType()) {
                case ADMIN:
                    response.sendRedirect("admin_login.jsp");
                break;
                case CUSTOMER_REP:
                    response.sendRedirect("customer_rep_login.jsp");
                break;
                default:
                    out.print("Successfully logged in " + session.getAttribute("login"));
                break;
            }
        }
    } catch (DAOException ex){
        ex.printStackTrace(new java.io.PrintWriter(out));
    } 
%>
</body>
</html>