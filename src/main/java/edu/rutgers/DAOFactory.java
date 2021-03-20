package edu.rutgers;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * This class handles creating connections to the database.
 * 
 * @author Mikita Belausau
 * @author Muskan Burman
 * @author Dorian Hobot
 * @author Jared Tulayan
 */
public class DAOFactory {
    // The URL to connect to the MySQL table
    public static final String CONNECTION_URL = "jdbc:mysql://localhost:3306/buyme";

    // A static block for simply loading the MySQL JDBC Driver
    static {
        try {
            // Load JDBC driver - the interface standardizing the connection procedure. 
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    /**
     * Creates a connection to the database
     * 
     * @return the {@code Connection} to the database
     */
    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(CONNECTION_URL, "root", "cs336project");
    }
    
    public static void main(String[] args) {
        try {
            Connection connection = getConnection();
            System.out.println(connection);	
            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
