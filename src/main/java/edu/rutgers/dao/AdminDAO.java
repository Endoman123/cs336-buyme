package edu.rutgers.dao;

import static edu.rutgers.dao.DAOUtil.*;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import edu.rutgers.model.Admin;

/**
 * This is the DAO to interface with the Admin model.
 * 
 * @author Mikita Belausau
 * @author Muskan Burman
 * @author Dorian Hobot
 * @author Jared Tulayan
 */
public class AdminDAO extends DAO<Admin> {
    // Query constants for easy access and change
    private static final String SQL_LIST_USERS_BY_LOGIN = "SELECT login, email FROM user ORDER BY login";

    private static final String SQL_FIND_USER_BY_LOGIN = "SELECT login, email FROM user WHERE login=?";

    private static final String SQL_FIND_USER_BY_EMAIL = "SELECT login, email FROM user WHERE email=?";

    // TODO: Query with hashed password
    private static final String SQL_FIND_USER_BY_LOGIN_INFO = "SELECT login, email FROM user WHERE login=? AND password=?";

    // TOOD: Insert with hashed password
    private static final String SQL_CREATE_USER = "INSERT INTO user (login, email, password) VALUES (?, ?, ?)";

    // TOOD: update with hashed password
    private static final String SQL_UPDATE_USER = "UPDATE user SET email=? WHERE login=?";

    private static final String SQL_DELETE_USER = "DELETE FROM user WHERE login=?";

    AdminDAO(DAOFactory f) {
        super(f);
    }

    /**
     * Lists admins by user login.
     * 
     * @return              a list of {@code Admin} objects, sorted by login name
     * @throws DAOException if there is an issue with interfacing with the database
     */
    @Override
    public List<Admin> list() throws DAOException {
        List<Admin> users = new ArrayList<>();

        try (
            Connection connection = FACTORY.getConnection();
            PreparedStatement statement = prepareStatement(connection, SQL_LIST_USERS_BY_LOGIN, true);
            ResultSet resultSet = statement.executeQuery();
        ) {
            // Attempt to get a query of users.
            // if we get one, we can just fill it full of users.
            while (resultSet.next()) {
                users.add(map(resultSet));
            }
        } catch (SQLException e) {
            throw new DAOException(e);
        }

        return users;
    }

    /**
     * Checks if a user is an admin using their login name.
     * 
     * @param  login        the user login name to look for
     * @return              true if the user is an admin,
     *                      false otherwise.
     * @throws DAOException if there is an issue with interfacing with the database
     */
    public boolean isAdmin(String login) throws DAOException {
        try (
            Connection connection = FACTORY.getConnection();
            PreparedStatement statement = prepareStatement(connection, SQL_FIND_USER_BY_LOGIN, true, login);
            ResultSet resultSet = statement.executeQuery();
        ) {
            // Attempt to get a user.
            if (resultSet.next())
                return true;
        } catch (SQLException e) {
            throw new DAOException(e);
        }

        return false;
    }

    /**
     * Attempt to create a new admin using the given info.
     * No more than one admin is allowed in the system at a time. 
     * 
     * @param  user         the user to add to the database
     * @throws DAOException if there is an issue with interfacing with the database
     */
    @Override
    public void create(Admin admin) throws DAOException {
        Object values = new Object[] {
            admin.getLogin(),
        };

        try (
            Connection connection = FACTORY.getConnection();
            PreparedStatement statement = prepareStatement(connection, SQL_CREATE_USER, true, values);
        ) {
            if (statement.executeUpdate() == 0)
                throw new DAOException("Failed to create admin, no affected rows.");
        } catch (SQLException e) {
            throw new DAOException(e);
        }
    }

    /**
     * Updates the admin's information in the database.
     * 
     * @param  user         the user with which to base the change on
     * @throws DAOException if there is an issue with interfacing with the database
     */
    @Override
    public void update(Admin user) throws DAOException {
        Object values = new Object[] {
            user.getLogin()
        };

        try (
            Connection connection = FACTORY.getConnection();
            PreparedStatement statement = prepareStatement(connection, SQL_UPDATE_USER, false, values);
        ) {
            if (statement.executeUpdate() == 0)
                throw new DAOException("Failed to update admin, no affected rows.");
        } catch (SQLException e) {
            throw new DAOException(e);
        }
    }

    /**
     * Deletes the admin from the database and sets their login name to null.
     * There can be no more than one admin in the system.
     * 
     * @param  user         the user to delete from the database
     * @throws DAOException if there is an issue with interfacing with the database
     */
    @Override
    public void delete(Admin user) throws DAOException {
        Object values = new Object[] {
            user.getLogin()
        };

        try (
            Connection connection = FACTORY.getConnection();
            PreparedStatement statement = prepareStatement(connection, SQL_DELETE_USER, false, values);
        ) {
            if (statement.executeUpdate() == 0)
                throw new DAOException("Failed to delete admin, no affected rows.");
            else
                user.setLogin(null);
        } catch (SQLException e) {
            throw new DAOException(e);
        }
    }

    /**
     * Map the result set to a new {@code Admin} object.
     * 
     * @param  resultSet    the {@code ResultSet} to use for mapping
     * @return              a {@code Admin} with the fields from the {@code ResultSet}
     *                      mapped to its field
     * @throws SQLException if there is an issue accessing the values in the database
     */
    @Override
    public Admin map(ResultSet resultSet) throws SQLException {
        Admin admin = new Admin();

        admin.setLogin(resultSet.getString("login"));

        return admin;
    }
}