package edu.rutgers.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.Instant;
import java.time.ZoneId;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.annotation.WebServlet;
import edu.rutgers.dao.DAOException;
import edu.rutgers.dao.DAOFactory;
import edu.rutgers.dao.BidPostForDAO;
import edu.rutgers.model.BidPostFor;
import edu.rutgers.model.User;

/**
 * Manual bid posted and bid alerts received(on the selected auction) by the currently logged in end user 
 * 
 * @author Muskan Burman
 */
@WebServlet("/manualbid")
public class ManualBidServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        request.getRequestDispatcher("/manualbid.jsp").forward(request, response);
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
    throws ServletException, IOException, DAOException {

        PrintWriter output = response.getWriter();
        response.setContentType("text/html");
        
        HttpSession session = request.getSession();
		User user = (User) session.getAttribute("user");
        String login = user.getLogin();
        
        DAOFactory daoFactory = new DAOFactory();
        BidPostForDAO bidPostForDAO = daoFactory.getBidPostForDAO();

        BidPostFor bidPostFor = new BidPostFor();

        bidPostFor.setLogin(login);
        bidPostFor.setAuctionID(Integer.parseInt(request.getParameter("auction_ID")));
        bidPostFor.setAmount(Float.parseFloat(request.getParameter("bid_amount")));

        bidPostFor.setBidDate(java.util.Date.from(LocalDate.now().atStartOfDay(ZoneId.systemDefault()).toInstant()));
        Instant instant = LocalDateTime.now().atZone(ZoneId.systemDefault()).toInstant();
        Date time = Date.from(instant);
        bidPostFor.setBidTime(time);

        bidPostForDAO.create(bidPostFor);

        output.println("Bid Created!");
        output.println("Redirecting in 3 seconds...");
		response.setHeader("Refresh", "3; URL=enduser.jsp");
    }
}


    

