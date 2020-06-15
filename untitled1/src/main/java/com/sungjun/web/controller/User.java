package com.sungjun.web.controller;

public class User {
    private Integer id;
    private String day;
    private String productName;
    private Integer amount;
    private String name;
    private String phone;
    private String adr;
    public Integer getId() {
        return this.id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getDay() {
        return this.day;
    }

    public void setDay(String day) {
        this.day = day;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public Integer getAmount() {
        return this.amount;
    }

    public void setAmount(int amount) {
        System.out.println(amount+":유저");
        this.amount = amount;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPhone() {
        return this.phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getAdr() {
        return this.adr;
    }

    public void setAdr(String adr) {
        this.adr = adr;
    }



}
