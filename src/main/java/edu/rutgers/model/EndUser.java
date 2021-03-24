package edu.rutgers.model;

/**
 * End-user model for the database.
 * Handles the high-level representation of an end-user.
 * 
 * @author Mikita Belausau
 * @author Muskan Burman
 * @author Dorian Hobot
 * @author Jared Tulayan
 */
public class EndUser {
    public String login;
    
    public void setLogin(String l) {
        login = l;
    }

    public String getLogin() {
        return login;
    }
}
