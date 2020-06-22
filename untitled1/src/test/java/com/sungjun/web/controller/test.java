package com.sungjun.web.controller;

import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import static org.hamcrest.core.Is.is;
import static org.hamcrest.MatcherAssert.assertThat;

public class test {
    Integer id = 1;
    String word = "word";
    String mean = "단어";
    private static UserDao userDao;
    private static TableDao tableDao;

    @BeforeAll
    public static void setup() throws ClassNotFoundException {
        ApplicationContext applicationContext = new AnnotationConfigApplicationContext("com.sungjun.web.controller");
        userDao = applicationContext.getBean("userDao",UserDao.class);
        tableDao = applicationContext.getBean("tableDao",TableDao.class);
    }

    @Test
    public void get() throws SQLException, ClassNotFoundException {
        int row = userDao.getRow("wordbook1")+1;
        for(int i=1; i<row; i++){
            User user = userDao.get(i);
            assertThat(user.getId(), is(i));
            System.out.println(user.getId());
            System.out.println(user.getWord());
            System.out.println(user.getMean());
        }

    }
//
//    @Test
//    public void insert() throws SQLException, ClassNotFoundException {
//        User user = new User();
//        user.setMean(mean);
//        user.setWord(word);
//        userDao.insert(user);
//        assertThat(user.getId(),greaterThan(0));
//        User insertedUser = userDao.get(user.getId());
//        assertThat(insertedUser.getWord(),is(word));
//        assertThat(insertedUser.getMean(), is(mean));
//    }
//
//    @Test
//    public void update() throws SQLException, ClassNotFoundException {
//        User user = new User();
//        user.setMean(mean);
//        user.setWord(word);
//        userDao.insert(user);
//        String updatedMean = "일하다";
//        String updatedWord = "work";
//        user.setWord(updatedWord);
//        user.setMean(updatedMean);
//        userDao.update(user);
//        User updatedUser = userDao.get(user.getId());
//        assertThat(updatedUser.getWord(), is(updatedWord));
//        assertThat(updatedUser.getMean(), is(updatedMean));
//    }
//    @Test
//    public void delete() throws SQLException, ClassNotFoundException {
//        User user = new User();
//        user.setMean(mean);
//        user.setWord(word);
//        userDao.insert(user);
//        userDao.delete(user.getId());
//        User deletedUser = userDao.get(user.getId());
//        assertThat(deletedUser, IsNull.nullValue());
//    }
    @Test
    public void makeTable() throws SQLException, ClassNotFoundException {
        tableDao.createTable("wordbook1");
    }
    @Test
    public void deleteTable() throws SQLException, ClassNotFoundException {
        String tableName = "wordbook20200617144344";
        tableDao.deleteTable(tableName);
    }
    @Test
    public void getTable() throws SQLException {
        List<String> tableList = new ArrayList<>();
        tableList = tableDao.getTableList();
        for(int i=0; i<tableList.size(); i++){
            System.out.println(tableList.get(i));
        }
    }
    @Test
    public void getTableData() throws SQLException, ClassNotFoundException {
        List<String> tableData = new ArrayList<>();
        tableData = tableDao.getTableData("wordbook1");
    }
}
