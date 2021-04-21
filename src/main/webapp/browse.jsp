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
	<form method="post" action="seeWhatYouBidFor.jsp">
	 <input type="submit" value="Search"> Click here to see all auctions you participated in
	</form>
		Sort Items
	<br>
		<form method="get" action="sortBy.jsp">
			<select name="sortBy" size=1>
				<option value="asc">Ascending Price</option>
				<option value="desc">Descending Price</option>
				<option value="pants">All pants</option>
				<option value="shoes">All shoes</option>
				<option value="shirt">All shirts</option>
			</select>&nbsp;<br> <input type="submit" value="submit">
		</form>
	<br>
	
	<% 

 		//First box in checklist just a list of all items and their current bids
 		List<String> list = new ArrayList<String>();
 
try {
			DAOFactory dao = new DAOFactory();
			Connection con = dao.getConnection();
			Statement st = con.createStatement();
			//query to select items and their current bids (currently is just selecting final price tho/add auctionID also)
			String listOfItems = "select i.item_id Item, i.name Name, bpf.amount CurrentBid, atran.auction_id AuctionID from item i, auction_transactions atran, bid_posts_for bpf where i.item_id = atran.item_id	and atran.auction_ID = bpf.auction_ID group by atran.auction_ID";
			ResultSet rs = st.executeQuery(listOfItems);
			//build a table to display results
			out.print("<table>");
			out.print("<tr>");
			out.print("<td>");
			out.print("Item");
			out.print("</td>");
			out.print("<td>");
			out.print("Name");
			out.print("</td>");
			out.print("<td>");
			out.print("CurrentBid");
			out.print("</td>");
			out.print("<td>");
			out.print("AuctionID");
			out.print("</td>");
			while (rs.next()) {
				out.print("<tr>");
				out.print("<td>");
				out.print(rs.getString("item"));
				out.print("</td>");
				out.print("<td>");
				out.print(rs.getString("Name"));
				out.print("</td>");
				out.print("<td>");
				out.print(rs.getString("CurrentBid"));
				out.print("</td>");
				out.print("<td>");
				out.print(rs.getString("AuctionID"));
				out.print("</td>");
			}
			out.print("</table>");
			rs.close();
			con.close();
		} catch (SQLException e) {
			throw new DAOException(e);
			}
		%>
			</body>