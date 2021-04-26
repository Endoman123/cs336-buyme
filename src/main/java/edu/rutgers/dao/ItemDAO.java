package edu.rutgers.dao;

import static edu.rutgers.dao.DAOUtil.prepareStatement;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import edu.rutgers.model.Item;

/**
 * This is the DAO to interface with the {@code Item} model.
 * 
 * @author Mikita Belausau
 * @author Muskan Burman
 * @author Dorian Hobot
 * @author Jared Tulayan
 * 
 * @see edu.rutgers.model.Item Item
 */
public class ItemDAO extends DAO<Item> {
    // Query constants for easy access and change
    private static final String SQL_LIST_ITEMS = "SELECT * FROM item ORDER BY item_ID";

    private static final String SQL_FIND_ITEM_BY_ID = "SELECT * FROM item WHERE item_ID=?";

    private static final String SQL_CREATE_ITEM = 
        "INSERT INTO item (name, subcategory, color, brand) VALUES (?, ?, ?, ?)";

    private static final String SQL_UPDATE_ITEM = 
        "UPDATE item SET name=IFNULL(?, name), subcategory=IFNULL(?, subcategory), color=IFNULL(?, color), brand=IFNULL(?, brand)) WHERE item_ID=?";

    private static final String SQL_DELETE_ITEM = "DELETE FROM item WHERE item_ID=?";

    ItemDAO(DAOFactory f) {
        super(f);
    }

    /**
     * Lists items by ID.
     * 
     * @return              a list of {@code Item} objects, sorted by ID
     * @throws DAOException if there is an issue with interfacing with the database
     */
    @Override
    public List<Item> list() throws DAOException {
        List<Item> items = new ArrayList<>();

        try (
            Connection connection = FACTORY.getConnection();
            PreparedStatement statement = prepareStatement(connection, SQL_LIST_ITEMS, true);
            ResultSet resultSet = statement.executeQuery();
        ) {
            // Attempt to get a query of items.
            // if we get one, we can just fill it full of items.
            while (resultSet.next()) {
                items.add(map(resultSet));
            }
        } catch (SQLException e) {
            throw new DAOException(e);
        }

        return items;
    }

    /**
     * Finds an item by ID.
     * 
     * @param  id           the item ID to look for
     * @return              an {@code Item} object with the given ID,
     *                      or {@code null} if no {@code Item} was found
     * @throws DAOException if there is an issue with interfacing with the database
     */
    public Item find(int id) throws DAOException {
        Item item = null;

        try (
            Connection connection = FACTORY.getConnection();
            PreparedStatement statement = prepareStatement(connection, SQL_FIND_ITEM_BY_ID, true, id);
            ResultSet resultSet = statement.executeQuery();
        ) {
            // Attempt to get an auction.
            if (resultSet.next())
                item = map(resultSet);
        } catch (SQLException e) {
            throw new DAOException(e);
        }

        return item;
    }

    /**
     * Attempt to create a new item using the given info.
     * 
     * @param  item         the item to add to the database
     * @throws DAOException if there is an issue with interfacing with the database
     */
    @Override
    public void create(Item item) throws DAOException {
        Object[] values = new Object[] {
            item.getItemID(),
            item.getName(),
            item.getSubcategory(),
            item.getColor(),
            item.getBrand()
        };

        try (
            Connection connection = FACTORY.getConnection();
            PreparedStatement statement = prepareStatement(connection, SQL_CREATE_ITEM, true, values);
        ) {
            if (statement.executeUpdate() == 0)
                throw new DAOException("Failed to create item, no affected rows.");
        } catch (SQLException e) {
            throw new DAOException(e);
        }
    }

    /**
     * Updates the item's information in the database, matched by the given {@code Item}'s ID.
     * You cannot update the item's ID.
     * <p>
     * Any field left {@code null} will not be updated.
     * 
     * @param  item         the item with which to base the change on
     * @throws DAOException if there is an issue with interfacing with the database
     */
    @Override
    public void update(Item item) throws DAOException {
        Object[] values = new Object[] {
            item.getName(),
            item.getSubcategory(),
            item.getColor(),
            item.getBrand(),
            item.getItemID()
        };

        try (
            Connection connection = FACTORY.getConnection();
            PreparedStatement statement = prepareStatement(connection, SQL_UPDATE_ITEM, false, values);
        ) {
            if (statement.executeUpdate() == 0)
                throw new DAOException("Failed to update auction, no affected rows.");
        } catch (SQLException e) {
            throw new DAOException(e);
        }
    }

    /**
     * Deletes the item from the database and sets the itemID to null.
     * 
     * @param  item         the item to delete from the database
     * @throws DAOException if there is an issue with interfacing with the database
     */
    @Override
    public void delete(Item item) throws DAOException {
        try (
            Connection connection = FACTORY.getConnection();
            PreparedStatement statement = prepareStatement(connection, SQL_DELETE_ITEM, false, item.getItemID());
        ) {
            if (statement.executeUpdate() == 0)
                throw new DAOException("Failed to delete item, no affected rows.");
            else
                item.setItemID(null);
        } catch (SQLException e) {
            throw new DAOException(e);
        }
    }

    /**
     * Map the result set to a new {@code Item} object.
     * 
     * @param  resultSet    the {@code ResultSet} to use for mapping
     * @return              an {@code Item} with the fields from the {@code ResultSet}
     *                      mapped to its field
     * @throws SQLException if there is an issue accessing the values in the database
     */
    @Override
    public Item map(ResultSet resultSet) throws SQLException {
        Item item = new Item();

        item.setItemID(resultSet.getInt("item_ID"));
        item.setName(resultSet.getString("name"));
        item.setSubcategory(resultSet.getString("subcategory"));
        item.setBrand(resultSet.getString("brand"));
        item.setColor(resultSet.getString("color"));

        return item;
    }
}