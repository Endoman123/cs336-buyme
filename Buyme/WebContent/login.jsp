<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="Buyme.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>BuyMe</title>
</head>
<body>
<% try{
	
	//Get the database connection
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();	
	
	//Create a SQL statement
	Statement stmt = con.createStatement();
	
	//Get input name and password
	String login = request.getParameter("log");
	String password = request.getParameter("pass");
	
	//Form query statment
	String query = "SELECT login FROM User WHERE login='" + login + "' AND password='" + password + "'";
	
	login = "";
	
	ResultSet result = stmt.executeQuery(query);
	 if (result.next()){
		 login = result.getString("login");
	 } else {
		 String redirectURL = "index.jsp";
		 response.sendRedirect(redirectURL);
	 }
	 
	 //check if user is a Customer Representative
	 query = "SELECT login From Customer_Rep Where login='" + login + "'";
	 result = stmt.executeQuery(query);
	 
	 if (result.next()){
		 String redirectURL = "customer_rep_login.jsp";
		 response.sendRedirect(redirectURL);
	 }
	 
	 //check if user is a Admin
	 query = "SELECT login From Admin Where login='" + login + "'";
	 result = stmt.executeQuery(query);
	 
	 if (result.next()){
		 String redirectURL = "admin_login.jsp";
		 response.sendRedirect(redirectURL);
	 }

	
	} 
	catch (Exception ex){
		out.print(ex);
	}
%>

Successfully logged in
</body>
</html>