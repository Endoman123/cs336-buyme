package edu.rutgers.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

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
        request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        DAOFactory daoFactory = new DAOFactory();
        UserDAO userDao = daoFactory.getUserDAO();
        HttpSession session = request.getSession();

        // Get input name, password, and redirectURI
        String login = request.getParameter("login");
        String password = request.getParameter("password");           
        String redirectURI = request.getRequestURI() + "?redirectURI=" + request.getParameter("redirectURI"); // Basically loop back every time the login is incorrect

        // Attempt to log in
        User user = userDao.find(login, password);

        if (user != null) { // Successfully logged in, set user attribute
            session.setAttribute("user", user);

            // Redirect to where they were originally heading to.
            redirectURI = !((String) request.getParameter("redirectURI")).isEmpty() ? 
                (String) request.getParameter("redirectURI") : 
                request.getContextPath();

            System.out.println("Testing");
        }

        response.sendRedirect(redirectURI);
    }
}