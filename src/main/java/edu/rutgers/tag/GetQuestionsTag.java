package edu.rutgers.tag;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.BodyContent;
import javax.servlet.jsp.tagext.BodyTagSupport;

import edu.rutgers.dao.DAOFactory;
import edu.rutgers.dao.QuestionDAO;
import edu.rutgers.model.Question;

/**
 * This tag lists all the questions.
 */
public class GetQuestionsTag extends BodyTagSupport {
    private DAOFactory daoFactory = new DAOFactory();
    private QuestionDAO questionDao = daoFactory.getQuestionDAO();

    private Iterator<Question> questions;
    private String searchQuery;

    private static final Pattern KEYWORD_PATTERN = Pattern.compile("(\"([^\"]*)\"|(\\S+))");

    public void setSearchQuery(String c) {
        searchQuery = c;
    }

    public String getItemClass() {
        return searchQuery;
    }

    @Override
    public int doStartTag() throws JspException {
        // Initialize variables
        List<Question> qList = questionDao.list();

        if (searchQuery != null && !searchQuery.isEmpty()) {
            StringBuilder queryBuilder = new StringBuilder();
            String queryRegex;
            List<String> keywords = new ArrayList<>();
            Matcher m;

            // Filter question string
            // Basically just escape the string for any regex keys
            searchQuery = searchQuery
                .replaceAll("[\\[\\]\\{\\}\\(\\)\\^\\|\\.\\*]", "");

            m = KEYWORD_PATTERN.matcher(searchQuery);

            // Build regex string
            while (m.find())
                keywords.add(m.group(1).replaceAll("\\\"", ""));
        
            for (String key : keywords) {
                if (!key.toLowerCase().matches("i|you|he|she|we|they|the|it")) {
                    queryBuilder.append(".*\\b" + key.toLowerCase() + "\\b.*");
                    queryBuilder.append("|");
                }
            }
        
            queryBuilder.setLength(queryBuilder.length() - 1);
            queryRegex = queryBuilder.toString();

            // We do filtering in here because we can use regex for matching.
            qList.removeIf(q -> !q.getQuestionText().toLowerCase().matches(queryRegex)); 
        }

        if (qList.isEmpty()) {
            try {
                getPreviousOut().write("<p>Sorry, no questions!</p>");
            } catch (IOException e) {
                e.printStackTrace();
            }
            
            return SKIP_BODY;
        }

        questions = qList.iterator();

        return EVAL_BODY_BUFFERED;
    }

    @Override
    public void doInitBody() throws JspException {
        pageContext.setAttribute("question", questions.next());
    }

    @Override
    public int doAfterBody() throws JspException {
        try {
            BodyContent b = getBodyContent();
            JspWriter out = b.getEnclosingWriter();
            out.println(b.getString());
            b.clearBody();
        } catch (Exception e) {
            e.printStackTrace();
        }

        Question q = questions.hasNext() ? questions.next() : null;

        if (q != null) {
            pageContext.setAttribute("question", q);
            return EVAL_BODY_AGAIN;
        } else
            return SKIP_BODY;
    }
}
