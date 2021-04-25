package edu.rutgers.servlet;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.io.PrintWriter;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.annotation.WebServlet;
import edu.rutgers.dao.DAOException;
import edu.rutgers.dao.DAOFactory;
import edu.rutgers.dao.AuctionTransactionDAO;
import edu.rutgers.model.AuctionTransaction;

@WebServlet("/createauction")
public class CreateAuctionServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    /**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        request.getRequestDispatcher("/webapp/createAuction.jsp").forward(request, response);
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
    throws ServletException, IOException, DAOException {

        PrintWriter output = response.getWriter();
		response.setContentType("text/html");
                
        DAOFactory daoFactory = new DAOFactory();
        AuctionTransactionDAO auctionTransactionDAO = daoFactory.getAuctionTransactionDAO();

        AuctionTransaction auctionTransaction = new AuctionTransaction();
        auctionTransaction.setItemID(Integer.parseInt(request.getParameter("item_ID")));

        System.out.println(request.getParameter("close_date"));
        try{
            Date closeDate = new SimpleDateFormat("yyyy-MM-dd").parse(request.getParameter("close_date")); 
            auctionTransaction.setCloseDate(closeDate);
            
            Date closeTime = new SimpleDateFormat("HH:mm").parse(request.getParameter("close_time"));
            auctionTransaction.setCloseTime(closeTime);
        } catch(ParseException e) {};
        
        auctionTransaction.setInitPrice(Float.parseFloat(request.getParameter("init_price")));
        auctionTransaction.setMinimum(Float.parseFloat(request.getParameter("minimum")));
        auctionTransaction.setBidIncrement(Float.parseFloat(request.getParameter("bid_increment")));
        auctionTransaction.setCategoryNum(Integer.parseInt(request.getParameter("category_number")));
        auctionTransaction.setSubCategory(request.getParameter("subcategory"));
        auctionTransaction.setName(request.getParameter("name"));
        auctionTransaction.setBrand(request.getParameter("brand"));
        auctionTransaction.setColor(request.getParameter("color"));

        auctionTransactionDAO.create(auctionTransaction);

        output.println("Auction Created!");
        output.println("Redirecting in 3 seconds...");
		response.setHeader("Refresh", "3; URL=enduser.jsp");
    }
}
