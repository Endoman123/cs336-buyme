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
 * Login servlet for processing login info
 */
@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Preprocess request: we actually don't need to do any business stuff, so just display JSP.
        request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Postprocess request: gather and validate submitted data and display the result in the same JSP.

        // Attempt logon
        try {
            // Get a User DAO for the query
            DAOFactory daoFactory = new DAOFactory();
            UserDAO userDao = daoFactory.getUserDAO();
            HttpSession session = request.getSession();

            // Get input name and password
            String login = request.getParameter("login");
            String password = request.getParameter("password");

            // Attempt to log in
            User user = userDao.find(login, password);
            String redirectURL = "index.jsp";

            if (user != null) { // Successfully logged in, let's get the user and type
                session.setAttribute("login", user.getLogin());
                session.setAttribute("type", user.getType().name());

                redirectURL = "success.jsp";
            }

            response.sendRedirect(redirectURL);
        } catch (DAOException ex){
            ex.printStackTrace();
        } 
    }
}