package io.hardingadonis.miu.dao.impl.mysql;

import io.hardingadonis.miu.dao.*;
import io.hardingadonis.miu.model.*;
import io.hardingadonis.miu.services.*;
import java.sql.*;
import java.util.*;

public class OrderDataDAOMySQLImpl implements OrderDataDAO {

    @Override
    public List<OrderData> getAll(int orderID) {
        List<OrderData> list = new ArrayList<>();

        try {
            Connection conn = Singleton.dbContext.getConnection();

            PreparedStatement smt = conn.prepareStatement("SELECT * FROM order_data WHERE order_id = ?");
            smt.setInt(1, orderID);

            ResultSet rs = smt.executeQuery();

            while (rs.next()) {
                int productID = rs.getInt("product_id");
                int amount = rs.getInt("amount");

                list.add(new OrderData(orderID, productID, amount));
            }

            Singleton.dbContext.closeConnection(conn);
        } catch (SQLException ex) {
            System.err.println(ex.getMessage());
        }

        return list;
    }

    @Override
    public void insert(OrderData obj) {
        try {
            Connection conn = Singleton.dbContext.getConnection();

            PreparedStatement smt = conn.prepareStatement("INSERT INTO order_data(order_id, product_id, amount) VALUES (?, ?, ?)");
            smt.setInt(1, obj.getOrderID());
            smt.setInt(2, obj.getProductID());
            smt.setInt(3, obj.getAmount());

            smt.executeUpdate();

            Singleton.dbContext.closeConnection(conn);
        } catch (SQLException ex) {
            System.err.println(ex.getMessage());
        }
    }

}