package io.hardingadonis.miu.services;

import java.sql.*;

public interface DBContext {

    public Connection getConnection();

    public void closeConnection(Connection connection);
}
