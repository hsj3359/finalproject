package com.sungjun.web.controller;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.junit.jupiter.api.Test;

import java.io.IOException;
import java.sql.SQLException;

import static org.hamcrest.Matchers.greaterThan;
import static org.hamcrest.core.Is.is;
import static org.hamcrest.MatcherAssert.assertThat;

public class test {
    Integer id = 1;
    String day = "2019.02.19";
    String product = "K07";
    Integer amount = 1;
    String name = "황성준";
    String phone = "01028190710";
    String adr = "제주시 항몽로 33-1";

    @Test
    public void crowring() throws IOException {
        String url = "https://map.naver.com/v5/directions/14088861.921574574,3956243.8502921127,%EC%A0%9C%EC%A3%BC%EB%8C%80%ED%95%99%EA%B5%90%20%EC%95%84%EB%9D%BC%EC%BA%A0%ED%8D%BC%EC%8A%A4,11593449,PLACE_POI/14071439.66429289,3959316.271844862,%EC%A0%9C%EC%A3%BC%ED%8A%B9%EB%B3%84%EC%9E%90%EC%B9%98%EB%8F%84%20%EC%A0%9C%EC%A3%BC%EC%8B%9C%20%EC%95%A0%EC%9B%94%EC%9D%8D%20%ED%95%AD%EB%AA%BD%EB%A1%9C%2033-1,1411025341,ADDRESS_POI/-/car?c=14076316.0896843,3957188.3499676,12,0,0,0,dh";
        Document doc = Jsoup.connect(url).get();
        System.out.println(doc.text());
        System.out.println("-------------------------------------------------------------------------");
        System.out.println(doc.html());


    }

    @Test
    public void get() throws SQLException, ClassNotFoundException {
        System.out.println("테스트에요");
        DBConnect userDao = new DBConnect();
        User user = userDao.get(id);
        assertThat(user.getId(), is(id));
        assertThat(user.getDay(),is(day));
        assertThat(user.getProductName(), is(product));
        assertThat(user.getName(),is(name));
        assertThat(user.getAdr(),is(adr));
        assertThat(user.getAmount(), is(amount));
        assertThat(user.getPhone(), is(phone));
        System.out.println("됐음");
    }

    @Test
    public void insert() throws SQLException, ClassNotFoundException {
        User user = new User();
        user.setName(name);
        user.setProductName(product);
        user.setDay(day);
        System.out.println(amount);
        user.setAmount(amount);
        user.setPhone(phone);
        user.setAdr(adr);
        DBConnect dbConnect = new DBConnect();
        dbConnect.insert(user);

        assertThat(user.getId(),greaterThan(0));
        User insertedUser = dbConnect.get(user.getId());
        assertThat(insertedUser.getDay(),is(day));
        assertThat(insertedUser.getProductName(), is(product));
        assertThat(insertedUser.getName(),is(name));
        assertThat(insertedUser.getAdr(),is(adr));
        assertThat(insertedUser.getAmount(), is(amount));
        assertThat(insertedUser.getPhone(), is(phone));
    }

}
