package edu.rutgers.servlet;

import java.io.IOException;
import java.net.http.HttpRequest;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import edu.rutgers.dao.DAOFactory;
import edu.rutgers.dao.QuestionDAO;
import edu.rutgers.model.Question;

/**
 * Customer Support servlet for asking questions
 */
@WebServlet("/support/ask")
public class AskQuestionServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);

        // Make sure the user is logged in before asking a question
        if (session == null || session.getAttribute("user") == null) {
            throw new IllegalStateException("On ask page, but user is not logged in.");
        } else {
            request.getRequestDispatcher("/WEB-INF/views/support/ask.jsp").forward(request, response);
        }
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        DAOFactory daoFactory = new DAOFactory();
        QuestionDAO questionDao = daoFactory.getQuestionDAO();
        String redirectURI = request.getContextPath() + "/support";

        Question question = new Question();

        question.setEuLogin(request.getParameter("login"));
        question.setQuestionText(request.getParameter("question_text"));

        questionDao.create(question);

        response.sendRedirect(redirectURI);
    }
}
