package com.sungjun.web.controller;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class MakeTableStatementStrategy implements StatementStrategy {
    @Override
    public PreparedStatement makeStatement(Object object, Connection connection) throws SQLException {
        String mTime = (String) object;
        PreparedStatement preparedStatement = connection.prepareStatement("CREATE TABLE wordbook"+ mTime+" ( \n" +
                "id INT PRIMARY KEY AUTO_INCREMENT, \n" +
                "word VARCHAR(12), \n" +
                "mean VARCHAR(80) \n" +
                ") ENGINE=INNODB; ");
        return preparedStatement;
    }
}
