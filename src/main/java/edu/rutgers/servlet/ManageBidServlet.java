package edu.rutgers.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import edu.rutgers.dao.BidPostForDAO;
import edu.rutgers.dao.DAOFactory;
import edu.rutgers.model.BidPostFor;

/**
 * Customer support servlet for managing bids.
 * 
 * @author Jared Tulayan
 */
@WebServlet("/support/manage/bids")
public class ManageBidServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/support/manage/bids.jsp").forward(request, response);
    }

    @Override
    protected void doDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        DAOFactory daoFactory = new DAOFactory();
        BidPostForDAO bidDao = daoFactory.getBidPostForDAO();

        // Make sure that there is a bid to get 
        if (request.getParameter("bidNumber") == null)
            throw new IllegalArgumentException("Bid number not specified.");
        else { 
            BidPostFor bid = bidDao.find(Integer.parseInt(request.getParameter("bidNumber")));
            if (bid == null)
                throw new ServletException("Invalid bid number.");
            else
                bidDao.delete(bid);
        }

        response.sendRedirect(request.getContextPath() + "/support/manage/bids");
    }
}