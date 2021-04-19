package edu.rutgers.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import edu.rutgers.model.Question;

/**
 * This is the DAO to interface with the {@code Question} model.
 * 
 * @author Mikita Belausau
 * @author Muskan Burman
 * @author Dorian Hobot
 * @author Jared Tulayan
 * 
 * @see edu.rutgers.model.Question Question
 */
public class QuestionDAO extends DAO<Question> {

    public QuestionDAO(DAOFactory f) {
        super(f);
    }

    @Override
    public List<Question> list() throws DAOException {
        // TODO Auto-generated method stub
        return null;
    }

    @Override
    public void create(Question t) throws DAOException {
        // TODO Auto-generated method stub
        
    }

    @Override
    public void update(Question t) throws DAOException {
        // TODO Auto-generated method stub
        
    }

    @Override
    public void delete(Question t) throws DAOException {
        // TODO Auto-generated method stub
        
    }

    @Override
    protected Question map(ResultSet resultSet) throws SQLException {
        // TODO Auto-generated method stub
        return null;
    }
    
}
