package com.sungjun.web.controller;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class DeleteTableStatementStrategy implements StatementStrategy {
    @Override
    public PreparedStatement makeStatement(Object object, Connection connection) throws SQLException {
        String tableName = (String)object;
        PreparedStatement preparedStatement = connection.prepareStatement("drop table "+tableName+";");
        return preparedStatement;
    }
}
