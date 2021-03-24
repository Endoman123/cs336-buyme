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
    private static final String SQL_LIST_USERS_BY_ID = "SELECT id, login, email FROM user ORDER BY id";

    private static final String SQL_FIND_USER_BY_ID = "SELECT id, login, email FROM user WHERE id=?";

    // TODO: Query with hashed password
    private static final String SQL_FIND_USER_BY_LOGIN_INFO = "SELECT id, login, email FROM user WHERE login=? AND password=?";

    // TOOD: Insert with hashed password
    private static final String SQL_CREATE_USER = "INSERT INTO user (login, email, password) VALUES (?, ?, ?)";

    // TOOD: update with hashed password
    private static final String SQL_UPDATE_USER = "UPDATE user SET login=?, email=? WHERE id=?";

    private static final String SQL_DELETE_USER = "DELETE FROM user WHERE id=?";

    UserDAO(DAOFactory f) {
        super(f);
    }

    /**
     * Lists users by user ID
     * 
     * @return              a list of {@code User} objects, sorted by ID.
     * @throws DAOException if there is an issue with interfacing with the database
     */
    @Override
    public List<User> list() throws DAOException {
        List<User> users = new ArrayList<>();

        try (
            Connection connection = FACTORY.getConnection();
            PreparedStatement statement = prepareStatement(connection, SQL_LIST_USERS_BY_ID, true);
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
     * Finds a user by id.
     * 
     * @param  id           the user id to look for
     * @return              a {@code User} object with the given ID,
     *                      or {@code null} if no {@code User} was found
     * @throws DAOException if there is an issue with interfacing with the database
     */
    public User find(Integer id) throws DAOException {
        User user = null;

        try (
            Connection connection = FACTORY.getConnection();
            PreparedStatement statement = prepareStatement(connection, SQL_FIND_USER_BY_ID, true, id);
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
            PreparedStatement statement = prepareStatement(connection, SQL_FIND_USER_BY_ID, true, values);
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
     * Attempt to create a new user using the given info.
     * The id of the {@code User} object is ignored.
     * 
     * @param  user         the user to add to the database
     * @throws DAOException if there is an issue with interfacing with the database
     */
    @Override
    public void create(User user) throws DAOException {
        Object values = new Object[] {
            user.getLogin(),
            user.getEmail(),
            user.getPassword()
        };

        try (
            Connection connection = FACTORY.getConnection();
            PreparedStatement statement = prepareStatement(connection, SQL_CREATE_USER, true, values);
        ) {
            if (statement.executeUpdate() == 0)
                throw new DAOException("Failed to create user, no affected rows.");

            try (ResultSet keys = statement.getGeneratedKeys()) {
                if (keys.next())
                    user.setID(keys.getInt(1));
                else
                    throw new DAOException("Failed to create user, no generated key.");
            }
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
        Object values = new Object[] {
            user.getLogin(),
            user.getEmail(),
            user.getID()
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
     * Deletes the user from the database and sets their ID to null.
     * 
     * @param  user         the user to delete from the database
     * @throws DAOException if there is an issue with interfacing with the database
     */
    @Override
    public void delete(User user) throws DAOException {
        Object values = new Object[] {
            user.getID()
        };

        try (
            Connection connection = FACTORY.getConnection();
            PreparedStatement statement = prepareStatement(connection, SQL_DELETE_USER, false, values);
        ) {
            if (statement.executeUpdate() == 0)
                throw new DAOException("Failed to delete user, no affected rows.");
            else
                user.setID(null);
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

        user.setID(resultSet.getInt("id"));
        user.setLogin(resultSet.getString("login"));
        user.setEmail(resultSet.getString("email"));
        user.setPassword(resultSet.getString("password"));

        return user;
    }
}