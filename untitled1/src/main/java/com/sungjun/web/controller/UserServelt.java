package com.sungjun.web.controller;


import javax.servlet.*;
import java.io.IOException;

public class UserServelt extends GenericServlet {
    @Override
    public void destroy() {
        System.out.println("destroy");
        super.destroy();
    }
    @Override
    public void service(ServletRequest req, ServletResponse res) throws ServletException, IOException {
        System.out.println("service");
    }
    @Override
    public void init(ServletConfig config) throws ServletException {
        System.out.println("inti");
        super.init(config);

    }
}
