package com.sungjun.web.controller;
import javax.swing.plaf.nimbus.State;
import java.lang.System;
import java.sql.*;

public class DBConnect {
    public User get(Integer id) throws ClassNotFoundException, SQLException {
        System.out.println("클래스");
        //데이터는 어디에 있지? => mysql
        //mysql driver 로딩
        Class.forName("com.mysql.cj.jdbc.Driver");
        System.out.println("드라이버 블러옴");
        //connection 맺고
        Connection connection = DriverManager.getConnection("jdbc:mysql://localhost/final?serverTimezone=Asia/Seoul"
                , "root", "tjdwns960@");
        System.out.println("서버접속");
        //query 만들고
        PreparedStatement preparedStatement =
                connection.prepareStatement("select * from productorder where id = ?");
        preparedStatement.setInt(1, id);
        //query 실행하고
        ResultSet rs = preparedStatement.executeQuery();
        rs.next();
        //결과를 User 잘 매핑하고
        User user = new User();
        user.setId(rs.getInt("id"));
        user.setDay(rs.getString("day"));
        user.setProductName(rs.getString("productName"));
        user.setAmount(rs.getInt("amount"));
        user.setName(rs.getString("name"));
        user.setPhone(rs.getString("phone"));
        user.setAdr(rs.getString("adr"));
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
        Class.forName("com.mysql.cj.jdbc.Driver");
        //connection 맺고
        Connection connection = DriverManager.getConnection("jdbc:mysql://localhost/final?serverTimezone=Asia/Seoul"
                , "root", "tjdwns960@");
        System.out.println("서버접속");
        //query 만들고
        PreparedStatement preparedStatement =
                connection.prepareStatement("INSERT INTO productorder (day,productName, amount, name, phone, adr) VALUES (?,?,?,?,?,?);", Statement.RETURN_GENERATED_KEYS);
        preparedStatement.setString(1, user.getDay());
        System.out.println("1");
        preparedStatement.setString(2, user.getProductName());
        System.out.println("2");

        System.out.println(user.getAmount());
        preparedStatement.setInt(3, user.getAmount());
        System.out.println("3");

        preparedStatement.setString(4, user.getName());
        System.out.println("4");

        preparedStatement.setString(5, user.getPhone());
        System.out.println("5");

        preparedStatement.setString(6, user.getAdr());
        System.out.println("6");

        preparedStatement.executeUpdate();
        ResultSet resultSet = preparedStatement.getGeneratedKeys();
        resultSet.next();
        user.setId(resultSet.getInt(1));
        resultSet.close();
        preparedStatement.close();
        connection.close();

    }



}
