package edu.rutgers.model;

import java.io.Serializable;

/**
 * User model for the database.
 * Models the generic user relation in the backend.
 * 
 * @author Mikita Belausau
 * @author Muskan Burman
 * @author Dorian Hobot
 * @author Jared Tulayan
 */
public class User implements Serializable {
    private static final long serialVersionUID = 1L;

    private String login;
    private String email;
    private String password;

    public void setLogin(String l) {
        login = l;
    }

    public String getLogin() {
        return login;
    }

    public void setEmail(String e) {
        email = e;
    }

    public String getEmail() {
        return email;
    }

    public void setPassword(String pw) {
        password = pw;
    }

    public String getPassword() {
        return password;
    }
    
    @Override
    public boolean equals(Object other) {
        return (other instanceof User) ? login.equals(((User)other).login) : (other == this);
    }

    @Override
    public int hashCode() {
        return (login != null) ? (this.getClass().hashCode() + login.hashCode()) : super.hashCode();
    }

    @Override
    public String toString() {
        return String.format("User[login=%s,email=%s]", login, email);
    } 
}
