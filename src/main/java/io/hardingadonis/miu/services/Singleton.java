package io.hardingadonis.miu.services;

import io.hardingadonis.miu.dao.*;
import io.hardingadonis.miu.dao.impl.mysql.*;
import io.hardingadonis.miu.services.impl.gmail.*;
import io.hardingadonis.miu.services.impl.mysql.*;

public class Singleton {

    public static DBContext dbContext;

    public static Email email;
    
    public static AdminDAO adminDAO;
    
    public static CategoryDAO categoryDAO;
    
    public static OrderDAO orderDAO;
    
    public static OrderDataDAO orderDataDAO;
    
    public static ProductDAO productDAO;
    
    public static UserDAO userDAO;

    static {
        dbContext = new DBContextMySQLImpl();

        email = new EmailGmailImpl();
        
        adminDAO = new AdminDAOMySQLImpl();
        
        categoryDAO = new CategoryDAOMySQLImpl();
        
        orderDAO = new OrderDAOMySQLImpl();
        
        orderDataDAO = new OrderDataDAOMySQLImpl();
        
        productDAO = new ProductDAOMySQLImpl();
        
        userDAO = new UserDAOMySQLImpl();
    }
}
