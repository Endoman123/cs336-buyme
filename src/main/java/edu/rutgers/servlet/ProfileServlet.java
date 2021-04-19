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
import edu.rutgers.model.Admin;
import edu.rutgers.model.User;

/**
 * User servlet for viewing and editing their profile
 */
@WebServlet( "/profile" )
public class ProfileServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        DAOFactory daoFactory = new DAOFactory();
        UserDAO userDao = daoFactory.getUserDAO();
        User user = (User) request.getSession(false).getAttribute("user");

        if (user == null || !userDao.find(user.getLogin()).equals(user))
            throw new IllegalStateException("Illegal session, invalid login information.");
        else 
            request.getRequestDispatcher("/WEB-INF/views/profile.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Attempt to update the password
        DAOFactory daoFactory = new DAOFactory();
        UserDAO userDao = daoFactory.getUserDAO();
        String redirectURL = request.getRequestURI();

        // Create a user
        String newLogin = (String) request.getParameter("loginNew"); 
        boolean changeLogin = newLogin != null && !newLogin.isEmpty();
        User user = (User) request.getSession(false).getAttribute("user");

        // Use the fields from the request to set up this user
        user.setEmail(request.getParameter("email"));
        user.setPassword(request.getParameter("password"));

        changeLogin = changeLogin && !user.getLogin().equals((String) request.getParameter("loginNew"));

        // Attempt to change the username, if applicable.
        if (changeLogin)
            userDao.updateLogin(user, request.getParameter("loginNew"));

        // Attempt to update the user info
        userDao.update(user);

        response.sendRedirect(redirectURL);
    }

    @Override
    protected void doDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        DAOFactory daoFactory = new DAOFactory();
        UserDAO userDao = daoFactory.getUserDAO();
        HttpSession session = request.getSession(false);

        User user = (User) session.getAttribute("user");

        if (user != null && !(user instanceof Admin)) {
            userDao.delete(user);
        }
        
        // Invalidate session
        session.invalidate();

        response.sendRedirect(request.getContextPath());
    }
}