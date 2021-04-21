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
			User user = (User) session.getAttribute("user");
			String login = user.getLogin();
			Statement st = con.createStatement();
			//query to check what logged in user has bid on (maybe add a union for auctions they have sold?)
			String checkHistory = "select distinct bpf.auction_ID AuctionID, i.name Item Name from bid_posts_for bpf, item i, auction_transactions atran where bpf.login = \"" + login + "\"" + " and atran.auction_ID = bpf.auction_ID and i.item_ID = atran.item_ID";
			ResultSet rs = st.executeQuery(checkHistory);
			//build a table to display results
			out.print("<table>");
			out.print("<tr>");
			out.print("<td>");
			out.print("AuctionID");
			out.print("</td>");
			out.print("<td>");
			out.print("Item Name");
			out.print("</td>");
			while (rs.next()) {
				out.print("<tr>");
				out.print("<td>");
				out.print(rs.getString("AuctionID"));
				out.print("</td>");
				out.print("<td>");
				out.print(rs.getString("Item Name"));
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