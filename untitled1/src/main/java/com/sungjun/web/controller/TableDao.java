package com.sungjun.web.controller;

import org.springframework.jdbc.core.JdbcTemplate;

import java.sql.SQLException;

public class TableDao {
    private static JdbcContext jdbcContext = null;
    public TableDao(JdbcContext jdbcContext) {
        this.jdbcContext = jdbcContext;
    }

    public void createTable(String mTime) throws SQLException, ClassNotFoundException {
        String sql = "CREATE TABLE wordbook" + mTime + " ( \n" +
                "id INT PRIMARY KEY AUTO_INCREMENT, \n" +
                "word VARCHAR(12), \n" +
                "mean VARCHAR(80) \n" +
                ") ENGINE=INNODB; ";
        TableDao.jdbcContext.table(sql);
    }

    public void deleteTable(String tableName) throws SQLException, ClassNotFoundException {
        String sql = "drop table " + tableName + ";";
        TableDao.jdbcContext.table(sql);

    }

    public void getTable() throws SQLException {
        TableDao.jdbcContext.jdbcContextForTable();
    }
}