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

import edu.rutgers.model.User;
import edu.rutgers.model.User.Type;

/**
 * Filter to check if a user is an admin. If they are not, redirect them to login.
 */
@WebFilter( urlPatterns = { "/admin", "/admin/*"} )
public class AdminPermsFilter implements Filter {
    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain) throws ServletException, IOException {    
        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) res;
        
        HttpSession session = request.getSession(false);
        String loginURI = request.getContextPath() + "/login";

        boolean isAdmin = session != null && session.getAttribute("user") != null && ((User) session.getAttribute("user")).getType() == Type.ADMIN;

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
