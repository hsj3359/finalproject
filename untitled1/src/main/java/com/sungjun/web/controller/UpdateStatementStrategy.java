package com.sungjun.web.controller;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class UpdateStatementStrategy implements StatementStrategy {
    @Override
    public PreparedStatement makeStatement(Object object, Connection connection) throws SQLException {
        PreparedStatement preparedStatement = connection.prepareStatement("update wordbook1 set word=?, mean=? where id=? ");
        User user = (User) object;
        preparedStatement.setString(1, user.getWord());
        preparedStatement.setString(2, user.getMean());
        preparedStatement.setInt(3,user.getId());
        return preparedStatement;
    }
}
