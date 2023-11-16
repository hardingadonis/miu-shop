package io.hardingadonis.miu.dao.impl.mysql;

import io.hardingadonis.miu.dao.*;
import io.hardingadonis.miu.model.*;
import io.hardingadonis.miu.services.*;
import java.sql.*;
import java.util.*;

public class CartDAOMySQLImpl implements CartDAO {

    @Override
    public List<Cart> getAll(int userID) {
        List<Cart> list = new ArrayList<>();

        try {
            Connection conn = Singleton.dbContext.getConnection();

            PreparedStatement smt = conn.prepareStatement("SELECT * FROM cart WHERE user_id = ?");
            smt.setInt(1, userID);

            ResultSet rs = smt.executeQuery();

            while (rs.next()) {
                int productID = rs.getInt("product_id");
                int amount = rs.getInt("amount");

                list.add(new Cart(userID, productID, amount));
            }

            Singleton.dbContext.closeConnection(conn);
        } catch (SQLException ex) {
            System.err.println(ex.getMessage());
        }

        return list;
    }

    @Override
    public void insert(Cart obj) {
        try {
            Connection conn = Singleton.dbContext.getConnection();

            PreparedStatement smt = conn.prepareStatement("INSERT INTO cart(user_id, product_id, amount) VALUES (?, ?, ?)");
            smt.setInt(1, obj.getUserID());
            smt.setInt(2, obj.getProductID());
            smt.setInt(3, obj.getAmount());

            smt.executeUpdate();

            Singleton.dbContext.closeConnection(conn);
        } catch (SQLException ex) {
            System.err.println(ex.getMessage());
        }
    }

    @Override
    public void update(Cart obj) {
        try {
            Connection conn = Singleton.dbContext.getConnection();

            PreparedStatement smt = conn.prepareStatement("UPDATE cart SET amount WHERE user_id = ? AND product_id = ?");
            smt.setInt(1, obj.getAmount());
            smt.setInt(2, obj.getUserID());
            smt.setInt(3, obj.getProductID());

            Singleton.dbContext.closeConnection(conn);
        } catch (SQLException ex) {
            System.err.println(ex.getMessage());
        }
    }

    @Override
    public void delete(int userID, int productID) {
        try {
            Connection conn = Singleton.dbContext.getConnection();

            PreparedStatement smt = conn.prepareStatement("DELETE FROM cart WHERE user_id = ? AND product_id = ?");
            smt.setInt(1, userID);
            smt.setInt(2, productID);

            Singleton.dbContext.closeConnection(conn);
        } catch (SQLException ex) {
            System.err.println(ex.getMessage());
        }
    }

    @Override
    public void deleteAll(int userID) {
        try {
            Connection conn = Singleton.dbContext.getConnection();

            PreparedStatement smt = conn.prepareStatement("DELETE FROM cart WHERE user_id = ?");
            smt.setInt(1, userID);

            Singleton.dbContext.closeConnection(conn);
        } catch (SQLException ex) {
            System.err.println(ex.getMessage());
        }
    }
}