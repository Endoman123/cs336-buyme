<%@ taglib prefix="t" tagdir="/WEB-INF/tags"%>

<%@ page
	import="java.io.IOException,
 java.sql.Connection,
 java.sql.ResultSet,
 java.sql.SQLException,
 java.sql.Statement,
 java.time.LocalDate,
 java.time.LocalTime,
 javax.servlet.http.HttpSession,
 edu.rutgers.dao.DAOException,
 edu.rutgers.dao.DAOFactory,
 edu.rutgers.model.User,
 java.lang.String, 
 java.util.ArrayList,
 java.util.List, 
 java.lang.System"%>
 <body>
 <% 
 		//First box in checklist just a list of all items and their current bids
 		List<String> list = new ArrayList<String>();
 
try {
			DAOFactory dao = new DAOFactory();
			Connection con = dao.getConnection();
			Statement st = con.createStatement();
			//query to select items and their current bids (currently is just selecting final price tho/add auctionID also)
			String listOfItems = "select i.item_id Item, atran.final_price Current_Bid from item i, auction_transactions atran where i.item_id = atran.item_id";
			ResultSet rs = st.executeQuery(listOfItems);
			//build a table to display results
			out.print("<table>");
			out.print("<tr>");
			out.print("<td>");
			out.print("Item");
			out.print("</td>");
			out.print("<td>");
			out.print("Current Bid");
			out.print("</td>");
			while (rs.next()) {
				out.print("<tr>");
				out.print("<td>");
				out.print(rs.getString("item"));
				out.print("</td>");
				out.print("<td>");
				out.print(rs.getString("Current_Bid"));
				out.print("</td>");
				out.print("<td>");
			}
			out.print("</table>");
			rs.close();
			con.close();
		} catch (SQLException e) {
			throw new DAOException(e);
			}
		%>
		Input AuctionID you'd like to see all bid history for
	<br>
		<form method="post" action="historyOfBidSpecificAuction.jsp">
		<table>
		<tr>    
		<td>AuctionID</td><td><input type="text" name="auction_id"></td>
		</tr>
		</table>
		<input type="submit" value="Search">
		</form>
	<br>
			</body>