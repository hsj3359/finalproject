package com.sungjun.web.controller;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;


import java.sql.*;
import java.util.List;
import java.util.Map;

public class UserDao {
    private final JdbcTemplate jdbcTemplate;
    public UserDao(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    public int getRow(String tableName){
        String sql ="select count(*) from "+tableName;
        int rowCount =  jdbcTemplate.queryForObject(sql, Integer.class);
        return rowCount;
    }

    public User get(Integer id, String tableName) throws ClassNotFoundException, SQLException {
        Object[] params = new Object[] {id};
        String sql = "select * from "+tableName+" where id = ?";
        return jdbcTemplate.query(sql, params,rs->{
            User user = null;
            if(rs.next()){
                user = new User();
                user.setId(rs.getInt("id"));
                user.setWord(rs.getString("word"));
                user.setMean(rs.getString("mean"));
            }
            return user;
        });
    }
    public void insert(User user,String tableName) throws ClassNotFoundException, SQLException {
        Object[] params = new Object[] {user.getId(), user.getWord(),user.getMean()};
        String sql = "insert into "+ tableName +" values (?, ?, ?);";
        System.out.println(sql);
        jdbcTemplate.update(con -> {
            PreparedStatement preparedStatement = con.prepareStatement(sql);
            for (int i = 0; i < params.length; i++) {
                preparedStatement.setObject(i + 1, params[i]);
            }
            return preparedStatement;
        });
    }
    public void update(User user) throws SQLException {
        Object [] params = new Object[]{user.getWord(),user.getMean(),user.getId()};
        String sql = "update wordbook1 set word=?, mean=? where id=? ";
        jdbcTemplate.update(sql,params);
    }
    public void delete(Integer id) throws SQLException {
        Object [] params = new Object[]{id};
        String sql = "delete from wordbook1 where id=?";
        jdbcTemplate.update(sql, params);
    }

}
