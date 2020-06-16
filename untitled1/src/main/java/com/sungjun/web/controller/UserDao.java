package com.sungjun.web.controller;
import javax.sql.DataSource;
import java.lang.System;
import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.Locale;
import java.util.Date;

public class UserDao {
    private final DataSource datasource;

    public UserDao(DataSource dataSource) {
        this.datasource = dataSource;
    }


    public User get(Integer id) throws ClassNotFoundException, SQLException {

        Connection connection = datasource.getConnection();
        //query 만들고
        PreparedStatement preparedStatement =
                connection.prepareStatement("select * from wordbook1 where id = ?");
        preparedStatement.setInt(1, id);
        //query 실행하고
        ResultSet rs = preparedStatement.executeQuery();
        rs.next();
        //결과를 User 잘 매핑하고
        User user = new User();
        user.setId(rs.getInt("id"));
        user.setWord(rs.getString("word"));
        user.setMean(rs.getString("mean"));
        //자원을 해지하고
        rs.close();
        preparedStatement.close();
        connection.close();
        //결과를 리턴
        return user;
    }


    public void insert(User user) throws ClassNotFoundException, SQLException {
        //데이터는 어디에 있지? => mysql
        //mysql driver 로딩
        Connection connection = datasource.getConnection();
        System.out.println("서버접속");
        //query 만들고
        PreparedStatement preparedStatement =
                connection.prepareStatement("INSERT INTO wordbook (word,mean) VALUES (?,?);", Statement.RETURN_GENERATED_KEYS);
        preparedStatement.setString(1, user.getWord());
        System.out.println("1");
        preparedStatement.setString(2, user.getMean());
        System.out.println("2");
        preparedStatement.executeUpdate();
        ResultSet resultSet = preparedStatement.getGeneratedKeys();
        resultSet.next();
        user.setId(resultSet.getInt(1));
        resultSet.close();
        preparedStatement.close();
        connection.close();

    }


    public void createTable() throws SQLException, ClassNotFoundException {
        SimpleDateFormat mSimpleDateFormat = new SimpleDateFormat ( "yyyyMMddHHmmss", Locale.KOREA );
        Date currentTime= new Date();
        String mTime = mSimpleDateFormat.format ( currentTime );
        System.out.println(mTime);
        Connection connection = datasource.getConnection();
        PreparedStatement preparedStatement = connection.prepareStatement("CREATE TABLE wordbook"+ mTime+" ( \n" +
                "id INT PRIMARY KEY AUTO_INCREMENT, \n" +
                "word VARCHAR(12), \n" +
                "mean VARCHAR(80) \n" +
                ") ENGINE=INNODB; ");
        preparedStatement.executeUpdate();
        preparedStatement.close();
        connection.close();
    }

    public void deleteTable(String tableName) throws SQLException, ClassNotFoundException {
        Connection connection = datasource.getConnection();
        PreparedStatement preparedStatement = connection.prepareStatement("drop table "+tableName+";");
        preparedStatement.executeUpdate();
        preparedStatement.close();
        connection.close();
    }



}
