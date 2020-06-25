package com.sungjun.web.controller;

import org.springframework.jdbc.core.metadata.TableMetaDataContext;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class TableDao {
    private static JdbcContext jdbcContext = null;
    public TableDao(JdbcContext jdbcContext) {
        this.jdbcContext = jdbcContext;
    }

    public void createTable(String tableName) throws SQLException, ClassNotFoundException {
        String sql = "CREATE TABLE " + tableName + " ( \n" +
                "id INT PRIMARY KEY AUTO_INCREMENT, \n" +
                "word VARCHAR(20), \n" +
                "mean VARCHAR(80) \n" +
                ") ENGINE=INNODB; ";
        TableDao.jdbcContext.table(sql);
    }

    public void deleteTable(String tableName) throws SQLException, ClassNotFoundException {
        String sql = "drop table " + tableName + ";";
        TableDao.jdbcContext.table(sql);

    }
    public List<String> getTableData(String tableName) throws ClassNotFoundException, SQLException {
        List<String> table = new ArrayList<>();
        String sql = "select * from " + tableName + ";";
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection connection = DriverManager.getConnection("jdbc:mysql://localhost/final?serverTimezone=Asia/Seoul","root","tjdwns960@");
        PreparedStatement preparedStatement = connection.prepareStatement(sql);
        ResultSet resultSet = preparedStatement.executeQuery();
        resultSet.next();
        resultSet.close();
        preparedStatement.close();
        connection.close();
        return table;
    }
    public List<String> getTableList() throws SQLException {
        List<String> tableList = TableDao.jdbcContext.jdbcContextForTable();
        return tableList;
    }
}