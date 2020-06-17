package com.sungjun.web.controller;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;

public class InsertStatementStrategy implements StatementStrategy {
    @Override
    public PreparedStatement makeStatement(Object object, Connection connection) throws SQLException {
        User user = (User)object;
        PreparedStatement preparedStatement = connection.prepareStatement("INSERT INTO wordbook1 (word,mean) VALUES (?,?);", Statement.RETURN_GENERATED_KEYS);
        preparedStatement.setString(1, user.getWord());
        preparedStatement.setString(2, user.getMean());
        return preparedStatement;
    }
}
