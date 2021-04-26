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

import edu.rutgers.dao.BidPostForDAO;
import edu.rutgers.dao.DAOFactory;
import edu.rutgers.model.BidPostFor;

/**
 * This tag gets all the bids.
 * 
 * @author Jared Tulayan
 */
public class GetBidsTag extends BodyTagSupport {
    private DAOFactory daoFactory = new DAOFactory();
    private BidPostForDAO bidDao = daoFactory.getBidPostForDAO();

    private Iterator<BidPostFor> bids;
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
        List<BidPostFor> bList = bidDao.list();

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
            // TODO: Implement search filtering
            bList.removeIf(a -> {
                return false;
            }); 
        }

        if (bList.isEmpty()) {
            try {
                pageContext.getOut().write("<p>Sorry, no bids!</p>");
            } catch (IOException e) {
                e.printStackTrace();
            }
            
            return SKIP_BODY;
        }

        bids = bList.iterator();

        return EVAL_BODY_BUFFERED;
    }

    @Override
    public void doInitBody() throws JspException {
        pageContext.setAttribute("bid", bids.next());
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

        BidPostFor b = bids.hasNext() ? bids.next() : null;

        if (b != null) {
            pageContext.setAttribute("bid", b);
            return EVAL_BODY_AGAIN;
        } else
            return SKIP_BODY;
    }
}
