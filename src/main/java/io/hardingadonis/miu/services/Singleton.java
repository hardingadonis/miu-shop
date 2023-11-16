package io.hardingadonis.miu.services;

import io.hardingadonis.miu.dao.*;
import io.hardingadonis.miu.dao.impl.mysql.*;
import io.hardingadonis.miu.services.impl.gmail.*;
import io.hardingadonis.miu.services.impl.mysql.*;

public class Singleton {

    public static DBContext dbContext;

    public static Email email;
    
    public static AdminDAO adminDAO;
    
    public static CartDAO cartDAO;
    
    public static CategoryDAO categoryDAO;
    
    public static OrderDAO orderDAO;
    
    public static UserDAO userDAO;

    static {
        dbContext = new DBContextMySQLImpl();

        email = new EmailGmailImpl();
        
        adminDAO = new AdminDAOMySQLImpl();
        
        cartDAO = new CartDAOMySQLImpl();
        
        categoryDAO = new CategoryDAOMySQLImpl();
        
        orderDAO = new OrderDAOMySQLImpl();
        
        userDAO = new UserDAOMySQLImpl();
    }
}
