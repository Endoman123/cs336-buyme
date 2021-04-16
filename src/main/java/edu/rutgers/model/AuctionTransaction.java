package edu.rutgers.model;

import java.io.Serializable;
import java.text.DateFormat;
import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * Auction transaction model for the database.
 * Models the generic auction transaction relation in the backend.
 * 
 * @author Mikita Belausau
 * @author Muskan Burman
 * @author Dorian Hobot
 * @author Jared Tulayan
 */
public class AuctionTransaction implements Serializable {
    private static final long serialVersionUID = 1L;

    private Integer auctionID;
    private Integer itemID;
    private String login;
    private Date closeDate;
    private Date closeTime;
    private String winner;
    private Float initPrice;
    private Float bidIncrement;
    private Float minimum;
    private Float finalPrice;

    private void setAuctionID(Integer id) {
        auctionID = id;
    }

    private Integer getAuctionID() {
        return auctionID;
    }

    private void setItemID(Integer id) {
        itemID = id;
    }

    private Integer getItemID() {
        return itemID;
    }

    public void setLogin(String l) {
        login = l;
    }

    public String getLogin() {
        return login;
    }

    private void setCloseDate(Date date) {
        closeDate = date;
    }

    private Date getCloseDate() {
        return closeDate;
    }

    private void setCloseTime(Date time) {
        closeTime = time;
    }

    private Date getCloseTime() {
        return closeTime;
    }

    private void setWinner(String login) {
        winner = login;
    }

    private String getWinner() {
        return winner;
    }

    private void setInitPrice(Float price) {
        initPrice = price;
    }

    private Float getInitPrice() {
        return initPrice;
    }

    private void setBidIncrement(Float bid) {
        bidIncrement = bid;
    }

    private Float getBidIncrement() {
        return bidIncrement;
    }

    private void setMinimum(Float price) {
        minimum = price;
    }

    private Float getMinimum() {
        return minimum;
    }

    private void setFinalPrice(Float price) {
        finalPrice = price;
    }

    private Float getFinalPrice() {
        return finalPrice;
    }
    
    @Override
    public boolean equals(Object other) {
        return (other instanceof AuctionTransaction) ? auctionID.equals(((AuctionTransaction)other).auctionID) : (other == this);
    }

    @Override
    public int hashCode() {
        return (auctionID != null) ? (this.getClass().hashCode() + auctionID.hashCode()) : super.hashCode();
    }

    @Override
    public String toString() {
        DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
        DateFormat timeFormat = new SimpleDateFormat("HH:mm:ss");
        NumberFormat currencyFormat = NumberFormat.getCurrencyInstance();

        return String.format("AuctionTransaction[auctionID=%i,itemID=%i,login=%s,closeDate=%s,closeTime=%s,winner=%s,initPrice=%s,bidIncrement=%s,minimum=%s,finalPrice=%s]", 
            auctionID, 
            itemID,
            login,
            dateFormat.format(closeDate),
            timeFormat.format(closeTime),
            winner,
            currencyFormat.format(initPrice),
            currencyFormat.format(bidIncrement),
            currencyFormat.format(minimum),
            currencyFormat.format(finalPrice)
        );
    } 
}
