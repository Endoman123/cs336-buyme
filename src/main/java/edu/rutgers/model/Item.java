package edu.rutgers.model;

import java.io.Serializable;

/**
 * Item model for the database.
 * Models the generic item relation in the backend.
 * 
 * @author Mikita Belausau
 * @author Muskan Burman
 * @author Dorian Hobot
 * @author Jared Tulayan
 */
public class Item implements Serializable {
    private static final long serialVersionUID = 1L;

    private Integer itemID;
    private String name;
    private String subcategory;
    private String color;
    private String brand;

    public void setItemID(Integer i) {
        itemID = i;
    }

    public Integer getItemID() {
        return itemID;
    }

    public void setName(String n) {
        name = n;
    }

    public String getName() {
        return name;
    }

    public void setSubcategory(String category) {
        subcategory = category;
    }

    public String getSubcategory() {
        return subcategory;
    }

    public void setColor(String c) {
        color = c;
    }

    public String getColor() {
        return color;
    }

    public void setBrand(String b) {
        brand = b;
    }

    public String getBrand() {
        return brand;
    }
    
    @Override
    public boolean equals(Object other) {
        return (other instanceof Item) ? itemID == ((Item)other).itemID : (other == this);
    }

    @Override
    public int hashCode() {
        return (itemID != null) ? (this.getClass().hashCode() + itemID.hashCode()) : super.hashCode();
    }

    @Override
    public String toString() {
        return String.format("Item[itemID=%d,name=%s,subcategory=%s,color=%s,brand=%s]", itemID, name, subcategory, color, brand);
    } 
}
