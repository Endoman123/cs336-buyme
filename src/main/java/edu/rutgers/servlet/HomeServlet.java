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
 * Main page servlet
 */
@WebServlet("/")
public class HomeServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        DAOFactory daoFactory = new DAOFactory();
        UserDAO userDao = daoFactory.getUserDAO();
        StringBuilder content = new StringBuilder();

        if (session != null && session.getAttribute("user") != null) {
            User user = (User) session.getAttribute("user");

            content.append("<a href=\"support\">Support</a>");
            content.append("<a href=\"profile\">Profile</a>");
            content.append("<a href=\"logout\">Logout</a>");

            if (userDao.getAdmin().equals(user)) { // Admin stuff
                content.append("<a href=\"admin/add-rep\">Add Customer Representative</a>");
            } else if (userDao.findCustomerRep(user.getLogin()) != null) { // Customer Rep Stuff
                // not sure what to put here
            } else { // End user stuff
                content.append("<a href=\"autobid.jsp\">Autobid</a>");
            }
        } else {
            content.append("<a href=\"login\">Login</a>");
            content.append("<a href=\"register\">Register</a>");
        }

        request.setAttribute("content", content);

        request.getRequestDispatcher("/WEB-INF/views/index.jsp").forward(request, response);
    }
}