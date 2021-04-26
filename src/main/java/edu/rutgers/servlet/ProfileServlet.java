package edu.rutgers.servlet;

import java.io.IOException;
import java.util.Calendar;

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
import edu.rutgers.util.Crypto;

/**
 * User servlet for viewing their profile
 * 
 * @author Jared Tulayan
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
            request.getRequestDispatcher("/WEB-INF/views/profile/index.jsp").forward(request, response);
    }
}