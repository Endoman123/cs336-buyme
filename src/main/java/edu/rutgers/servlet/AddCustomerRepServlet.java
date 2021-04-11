package edu.rutgers.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import edu.rutgers.dao.DAOException;
import edu.rutgers.dao.DAOFactory;
import edu.rutgers.dao.UserDAO;
import edu.rutgers.model.User;

/**
 * Admin servlet for creating new customer representatives
 */
@WebServlet("/admin/add_rep")
public class AddCustomerRepServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get customer support 
        request.getRequestDispatcher("/WEB-INF/views/admin/add_rep.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Attempt to add a new customer rep
        try {
            DAOFactory daoFactory = new DAOFactory();
            UserDAO userDao = daoFactory.getUserDAO();
            String redirectURL = "./admin/add_rep";

            // Create a user
            User user = new User();

            // Use the fields from the request to set up this user
            user.setLogin(request.getParameter("login"));
            user.setEmail(request.getParameter("email"));
            user.setPassword(request.getParameter("password"));
            user.setType(User.Type.END_USER);

            // Add the user to the database
            if (userDao.find(user.getLogin()) == null) {
                userDao.create(user);
                redirectURL = ".";
            }

            response.sendRedirect(redirectURL);
        } catch (Exception ex) {
           ex.printStackTrace(System.out);
        }
    }
}