<%@ taglib prefix="t" tagdir="/WEB-INF/tags"%>

<!-- @author Muskan Burman -->

<%@ page
import="java.io.IOException,
 java.sql.Connection,
 java.sql.ResultSet,
 java.sql.SQLException,
 java.sql.Statement,
 javax.servlet.http.HttpSession,
 edu.rutgers.dao.DAOException,
 edu.rutgers.dao.DAOFactory,
 edu.rutgers.model.BidPostFor,
 java.lang.String, 
 java.util.ArrayList,
 java.util.List, 
 java.lang.System, 
 edu.rutgers.servlet.ManualBidServlet"%>

<%!
List<String> getBiddersList(HttpSession session) {
	String auctionID = request.getParameter("auction_ID");
	String bidAmount = request.getParameter("bid_amount");

	try {
		List<String> Alerts = new ArrayList<String>();
		DAOFactory dao = new DAOFactory();
		Connection con = dao.getConnection();
		Statement st = con.createStatement();

		String biddersList = "SELECT login, amount FROM bid_posts_for WHERE auction_ID = " + auctionID + " AND amount > " + bidAmount;

		ResultSet rs = st.executeQuery(biddersList);

		while (rs.next()) {
			int auctionId = rs.getInt("auction_ID");
			float amount = rs.getFloat("amount");

			String alert = "Auction Id:" + auctionId + ", Bid Amount:" + amount;
			Alerts.add(alert);
		}

		rs.close();
		st.close();
		con.close();

		return Alerts;

		} catch (SQLException e) {
			throw new DAOException(e);
		}
	}
%>

<t:base context="${pageContext.request.contextPath}" title="Manual Bidding">

    <h2>Bid Details</h2>
	<form action="manualbid" method="post">
		<label>Enter Auction ID:</label> <input type="number" name="auction_ID" required min=1> <br> 
        <br/><label>Enter Bid Amount:</label> <input type="number" name="bid_amount" required> <br>
        <br/><input type="submit" value="Submit">
	<br>
	<p></p>
</t:base>

<div
	style="border: 1px solid black; width: 400px; height: 200px; overflow: scroll;">
	<h2>Bid Alerts</h2>

	<p>Higher bids placed on this item by:</p>
	<p>
		<%
		List<String> bidders = getBiddersList(session);
		for (String bidder : bidders) {
			out.println(bidder);
		%>
		<br>
		<%
		}
		%>
	</p>
</div>
