package edu.rutgers.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import edu.rutgers.dao.DAOFactory;
import edu.rutgers.dao.UserDAO;
import edu.rutgers.model.EndUser;
import edu.rutgers.model.User;
import edu.rutgers.util.URLQuery;

/**
 * Customer support servlet for managing a user
 */
@WebServlet("/support/manage-user")
public class ManageUserServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        DAOFactory daoFactory = new DAOFactory();
        UserDAO userDao = daoFactory.getUserDAO();
        String login = (String) request.getParameter("login");

        // Get password reset view 
        if (login == null)
            throw new IllegalArgumentException("Login parameter not specified");
        else  { 
            User editUser = userDao.findEndUser(login);
            if (editUser == null)
                throw new ServletException("No end-user found with the login " + login);
            else {
                request.setAttribute("editUser", editUser);
                request.getRequestDispatcher("/WEB-INF/views/support/manage-user.jsp").forward(request, response);
            }
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Attempt to update the password
        DAOFactory daoFactory = new DAOFactory();
        UserDAO userDao = daoFactory.getUserDAO();
        String redirectURL = request.getRequestURI() + "?" + URLQuery.encode("login", request.getParameter("loginOld"));

        // Create a user
        String newLogin = (String) request.getParameter("login"); 
        boolean changeLogin = newLogin != null && !newLogin.isEmpty();
        EndUser user = new EndUser();

        // Use the fields from the request to set up this user
        user.setLogin(request.getParameter("loginOld"));
        user.setEmail(request.getParameter("email"));
        user.setPassword(request.getParameter("password"));

        changeLogin = changeLogin && !user.getLogin().equals((String) request.getParameter("loginNew"));

        // Attempt to change the username, if applicable.
        if (changeLogin)
            userDao.updateLogin(user, request.getParameter("loginNew"));

        // Attempt to update the user info
        if (userDao.find(user.getLogin()) != null)
            userDao.update(user);

        response.sendRedirect(redirectURL);
    }

    @Override
    protected void doDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        DAOFactory daoFactory = new DAOFactory();
        UserDAO userDao = daoFactory.getUserDAO();

        User user = userDao.find(request.getParameter("login"));

        if (user != null) {
            userDao.delete(user);
        }

        response.sendRedirect(request.getContextPath());
    }
}