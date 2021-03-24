package edu.rutgers.model;

/**
 * Customer representative model for the database.
 * Handles the high-level representation of a customer representative.
 * 
 * @author Mikita Belausau
 * @author Muskan Burman
 * @author Dorian Hobot
 * @author Jared Tulayan
 */
public class CustomerRep {
    public String login;
    
    public void setLogin(String l) {
        login = l;
    }

    public String getLogin() {
        return login;
    }
}
