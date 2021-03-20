package edu.rutgers.model;

/**
 * User model for the database.
 * Handles creation, modification, and deletion of users from the SQL table.
 * 
 * @author Mikita Belausau
 * @author Muskan Burman
 * @author Dorian Hobot
 * @author Jared Tulayan
 */
public class User {
    private Integer id;
    private String login;
    private String email;
    private String password;

    public void setID(Integer i) {
        id = i;
    }

    public Integer getID() {
        return id;
    }

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
        return (other instanceof User) && (id != null) ? id == ((User)other).id : (other == this);
    }

    @Override
    public int hashCode() {
        return (id != null) ? (this.getClass().hashCode() + id.hashCode()) : super.hashCode();
    }

    @Override
    public String toString() {
        return String.format("User<%d : login=%s,email=%s>", id, login, email);
    } 
}
