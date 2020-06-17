package com.sungjun.web.controller;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class DeleteStatementStrategy implements StatementStrategy {
    @Override
    public PreparedStatement makeStatement(Object object, Connection connection) throws SQLException {
        Integer id = (Integer) object;
        PreparedStatement preparedStatement;
        preparedStatement = connection.prepareStatement("delete from wordbook1 where id=?");
        preparedStatement.setInt(1, id);
        return preparedStatement;
    }
}
