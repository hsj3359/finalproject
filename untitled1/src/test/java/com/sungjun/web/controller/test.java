package com.sungjun.web.controller;

import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;

import java.sql.SQLException;

import static org.hamcrest.Matchers.greaterThan;
import static org.hamcrest.core.Is.is;
import static org.hamcrest.MatcherAssert.assertThat;

public class test {
    Integer id = 1;
    String word = "word";
    String mean = "단어";
    private static UserDao userDao;

    @BeforeAll
    public static void setup(){
        ApplicationContext applicationContext = new AnnotationConfigApplicationContext(DaoFactory.class);
        userDao = applicationContext.getBean("userDao",UserDao.class);
    }
    @Test
    public void get() throws SQLException, ClassNotFoundException {
        System.out.println("테스트에요");
        User user = userDao.get(id);
        assertThat(user.getId(), is(id));
        System.out.println("됐음");
    }

    @Test
    public void insert() throws SQLException, ClassNotFoundException {
        User user = new User();
        user.setMean(mean);
        user.setWord(word);


        userDao.insert(user);
        assertThat(user.getId(),greaterThan(0));

        User insertedUser = userDao.get(user.getId());
        assertThat(insertedUser.getWord(),is(word));
        assertThat(insertedUser.getMean(), is(mean));
    }
    @Test
    public void makeTable() throws SQLException, ClassNotFoundException {
        userDao.createTable();

    }
    @Test
    public void deleteTable() throws SQLException, ClassNotFoundException {
        String tableName = "wordbook";
        userDao.deleteTable(tableName);

    }

}
