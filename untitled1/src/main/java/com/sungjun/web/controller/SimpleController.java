package com.sungjun.web.controller;

import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;
import org.springframework.http.converter.json.JsonbHttpMessageConverter;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.util.*;

@RequestMapping
public class SimpleController implements Controller {
    private final UserDao userDao;
    private final TableDao tableDao;


    public SimpleController(UserDao userDao, TableDao tableDao) {
        ApplicationContext applicationContext = new AnnotationConfigApplicationContext("com.sungjun.web.controller");
        userDao = applicationContext.getBean("userDao",UserDao.class);
        tableDao = applicationContext.getBean("tableDao",TableDao.class);
        this.userDao = userDao;
        this.tableDao = tableDao;
    }
    @PostMapping(value="/requestObject")
    @ResponseBody
    public List<Map<String, Object>> simpleWithObject(@RequestBody String tableName) throws SQLException, ClassNotFoundException {
        tableName = tableName.replace("=","");
        int row = userDao.getRow(tableName);
        List<Map<String,Object>> list = new ArrayList<Map<String, Object >>();
        for(int i=1; i<row+1; i++){
            User user = userDao.get(i);
            Map<String, Object> tamp = new HashMap<String,Object>();
            tamp.put("word",user.getWord());
            tamp.put("mean",user.getMean());
            System.out.println(tamp);
            list.add(tamp);
        }
        for(int i=0; i<list.size(); i++){
            System.out.println(list.get(1));
        }
        return list;
    }
    @Override
    public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
        ModelAndView modelAndView = new ModelAndView("user");
        List<String> tableList = tableDao.getTableList();
        modelAndView.addObject("tableList",tableList);
        return modelAndView;
    }
}
