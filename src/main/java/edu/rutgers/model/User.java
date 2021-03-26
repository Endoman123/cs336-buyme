package edu.rutgers.model;

/**
 * User model for the database.
 * Handles the high-level representation of a user.
 * 
 * @author Mikita Belausau
 * @author Muskan Burman
 * @author Dorian Hobot
 * @author Jared Tulayan
 */
public class User {
    public static enum Type {
        END_USER,
        CUSTOMER_REP,
        ADMIN
    };

    private String login;
    private String email;
    private String password;
    private Type type;

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
    
    public void setType(Type t) {
        type = t;
    }

    public Type getType() {
        return type;
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
        return String.format("User[type=%s,login=%s,email=%s]", type.name(), login, email);
    } 
}
