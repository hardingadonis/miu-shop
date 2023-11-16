package io.hardingadonis.miu.services;

import io.hardingadonis.miu.services.impl.gmail.*;
import io.hardingadonis.miu.services.impl.mysql.*;

public class Singleton {

    public static DBContext dbContext;

    public static Email email;

    static {
        dbContext = new DBContextMySQLImpl();

        email = new EmailGmailImpl();
    }
}
