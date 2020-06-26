package com.sungjun.web.controller;

import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;
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

    @PostMapping(value = "/createTable")
    @ResponseBody
    public boolean CreateName(@RequestBody String tableName) throws SQLException, ClassNotFoundException {
        String name = tableName.replace("=","");
        List<String> tableList = tableDao.getTableList();
        for(int i=0; i<tableList.size(); i++){
            if(tableList.get(i)==name)return false;
        }
        tableDao.createTable(name);
        return true;
    }

    @PostMapping(value = "/updateData")
    @ResponseBody
    public void updateData(@RequestBody Map<String, Object[]> data) throws SQLException, ClassNotFoundException {
        User user = new User();
        user.setId((Integer) data.get("data")[0]);
        user.setWord((String) data.get("data")[1]);
        user.setMean((String) data.get("data")[2]);
        userDao.update(user,(String)data.get("table")[0]);
        return;
    }

    @PostMapping(value = "/deleteData")
    @ResponseBody
    public void deleteData(@RequestBody Map<String, Object> data) throws SQLException, ClassNotFoundException {
        User user = new User();
        Integer id = (Integer) data.get("id");
        user.setId((Integer) data.get("id"));
        userDao.delete(user.getId(),(String)data.get("table"));
        return;
    }

    @PostMapping(value = "/createData")
    @ResponseBody
    public void CreateData(@RequestBody Map<String, Object[]> data) throws SQLException, ClassNotFoundException {
        User user = new User();
        user.setId((Integer) data.get("data")[0]);
        user.setWord((String) data.get("data")[1]);
        user.setMean((String) data.get("data")[2]);
        userDao.insert(user,(String)data.get("table")[0]);
        return;
    }

    @PostMapping(value="/deleteTable")
    @ResponseBody
    public void deleteTable(@RequestBody String tableName) throws SQLException, ClassNotFoundException {
        tableName = tableName.replace("=","").replace("+","");
        tableDao.deleteTable(tableName);
        return ;
    }

    @PostMapping(value="/sendData")
    @ResponseBody
    public List<Map<String, Object>> sendTableData(@RequestBody String tableName) throws SQLException, ClassNotFoundException {
        tableName = tableName.replace("=","");
        List<Map<String, Object>> dataList = new ArrayList<>();
        int row = userDao.getRow(tableName)+1;
        for(int i=1; i<row; i++){
            User user = userDao.get(i,tableName);
            if(user !=null){
                Map<String, Object> tampMap = new HashMap<>();
                tampMap.put("word",user.getWord());
                tampMap.put("mean",user.getMean());
                dataList.add(tampMap);
            }
        }
        return dataList;
    }


    @Override
    public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
        ModelAndView modelAndView = new ModelAndView("user");
        List<String> tableList = tableDao.getTableList();
        modelAndView.addObject("tableList",tableList);
        return modelAndView;
    }
}
