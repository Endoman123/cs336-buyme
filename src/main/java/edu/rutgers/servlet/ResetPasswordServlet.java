package edu.rutgers.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import edu.rutgers.dao.DAOFactory;
import edu.rutgers.dao.UserDAO;
import edu.rutgers.model.User;

/**
 * Customer support servlet for resetting passwords
 */
@WebServlet("/support/reset-password")
public class ResetPasswordServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        DAOFactory daoFactory = new DAOFactory();
        UserDAO userDao = daoFactory.getUserDAO();
        String login = (String) request.getAttribute("login");

        // Get password reset view 
        if (login != null && userDao.find(login) != null) {
            request.getRequestDispatcher("/WEB-INF/views/support/reset-password.jsp").forward(request, response);
        } else
            throw new ServletException("Either login was invalid or no login parameter was found.");
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Attempt to update the password
        DAOFactory daoFactory = new DAOFactory();
        UserDAO userDao = daoFactory.getUserDAO();
        String redirectURL = request.getContextPath() + "/support/reset-password";

        // Create a user
        User user = new User();

        // Use the fields from the request to set up this user
        user.setLogin(request.getParameter("login"));
        user.setEmail(request.getParameter("email"));
        user.setPassword(request.getParameter("password"));

        // Add the user to the database as a customer representative
        if (userDao.find(user.getLogin()) == null) {
            userDao.create(user);
            userDao.addCustomerRep(user);
            redirectURL = request.getContextPath() + "/login";
        }

        response.sendRedirect(redirectURL);
    }
}