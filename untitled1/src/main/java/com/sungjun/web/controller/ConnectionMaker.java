package com.sungjun.web.controller;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public interface ConnectionMaker {
   public Connection getConnection() throws ClassNotFoundException, SQLException;
   //{
//        Class.forName("com.mysql.cj.jdbc.Driver");
//        return DriverManager.getConnection("jdbc:mysql://localhost/final?serverTimezone=Asia/Seoul"
//                , "root", "tjdwns960@");
//    }
}