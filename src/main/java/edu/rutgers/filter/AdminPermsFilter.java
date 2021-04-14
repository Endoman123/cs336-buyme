package edu.rutgers.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import edu.rutgers.dao.DAOFactory;
import edu.rutgers.dao.UserDAO;
import edu.rutgers.model.Admin;
import edu.rutgers.model.User;

/**
 * Filter to check if a user is an admin. If they are not, redirect them to login.
 */
@WebFilter( urlPatterns = { "/admin", "/admin/*"} )
public class AdminPermsFilter implements Filter {
    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain) throws ServletException, IOException {    
        DAOFactory daoFactory = new DAOFactory();
        UserDAO userDao = daoFactory.getUserDAO();

        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) res;
        
        HttpSession session = request.getSession(false);
        String loginURI = request.getContextPath() + "/login";

        Admin a = userDao.getAdmin(); 
        boolean isAdmin = session != null && session.getAttribute("user") != null && ((User) session.getAttribute("user")).equals(a);

        if (isAdmin)
            chain.doFilter(request, response);
        else
            response.sendRedirect(loginURI);
    }

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {}

    @Override
    public void destroy() {}
}
