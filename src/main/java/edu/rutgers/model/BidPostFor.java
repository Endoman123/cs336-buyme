package edu.rutgers.model;

import java.io.Serializable;
import java.text.DateFormat;
import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * Bid post model for the database.
 * Models the generic bid posts for auction relation in the backend.
 * 
 * @author Mikita Belausau
 * @author Muskan Burman
 * @author Dorian Hobot
 * @author Jared Tulayan
 */
public class BidPostFor implements Serializable {
    private static final long serialVersionUID = 1L;

    private Integer bidNumber;
    private String login;
    private Integer auctionID;
    private Float amount;
    private Date bidDate;
    private Date bidTime;
    private Boolean autoBid;
    private Float bidIncrement;
    private Float upperLimit;

    private void setAuctionID(Integer id) {
        auctionID = id;
    }

    private Integer getAuctionID() {
        return auctionID;
    }

    private void setItemID(Integer id) {
        bidNumber = id;
    }

    private Integer getItemID() {
        return bidNumber;
    }

    public void setLogin(String l) {
        login = l;
    }

    public String getLogin() {
        return login;
    }

    private void setCloseDate(Date date) {
        bidDate = date;
    }

    private Date getCloseDate() {
        return bidDate;
    }

    private void setCloseTime(Date time) {
        bidTime = time;
    }

    private Date getCloseTime() {
        return bidTime;
    }

    private void setInitPrice(Float price) {
        upperLimit = price;
    }

    private Float getInitPrice() {
        return upperLimit;
    }

    private void setBidIncrement(Float bid) {
        bidIncrement = bid;
    }

    private Float getBidIncrement() {
        return bidIncrement;
    }

    private void setMinimum(Float price) {
        amount = price;
    }

    private Float getMinimum() {
        return amount;
    }

    @Override
    public boolean equals(Object other) {
        return (other instanceof BidPostFor) ? bidNumber.equals(((BidPostFor)other).bidNumber) : (other == this);
    }

    @Override
    public int hashCode() {
        return (bidNumber != null) ? (this.getClass().hashCode() + bidNumber.hashCode()) : super.hashCode();
    }

    @Override
    public String toString() {
        DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
        DateFormat timeFormat = new SimpleDateFormat("HH:mm:ss");
        NumberFormat currencyFormat = NumberFormat.getCurrencyInstance();

        return String.format("BidPost[bidNumber=%i,login=%s,auctionID=%i,bidDate=%s,bidTime=%s,autoBid=%s,bidIncrement=%s,upperLimit=%s]", 
            bidNumber,
            login,
            auctionID, 
            currencyFormat.format(amount),
            dateFormat.format(bidDate),
            timeFormat.format(bidTime),
            autoBid.toString(),
            currencyFormat.format(bidIncrement),
            currencyFormat.format(upperLimit)
        );
    } 
}
