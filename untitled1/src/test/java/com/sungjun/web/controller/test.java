package com.sungjun.web.controller;

import org.hamcrest.core.IsNull;
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
        User user = userDao.get(id);
        assertThat(user.getId(), is(id));
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
    public void update() throws SQLException, ClassNotFoundException {
        User user = new User();
        user.setMean(mean);
        user.setWord(word);
        userDao.insert(user);
        String updatedMean = "일하다";
        String updatedWord = "work";
        user.setWord(updatedWord);
        user.setMean(updatedMean);
        userDao.update(user);
        User updatedUser = userDao.get(user.getId());
        assertThat(updatedUser.getWord(), is(updatedWord));
        assertThat(updatedUser.getMean(), is(updatedMean));
    }
    @Test
    public void delete() throws SQLException, ClassNotFoundException {
        User user = new User();
        user.setMean(mean);
        user.setWord(word);
        userDao.insert(user);
        userDao.delete(user.getId());
        User deletedUser = userDao.get(user.getId());
        assertThat(deletedUser, IsNull.nullValue());
    }
    @Test
    public void makeTable() throws SQLException, ClassNotFoundException {
        MakeTime makeTime = new MakeTime();
        String mTime = makeTime.getTime();
        userDao.createTable(mTime);
    }
    @Test
    public void deleteTable() throws SQLException, ClassNotFoundException {
        String tableName = "wordbook1";
        userDao.deleteTable(tableName);
    }
    @Test
    public void getTable() throws SQLException {
        userDao.getTable();
    }
}
