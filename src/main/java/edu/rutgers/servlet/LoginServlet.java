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
import edu.rutgers.util.URLQuery;

/**
 * Login servlet for processing login info
 */
@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

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

        // Create loopback redirect
        String redirectURI = request.getRequestURI() + "?" + URLQuery.encode("redirectURI", request.getParameter("redirectURI"));

        // Attempt to log in
        User user = userDao.find(login, password);

        if (user != null) { // Successfully logged in, set user attribute
            session.setAttribute("user", user);

            // Redirect to where they were originally heading to.
            redirectURI = request.getParameter("redirectURI");
            redirectURI = !redirectURI.isEmpty() ? redirectURI : request.getContextPath();
        }

        response.sendRedirect(redirectURI);
    }
}