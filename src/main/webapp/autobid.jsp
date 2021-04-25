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
 java.lang.System, 
 edu.rutgers.servlet.Autobid"%>

<!-- 
Written by Dorian Hobot 
-->

<%!// Makes a List of auctions where the current logged in user has been outbid
	List<String> getAlerts(HttpSession session) {

		try {

			List<String> Alerts = new ArrayList<String>();
			DAOFactory dao = new DAOFactory();
			Connection con = dao.getConnection();
			Statement st = con.createStatement();

			User user = (User) session.getAttribute("user");
			String login = user.getLogin();

			String auctionList = "select distinct auction_ID, upper_limit from autobid where login=\"" + login + "\"";

			ResultSet rs = st.executeQuery(auctionList);

			while (rs.next()) {
				int auctionId = rs.getInt("auction_ID");
				double upperLimit = rs.getDouble("upper_limit");

				System.out.println(auctionId);
				System.out.println(upperLimit);

				String highBid = "select login, amount from bid_posts_for where auction_ID=" + auctionId
						+ " and amount = (select max(amount) as amount from bid_posts_for where auction_ID=" + auctionId
						+ ")";

				Statement st2 = con.createStatement();
				ResultSet highBidder = st2.executeQuery(highBid);

				while (highBidder.next()) {

					String highBidderLogin = highBidder.getString("login");
					double amount = highBidder.getDouble("amount");

					System.out.println(highBidderLogin);
					System.out.println(amount);

					if (amount > upperLimit) {
						if (login.compareTo(highBidderLogin) != 0) {

							String alert = "Auction Id:" + auctionId + " Highest Bid:" + amount;

							Alerts.add(alert);
						}
					}
				}
			}

			rs.close();
			st.close();
			con.close();

			return Alerts;

		} catch (SQLException e) {
			throw new DAOException(e);
		}

	}

	// return true if auction has not ended yet else return false
	boolean checkAuctionClosing(Connection con, int auctionId) {
		String auctionEndTime = "select close_time from auction_transactions where auction_ID=" + auctionId;
		String auctionEndDate = "select close_date from auction_transactions where auction_ID=" + auctionId;

		try {
			Statement st = con.createStatement();
			ResultSet rs = st.executeQuery(auctionEndTime);
			rs.next();

			LocalTime endTime = LocalTime.parse(rs.getString("close_time"));

			rs = st.executeQuery(auctionEndDate);
			rs.next();

			LocalDate endDate = LocalDate.parse(rs.getString("close_date"));
			LocalTime currentTime = LocalTime.now();
			LocalDate currentDate = LocalDate.now();

			rs.close();
			st.close();

			if (currentDate.compareTo(endDate) < 0) {
				return true;
			} else if (currentDate.compareTo(endDate) == 0) {

				if (currentTime.compareTo(endTime) < 0) {
					return true;

				}
			}
			return false;

		} catch (SQLException e) {
			throw new DAOException(e);
		}

	}

	//updates the winner of any auction that the current logged in user has bid for
	void updateWinner(HttpSession session) {

		try {

			DAOFactory dao = new DAOFactory();
			Connection con = dao.getConnection();
			Statement st = con.createStatement();

			User user = (User) session.getAttribute("user");
			String login = user.getLogin();

			String auctionList = "select distinct auction_ID from bid_posts_for where login=\"" + login + "\"";

			ResultSet rs = st.executeQuery(auctionList);

			while (rs.next()) {
				int auctionId = rs.getInt("auction_ID");

				System.out.println(auctionId);

				if (!checkAuctionClosing(con, auctionId)) {

					String minimum = "select minimum from auction_transactions where auction_ID =" + auctionId;
					Statement st2 = con.createStatement();
					ResultSet min = st2.executeQuery(minimum);
					min.next();
					double reserve = min.getDouble("minimum");
					min.close();
					st2.close();

					System.out.println("reserve " + reserve);

					String maximumBid = "select login, amount from bid_posts_for where auction_ID=" + auctionId
							+ " and amount = (select max(amount) as amount from bid_posts_for where auction_ID="
							+ auctionId + ")";

					Statement st3 = con.createStatement();
					ResultSet max = st3.executeQuery(maximumBid);
					max.next();
					double maxBid = max.getDouble("amount");
					String winner = max.getString("login");
					max.close();
					st3.close();

					System.out.println("Max bid " + maxBid);

					if (maxBid >= reserve) {

						System.out.println("Winner " + winner);
						String updateWinner = "update auction_transactions set winner =\"" + winner
								+ "\", final_price =\"" + maxBid + "\" where auction_ID=" + auctionId;
						Statement st4 = con.createStatement();
						st4.executeUpdate(updateWinner);

					}

				}
			}

			rs.close();
			con.close();

		} catch (SQLException e) {
			throw new DAOException(e);
		}
	}

	//gets the list of auctions the current logged in user has won
	List<String> checkWinner(HttpSession session) {

		try {

			List<String> Wins = new ArrayList<String>();
			DAOFactory dao = new DAOFactory();
			Connection con = dao.getConnection();
			Statement st = con.createStatement();

			User user = (User) session.getAttribute("user");
			String login = user.getLogin();

			String winList = "select * from auction_transactions where winner =\"" + login + "\"";

			ResultSet rs = st.executeQuery(winList);

			while (rs.next()) {

				int auctionId = rs.getInt("auction_ID");
				int itemId = rs.getInt("item_ID");
				String itemName = rs.getString("name");

				String entry = "Auction ID: " + auctionId + ", Item ID: " + itemId + ", Item Name: " + itemName;
				Wins.add(entry);

			}

			rs.close();
			con.close();

			return Wins;

		} catch (SQLException e) {
			throw new DAOException(e);
		}

	}%>

<t:base context="${pageContext.request.contextPath}" title="Autobid">

	<form action="autobid" method="post">
		<label>Enter Auction ID</label> <input type="number" name="auction_id"
			required min=1> <br> <label>Enter Upper Limit</label> <input
			type="number" name="upper_limit" required min=00.01 step="0.01">
		<br> <label>Enter Bid Increment</label> <input type="number"
			name="bid_increment" required min=00.01 step="0.01"> <br>
		<input type="submit" value="Submit">
	</form>
	<br>
	<P></P>

</t:base>

<%
updateWinner(session);
%>

<div
	style="border: 1px solid black; width: 400px; height: 150px; overflow: scroll;">
	<h2>Bid Alerts</h2>

	<p>Upper limit out-bid for 
	<p>
		<%
		List<String> alerts = getAlerts(session);
		for (String alert : alerts) {
			out.println(alert);
		%>
		<br>
		<%
		}
		%>
	</p>
</div>

<div
	style="border: 1px solid black; width: 400px; height: 150px; overflow: scroll;">
	<h2>You've Won Auction</h2>
	<p>

		<%
		List<String> wins = checkWinner(session);
		for (String win : wins) {
			out.println(win);
		%>
		<br>
		<%
		}
		%>
	</p>
</div>





