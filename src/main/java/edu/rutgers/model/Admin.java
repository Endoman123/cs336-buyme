package edu.rutgers.model;

/**
 * Admin model for the database.
 * Handles the high-level representation of an admin.
 * 
 * @author Mikita Belausau
 * @author Muskan Burman
 * @author Dorian Hobot
 * @author Jared Tulayan
 */
public class Admin {
    public String login;
    
    public void setLogin(String l) {
        login = l;
    }

    public String getLogin() {
        return login;
    }
}
