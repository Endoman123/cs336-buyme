package edu.rutgers.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.time.LocalDate;
import java.time.LocalTime;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import edu.rutgers.dao.DAOException;
import edu.rutgers.dao.DAOFactory;
import edu.rutgers.model.User;

/**
 * This class handles autobid functionality
 * 
 * @author Dorian Hobot
 */
public class Autobid extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public Autobid() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("/webapp/autobid.jsp").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response) creates the Autobid entry based on input data and runs
	 *      Autobid.
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		PrintWriter output = response.getWriter();
		response.setContentType("text/html");

		// get all submitted input data
		int auctionId;
		double upperLimit;
		double bidIncrement;

		auctionId = Integer.parseInt(request.getParameter("auction_id"));
		upperLimit = Double.parseDouble(request.getParameter("upper_limit"));
		bidIncrement = Double.parseDouble(request.getParameter("bid_increment"));

		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("user");
		String login = user.getLogin();

		try {

			DAOFactory dao = new DAOFactory();
			Connection con = dao.getConnection();
			Statement st = con.createStatement();

			String checkID = "select max(auction_id) as auction_id from auction_transactions;";
			Statement st2 = con.createStatement();
			ResultSet id = st2.executeQuery(checkID);
			id.next();
			int maxID = id.getInt("auction_id");
			id.close();
			st2.close();

			// check if the entered auctionID is valid
			if (auctionId <= maxID) {
				// check if the auction is still open
				if (checkAuctionClosing(con, auctionId)) {

					Statement st3 = con.createStatement();
					String checkAuction = "select init_price, bid_increment from auction_transactions where auction_id = "
							+ auctionId;
					ResultSet auction = st3.executeQuery(checkAuction);
					auction.next();
					double initialPrice = auction.getDouble("init_price");
					double auctionIncrement = auction.getDouble("bid_increment");
					auction.close();
					st3.close();

					// check if the auction bid increment is less than or equal to the input bid
					// increment
					if (bidIncrement >= auctionIncrement) {
						// check if the upper limit is less than initial price of auction plus the bid
						// increment
						if (upperLimit >= initialPrice + bidIncrement) {

							String previousAutobid = "select * from autobid where login = \"" + login
									+ "\" and auction_ID =" + auctionId;
							ResultSet rs = st.executeQuery(previousAutobid);
							// used if the current user is updating a previous autobid entry for the input
							// AuctionID
							if (rs.next()) {
								String entry = "update autobid set bid_increment = " + bidIncrement + ", upper_limit ="
										+ upperLimit + "where login=\"" + login + "\" and auction_ID =" + auctionId;
								st.executeUpdate(entry);
								output.println("Autobid Updated");
								// Used if the current user has not put in an autobid for the input AuctionID
							} else {
								String entry = "insert into autobid values (\"" + login + "\"," + auctionId + ","
										+ bidIncrement + "," + upperLimit + ")";
								st.executeUpdate(entry);
								output.println("Autobid Created");

							}
							output.println(" running Autobid");
							rs.close();
							// runs autobid after the autobid entry is made
							runAutobid(con, auctionId, login, bidIncrement);

						} else {
							output.println(
									"Autobid rejected: Upper-Limit smaller than Initial Auction Price + Bid Increment");
						}
					} else {
						output.println("Autobid rejected: Input Bid-Increment smaller than seller Bid-Increment");
					}
				} else {
					output.println("Autobid rejected: Auction Already Closed");
				}
			} else {
				output.println("Autobid rejected: Auction doesn't exist");

			}
			output.println("<br>");
			output.println("Redirecting in 5 seconds...");
			response.setHeader("Refresh", "5; URL=autobid.jsp");
			con.close();

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

	// enters a bid based on a specific autobid tuple
	double makeBid(Connection con, String login, int auctionID, double bidIncrement, double currentMaxBid) {

		try {

			// get max bid Id or set to 1 if no bids exist
			Statement st = con.createStatement();
			ResultSet bid = st.executeQuery("select max(bid_number) as max_bid_id from bid_posts_for");
			int bidId;

			if (bid.next()) {

				bidId = bid.getInt("max_bid_id");
				bidId++;

			} else {
				bidId = 1;
			}

			String currentTime = LocalTime.now().toString();
			String currentDate = LocalDate.now().toString();

			double amount = currentMaxBid + bidIncrement;

			String bidEntry = "insert into bid_posts_for values (" + bidId + ", \"" + login + "\", " + auctionID + ", "
					+ amount + ", \"" + currentDate + "\", \"" + currentTime + "\")";

			// System.out.println(bidEntry);
			st.executeUpdate(bidEntry);

			bid.close();
			st.close();

			return amount;

		} catch (SQLException e) {
			throw new DAOException(e);
		}
	}

	// Makes bids based on the entries in Autobid table from all users until they're
	// resolved
	@SuppressWarnings("resource")
	void runAutobid(Connection con, int auctionId, String login, double loginIncrement) {

		// return if auction is closed
		if (!checkAuctionClosing(con, auctionId)) {
			return;
		}
		String bidExists = "select auction_ID as amount from bid_posts_for where auction_ID = " + auctionId;
		String maxBid = "select max(amount) as amount from bid_bosts_for where auction_ID = " + auctionId;
		String maxLogin = "select distinct login from bid_posts_for where auction_ID=" + auctionId
				+ " and amount = (select max(amount) as amount from bid_posts_for where auction_ID=" + auctionId + ")";
		String getAutobids = "select * from autobid where Auction_ID=" + auctionId;
		Double currentMaxBid;
		String currentMaxLogin;

		try {

			Statement st = con.createStatement();
			ResultSet rs = st.executeQuery(bidExists);

			// runs if there is a previous bid for the auction. Checks all entries in
			// Autobid and runs till resolved. Else puts in initial bid.
			if (rs.next()) {

				rs = st.executeQuery(maxBid);
				rs.next();
				currentMaxBid = rs.getDouble("amount");

				rs = st.executeQuery(maxLogin);
				rs.next();
				currentMaxLogin = rs.getString("login");

				rs = st.executeQuery(getAutobids);
				// loops through list of autobids
				while (rs.next()) {

					String username = rs.getString("login");
					double upperLimit = rs.getFloat("upper_limit");
					double bidIncrement = rs.getFloat("bid_increment");
					// check if current highest bid is from the current autobid entry, skip if equal
					if (currentMaxLogin.compareTo(username) != 0) {
						// check if the current autobid entry upper limit is below the current highest
						// bid
						if (currentMaxBid <= upperLimit) {

							if (currentMaxBid + bidIncrement <= upperLimit) {
								// create new bid based on the current autobid entry
								currentMaxBid = makeBid(con, username, auctionId, bidIncrement, currentMaxBid);
								currentMaxLogin = username;

								// System.out.println("new maxbid =" + currentMaxBid);
								// System.out.println("new max login =" + currentMaxLogin);
								rs = st.executeQuery(getAutobids);
							} else {
								// create new bid based on the current autobid entry
								currentMaxBid = makeBid(con, username, auctionId, 0, upperLimit);
								currentMaxLogin = username;

								//System.out.println("new maxbid =" + currentMaxBid);
								//System.out.println("new max login =" + currentMaxLogin);
								rs = st.executeQuery(getAutobids);

							}

						} else {
							 //System.out.println("limit reached");
							continue;
						}
					} else {
						//System.out.println("same login");
						continue;
					}

				}
				// Runs if there was no previous bid. Creates the initial bid.
			} else {

				//System.out.println("no previous bids");
				String checkAuction = "select init_price from auction_transactions where auction_id = " + auctionId;
				rs = st.executeQuery(checkAuction);
				rs.next();

				double initialPrice = rs.getDouble("init_price");

				makeBid(con, login, auctionId, loginIncrement, initialPrice);
				rs.close();

			}

		} catch (SQLException e) {
			throw new DAOException(e);
		}

	}

}
