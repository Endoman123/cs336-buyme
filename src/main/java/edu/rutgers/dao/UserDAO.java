package edu.rutgers.dao;

import static edu.rutgers.dao.DAOUtil.*;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import edu.rutgers.model.User;

/**
 * This is the DAO to interface with the User model.
 * 
 * @author Mikita Belausau
 * @author Muskan Burman
 * @author Dorian Hobot
 * @author Jared Tulayan
 */
public class UserDAO extends DAO<User> {
    // Query constants for easy access and change
    private static final String SQL_LIST_USERS_BY_LOGIN = "SELECT login, email, type FROM user ORDER BY login";

    private static final String SQL_FIND_USER_BY_LOGIN = "SELECT login, email, type FROM user WHERE login=?";

    private static final String SQL_FIND_USER_BY_EMAIL = "SELECT login, email, type FROM user WHERE email=?";

    // TODO: Query with hashed password
    private static final String SQL_FIND_USER_BY_LOGIN_INFO = "SELECT login, email, type FROM user WHERE login=? AND password=?";

    // TOOD: Insert with hashed password
    private static final String SQL_CREATE_USER = "INSERT INTO user (login, email, password, type) VALUES (?, ?, ?, ?)";

    // TOOD: update with hashed password
    private static final String SQL_UPDATE_USER = "UPDATE user SET email=? WHERE login=?";

    private static final String SQL_DELETE_USER = "DELETE FROM user WHERE login=?";

    UserDAO(DAOFactory f) {
        super(f);
    }

    /**
     * Lists users by user login.
     * 
     * @return              a list of {@code User} objects, sorted by login name
     * @throws DAOException if there is an issue with interfacing with the database
     */
    @Override
    public List<User> list() throws DAOException {
        List<User> users = new ArrayList<>();

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
     * Finds a user by login name.
     * 
     * @param  login        the user login name to look for
     * @return              a {@code User} object with the given login name,
     *                      or {@code null} if no {@code User} was found
     * @throws DAOException if there is an issue with interfacing with the database
     */
    public User find(String login) throws DAOException {
        User user = null;

        try (
            Connection connection = FACTORY.getConnection();
            PreparedStatement statement = prepareStatement(connection, SQL_FIND_USER_BY_LOGIN, true, login);
            ResultSet resultSet = statement.executeQuery();
        ) {
            // Attempt to get a user.
            if (resultSet.next())
                user = map(resultSet);
        } catch (SQLException e) {
            throw new DAOException(e);
        }

        return user;
    }

    /**
     * Finds a user by their login information, that is, their login and password.
     * 
     * @param  login        the login to match
     * @param  password     the password to match
     * @return              a {@code User} object with the given login info,
     *                      or {@code null} if no {@code User} was found
     * @throws DAOException if there is an issue with interfacing with the database
     */
    public User find(String login, String password) throws DAOException {
        User user = null;

        Object[] values = new Object[]{
            login,
            password
        };

        try (
            Connection connection = FACTORY.getConnection();
            PreparedStatement statement = prepareStatement(connection, SQL_FIND_USER_BY_LOGIN_INFO, true, values);
            ResultSet resultSet = statement.executeQuery();
        ) {
            // Attempt to get a user.
            if (resultSet.next())
                user = map(resultSet);
        } catch (SQLException e) {
            throw new DAOException(e);
        }

        return user;
    }

    /**
     * Check if a email is currently being used in the users database.
     * 
     * @param  email        the email to test against the database
     * @return              true if the login is being used,
     *                      false otherwise
     * @throws DAOException if there is an issue with interfacing with the database
     */
    public boolean checkEmailExists(String email) throws DAOException {
        boolean exists = false;

        try (
            Connection connection = FACTORY.getConnection();
            PreparedStatement statement = prepareStatement(connection, SQL_FIND_USER_BY_EMAIL, true, email);
            ResultSet resultSet = statement.executeQuery();
        ) {
            // Find a user that has the login name.
            exists = resultSet.next();
        } catch (SQLException e) {
            throw new DAOException(e);
        }

        return exists;
    }

    /**
     * Attempt to create a new user using the given info.
     * 
     * @param  user         the user to add to the database
     * @throws DAOException if there is an issue with interfacing with the database
     */
    @Override
    public void create(User user) throws DAOException {
        Object[] values = new Object[] {
            user.getLogin(),
            user.getEmail(),
            user.getPassword(),
            user.getType().name()
        };

        try (
            Connection connection = FACTORY.getConnection();
            PreparedStatement statement = prepareStatement(connection, SQL_CREATE_USER, true, values);
        ) {
            if (statement.executeUpdate() == 0)
                throw new DAOException("Failed to create user, no affected rows.");
        } catch (SQLException e) {
            throw new DAOException(e);
        }
    }

    /**
     * Updates the user's information in the database, matched by the given ID.
     * 
     * @param  user         the user with which to base the change on
     * @throws DAOException if there is an issue with interfacing with the database
     */
    @Override
    public void update(User user) throws DAOException {
        Object[] values = new Object[] {
            user.getEmail(),
            user.getLogin()
        };

        try (
            Connection connection = FACTORY.getConnection();
            PreparedStatement statement = prepareStatement(connection, SQL_UPDATE_USER, false, values);
        ) {
            if (statement.executeUpdate() == 0)
                throw new DAOException("Failed to update user, no affected rows.");
        } catch (SQLException e) {
            throw new DAOException(e);
        }
    }

    /**
     * Deletes the user from the database and sets their login name to null.
     * 
     * @param  user         the user to delete from the database
     * @throws DAOException if there is an issue with interfacing with the database
     */
    @Override
    public void delete(User user) throws DAOException {
        try (
            Connection connection = FACTORY.getConnection();
            PreparedStatement statement = prepareStatement(connection, SQL_DELETE_USER, false, user.getLogin());
        ) {
            if (statement.executeUpdate() == 0)
                throw new DAOException("Failed to delete user, no affected rows.");
            else
                user.setLogin(null);
        } catch (SQLException e) {
            throw new DAOException(e);
        }
    }

    /**
     * Map the result set to a new {@code User} object.
     * 
     * @param  resultSet    the {@code ResultSet} to use for mapping
     * @return              a {@code User} with the fields from the {@code ResultSet}
     *                      mapped to its field
     * @throws SQLException if there is an issue accessing the values in the database
     */
    @Override
    public User map(ResultSet resultSet) throws SQLException {
        User user = new User();

        user.setLogin(resultSet.getString("login"));
        user.setEmail(resultSet.getString("email"));
        user.setType(User.Type.valueOf(resultSet.getString("type")));

        return user;
    }
}