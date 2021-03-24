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
<body>
<%
    try {
        // Get the database connection
        Connection con = DAOFactory.getConnection();

        // Create a SQL statement
        Statement stmt = con.createStatement();

        // Get parameters from the HTML form at the index.jsp
        String newLog = request.getParameter("log");
        String newPass = request.getParameter("pass");
        String email = request.getParameter("email");
    
        // Make an insert statement for the User table:
        String insert = "INSERT INTO user(login, password, email)"
                + "VALUES (?, ?, ?)";
        // Create a Prepared SQL statement allowing you to introduce the parameters of the query
        PreparedStatement ps = con.prepareStatement(insert);

        // Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
        ps.setString(1, newLog);
        ps.setString(2, newPass);
        ps.setString(3, email);
        // Run the query against the DB
        ps.executeUpdate();
        // Run the query against the DB
    
        insert = "INSERT INTO end_user(login)" + "VALUES (?)";
        // Create a Prepared SQL statement allowing you to introduce the parameters of the query
        ps = con.prepareStatement(insert);
        // Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself		
        ps.setString(1, newLog);
        ps.executeUpdate();
    
        // Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
        con.close();
        out.print("Account Created");
    } catch (Exception ex) {
        out.print(ex);
        out.print("insert failed");
    }
%>
</body>
</html>