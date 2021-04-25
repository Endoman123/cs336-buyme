package edu.rutgers.tag;

import java.io.IOException;
import java.util.Iterator;
import java.util.List;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.BodyContent;
import javax.servlet.jsp.tagext.BodyTagSupport;

import edu.rutgers.dao.AuctionTransactionDAO;
import edu.rutgers.dao.DAOFactory;
import edu.rutgers.model.AuctionTransaction;

/**
 * This tag gets all the auctions.
 * 
 * @author Jared Tulayan
 */
public class GetAuctionsTag extends BodyTagSupport {
    private DAOFactory daoFactory = new DAOFactory();
    private AuctionTransactionDAO auctionDao = daoFactory.getAuctionTransactionDAO();

    private Iterator<AuctionTransaction> auctions;
    private String winner;

    public void setWinner(String w) {
        winner = w;
    }

    public String getWinner() {
        return winner;
    }

    @Override
    public int doStartTag() throws JspException {
        // Initialize variables
        List<AuctionTransaction> aList = auctionDao.list();
    
        if (winner != null && !winner.isEmpty())
            aList.removeIf(a -> !winner.equals(a.getWinner())); 

        if (aList.isEmpty()) {
            try {
                BodyContent b = bodyContent;
                JspWriter out  = b.getEnclosingWriter();
                out.write("<p>Sorry, no auctions!</p>");
            } catch (IOException e) {
                e.printStackTrace();
            }
            
            return SKIP_BODY;
        }

        auctions = aList.iterator();

        return EVAL_BODY_BUFFERED;
    }

    @Override
    public void doInitBody() throws JspException {
        pageContext.setAttribute("auction", auctions.next());
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

        AuctionTransaction a = auctions.hasNext() ? auctions.next() : null;

        if (a != null) {
            pageContext.setAttribute("auction", a);
            return EVAL_BODY_AGAIN;
        } else
            return SKIP_BODY;
    }
}
