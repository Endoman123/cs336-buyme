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
 * Registration servlet for processing registration info
 */
@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Preprocess request: we actually don't need to do any business stuff, so just display JSP.
        request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Postprocess request: gather and validate submitted data and display the result in the same JSP.

        // Attempt registration
        try {
            DAOFactory daoFactory = new DAOFactory();
            UserDAO userDao = daoFactory.getUserDAO();
            String redirectURL = "./register";

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
                redirectURL = "./login";
            }

            response.sendRedirect(redirectURL);
        } catch (Exception ex) {
           ex.printStackTrace(System.out);
        }
    }
}